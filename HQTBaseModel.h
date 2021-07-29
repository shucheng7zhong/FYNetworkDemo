//
//  HQTBaseModel.h
//  HXHQT
//
//  Created by wangyan on 2017/1/3.
//  Copyright © 2017年 wangyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQTBaseViewController.h"

@class HQTBaseModel;
typedef void (^ModelSuccess)(__kindof HQTBaseModel *model);
typedef void (^ModelFailure)(HQTError *error);

@protocol HQTModelProtocal <NSObject>

@required
- (__kindof HQTBaseModel *)deserialize:(id)data;

- (__kindof HQTBaseModel *)dataValidate:(__kindof HQTBaseModel *)model;

- (NSString *)urlString;

- (BOOL)isEncrypt;

@optional
- (NSArray<NSString *> *)childHandleErrorCodeArray;

- (HQTError *)handleWithErrorCode:(NSString *)errorCode
                             data:(id)data
                     errorMessage:(NSString *)errorMssage
                   viewController:(HQTBaseViewController *)viewController;
@end

@interface HQTBaseModel : NSObject

- (void)loadDataFromNetWorkWithParams:(nullable NSDictionary *)params
                currentViewController:(nullable HQTBaseViewController *)viewController
                              success:(nullable ModelSuccess)success
                              failure:(nullable ModelFailure)failure;

@end
