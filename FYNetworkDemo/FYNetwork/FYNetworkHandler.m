//
//  FYNetworkHandler.m
//  FYNetworkDemo
//
//  Created by fangYong on 2017/12/8.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "FYNetworkHandler.h"
#import "FYAFNetworkingClient.h"

@implementation FYNetworkHandler

static FYNetworkHandler *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (void)sendRequestWithURLString:(NSString *)URLString params:(NSDictionary *)params isEncrypt:(BOOL)isEncrypt success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    
    [FYAFNetworkingClient GET:nil params:params success:^(NSURLSessionDataTask *task, id responseObject) {

    } fail:^(NSURLSessionDataTask *task, NSError *error) {

    }];
   
}

- (void)networkMockWithApiName:(NSString *)apiName success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    
    NSString *url = [[NSString stringWithFormat:@"%@?where={\"apiName\":\"%@\"}", @"https://leancloud.cn:443/1.1/classes/HXAPPNetworkMOCK", apiName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [FYAFNetworkingClient MOCKGET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end
