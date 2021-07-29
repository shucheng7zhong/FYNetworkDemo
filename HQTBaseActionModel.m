//
//  HQTBaseActionModel.m
//  HXHQT
//
//  Created by wangyan on 2017/1/10.
//  Copyright © 2017年 China Asset Management Co., Ltd. All rights reserved.
//

#import "HQTBaseActionModel.h"
#import "HQTNetworkHandler.h"
#import "HQTBaseErrorHandler.h"
#import "HQTErrorHanlerFactory.h"

@interface HQTBaseActionModel()

@property (weak, nonatomic) id<HQTActionModelProtocal> child;

@end

@implementation HQTBaseActionModel

- (instancetype)init {
    
    self = [super init];
    if ([self conformsToProtocol:@protocol(HQTActionModelProtocal)]) {
        
        self.child = (id<HQTActionModelProtocal>)self;
    }else {
        
        NSAssert(NO, @"子类必须服从<HQTActionModelProtocal>协议");
    }
    return self;
}

- (void)doActionWithParams:(NSDictionary *)params currentViewController:(HQTBaseViewController *)viewController success:(ActionSuccess)success failure:(ActionFailure)failure {
    
    __weak __typeof(viewController) weakViewController = viewController;
    [[HQTNetworkHandler sharedInstance] sendRequestWithURLString:[self.child urlString] params:params isEncrypt:[self.child isEncrypt] success:^(id responseObject) {
        
        if(success)
            success();
        
    } failure:^(id data, NSString *errorCode, NSString *errorMsg) {
        
        if(failure)//!!!传入的是weak的controller，注意判空使用！！！
            failure([self commonHandleWithErrorCode:errorCode data:data errorMessage:errorMsg viewController:weakViewController]);
    }];
}

- (HQTError *)commonHandleWithErrorCode:(NSString *)errorCode
                                   data:(id)data
                           errorMessage:(NSString *)errorMssage
                         viewController:(HQTBaseViewController *)viewController {
    
    if([self.child respondsToSelector:@selector(childHandleErrorCodeArray)] && [self.child respondsToSelector:@selector(handleWithErrorCode:data:errorMessage:viewController:)]) {
        
        NSArray<NSString *> *errorCodeArray = [self.child childHandleErrorCodeArray];
        if(![HXTools isBlankArray:errorCodeArray] && [errorCodeArray containsObject:errorCode]) {
            
            return [self.child handleWithErrorCode:errorCode data:data errorMessage:errorMssage viewController:viewController];
        }
        else {
            
            HQTBaseErrorHandler *errorHandler = [[HQTErrorHanlerFactory sharedInstance] createErrorHandlerByErrorCode:errorCode];
            return [errorHandler handleErrorWithData:data errorMessage:errorMssage viewController:viewController];
        }
    }else {
        
        HQTBaseErrorHandler *errorHandler = [[HQTErrorHanlerFactory sharedInstance] createErrorHandlerByErrorCode:errorCode];
        return [errorHandler handleErrorWithData:data errorMessage:errorMssage viewController:viewController];
    }
}

@end
