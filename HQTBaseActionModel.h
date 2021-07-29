//
//  HQTBaseActionModel.h
//  HXHQT
//
//  Created by wangyan on 2017/1/10.
//  Copyright © 2017年 China Asset Management Co., Ltd. All rights reserved.
//

#import "HQTBaseModel.h"

typedef void (^ActionSuccess)();
typedef void (^ActionFailure)(HQTError *error);

@protocol HQTActionModelProtocal <NSObject>

@required
- (NSString *)urlString;

- (BOOL)isEncrypt;

@optional
- (NSArray<NSString *> *)childHandleErrorCodeArray;

- (HQTError *)handleWithErrorCode:(NSString *)errorCode
                             data:(id)data
                     errorMessage:(NSString *)errorMssage
                   viewController:(HQTBaseViewController *)viewController;

@end

@interface HQTBaseActionModel : NSObject

- (void)doActionWithParams:(nullable NSDictionary *)params
     currentViewController:(nullable HQTBaseViewController *)viewController
                   success:(nullable ActionSuccess)success
                   failure:(nullable ActionFailure)failure;

@end
