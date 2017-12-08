//
//  FYAFNetworkingClient.h
//  FYNetworkDemo
//
//  Created by fangYong on 2017/12/8.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/**
 *  请求成功所走方法
 *
 *  @param responseObject 请求返还的数据
 */
typedef void (^ResponseSuccess)(NSURLSessionDataTask * task,id responseObject);

/**
 *  请求错误所走方法
 *
 *  @param error 请求错误返还的信息
 */
typedef void (^ResponseFail)(NSURLSessionDataTask * task, NSError * error);


@interface FYAFNetworkingClient : NSObject

/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(ResponseSuccess)success
       fail:(ResponseFail)fail;


/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(ResponseSuccess)success
        fail:(ResponseFail)fail;

/**
 *  MOCK get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)MOCKGET:(NSString *)url
         params:(NSDictionary *)params
        success:(ResponseSuccess)success
           fail:(ResponseFail)fail;
@end
