//
//  ViewController.m
//  FYNetworkDemo
//
//  Created by fangYong on 2017/12/8.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "ViewController.h"
#import "FYNetworkHandler.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatContentView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)creatContentView {
    
    UIButton *sendRequestBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100, [UIScreen mainScreen].bounds.size.height/2 - 50, 200, 100)];
    [self.view addSubview:sendRequestBtn];
    sendRequestBtn.backgroundColor = [UIColor blueColor];
    [sendRequestBtn setTitle:@"请求啦" forState:UIControlStateNormal];
    [sendRequestBtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)requestData {
    
//    [[FYNetworkHandler shareInstance] sendRequestWithURLString:nil params:nil isEncrypt:NO success:^(id responseObject) {
//
//    } failure:^(id responseObject) {
//
//    }];
    
    [[FYNetworkHandler shareInstance] networkMockWithApiName:@"ranking" success:^(id responseObject) {
        
    } failure:^(id responseObject) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
