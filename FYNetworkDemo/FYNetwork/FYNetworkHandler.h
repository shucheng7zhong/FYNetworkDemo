//
//  FYNetworkHandler.h
//  FYNetworkDemo
//
//  Created by fangYong on 2017/12/8.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpRequestSuccess)(id responseObject);
typedef void(^HttpRequestFailure)(id responseObject);
typedef void (^RequestPublicKeyComplication)(NSString *errorCode);

@interface FYNetworkHandler : NSObject

+ (instancetype)shareInstance;

- (void)sendRequestWithURLString:(NSString *)URLString params:(NSDictionary *)params isEncrypt:(BOOL)isEncrypt success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

- (void)networkMockWithApiName:(NSString *)apiName success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

@end
