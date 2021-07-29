//
//  HQTBaseModel.m
//  HXHQT
//
//  Created by wangyan on 2017/1/3.
//  Copyright © 2017年 wangyan. All rights reserved.
//

#import "HQTBaseModel.h"
#import "HQTNetworkHandler.h"
#import "HQTErrorHanlerFactory.h"
#import "HQTBaseErrorHandler.h"
#import "HQTNetworkRecordHandler.h"
@interface HQTBaseModel()

@property (weak, nonatomic) id<HQTModelProtocal> child;

@end

@implementation HQTBaseModel

- (instancetype)init {
    
    self = [super init];
    if ([self conformsToProtocol:@protocol(HQTModelProtocal)]) {
        
        self.child = (id<HQTModelProtocal>)self;
    }else {
        
        NSAssert(NO, @"子类必须服从<HQTModelProtocal>协议");
    }
    return self;
}

- (void)loadDataFromNetWorkWithParams:(NSDictionary *)params currentViewController:(HQTBaseViewController *)viewController success:(ModelSuccess)success failure:(ModelFailure)failure {
    
    __weak __typeof(viewController) weakViewController = viewController;
    [[HQTNetworkHandler sharedInstance] sendRequestWithURLString:[self.child urlString] params:params isEncrypt:[self.child isEncrypt] success:^(id responseObject) {
#ifdef PRODUCTION_ENVIRONMENT
        //生产环境
#else
        //测试
        NSString *vcName = NSStringFromClass([viewController class]);
        NSString *modelName = NSStringFromClass([self.child class]);
        [[HQTNetworkRecordHandler shareInstance] insertRecordWithPageName:![HXTools isBlankString:vcName] ? vcName:modelName
                                                urlString:[self.child urlString]
                                                   params:params
                                                  content:responseObject
                                               resultCode:@"0000"];
#endif
        
        __kindof HQTBaseModel *model = [self.child deserialize:responseObject];
        model = [self.child dataValidate:model];
        
        if(model != nil) {
            
            if(success)
                success(model);
        }
        else {
            
            HQTError *error = [[HQTError alloc] initWithErrorType:HQTErrorTypeDataValidateFail];
            if(failure)
               failure(error);
        }
        
    } failure:^(id data, NSString *errorCode, NSString *errorMsg) {
#ifdef PRODUCTION_ENVIRONMENT
        //生产环境
#else
        //测试
        NSString *vcName = NSStringFromClass([viewController class]);
        NSString *modelName = NSStringFromClass([self.child class]);
        [[HQTNetworkRecordHandler shareInstance] insertRecordWithPageName:![HXTools isBlankString:vcName] ? vcName:modelName
                                                urlString:[self.child urlString]
                                                   params:params
                                                  content:errorMsg
                                               resultCode:errorCode];

#endif
        
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
