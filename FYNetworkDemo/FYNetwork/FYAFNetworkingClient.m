//
//  FYAFNetworkingClient.m
//  FYNetworkDemo
//
//  Created by fangYong on 2017/12/8.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "FYAFNetworkingClient.h"

@implementation FYAFNetworkingClient

+(void)GET:(NSString *)url params:(NSDictionary *)params success:(ResponseSuccess)success fail:(ResponseFail)fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = (NSDictionary *)responseObject;
        if (dic == nil) {
            NSError *error = [NSError errorWithDomain:@"NSURLErrorDomain" code:-1009 userInfo:nil];
            fail(task, error);
        } else {
            success(task,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
    
}


+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(ResponseSuccess)success fail:(ResponseFail)fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = (NSDictionary *)responseObject;
        if (dic == nil) {
            NSError *error = [NSError errorWithDomain:@"NSURLErrorDomain" code:-1009 userInfo:nil];
            fail(task, error);
        } else {
            success(task,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}

//+ (id)responseConfiguration:(id)responseObject {
//
//    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    if (data) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        return dic;
//    }
//    else {
//        return nil;
//    }
//
//}

+ (void)MOCKGET:(NSString *)url params:(NSDictionary *)params
        success:(ResponseSuccess)success fail:(ResponseFail)fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"CPc8KfPbLa28Emx3VlM6rREj-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"gILYLu9KwykWDGn0uygI3R09" forHTTPHeaderField:@"X-LC-Key"];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = (NSDictionary *)responseObject;
        if (dic == nil) {
            NSError *error = [NSError errorWithDomain:@"NSURLErrorDomain" code:-1009 userInfo:nil];
            fail(task, error);
        } else {
            success(task,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}


@end
