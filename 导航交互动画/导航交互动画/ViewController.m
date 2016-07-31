//
//  ViewController.m
//  隐藏导航栏
//
//  Created by 任海平 on 16/7/30.
//  Copyright © 2016年 任海平. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import <Masonry.h>
#import "ViewController2.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIViewControllerTransitioningDelegate
    
    int count;
    
    __unsafe_unretained  Protocol ** protocolItems = class_copyProtocolList([self class], &count);
    
    for (int i=0; i<count; i++) {
        Protocol *protocol = protocolItems[i];
        
        NSLog(@"%@",[ NSString stringWithCString:protocol_getName(protocol) encoding:NSUTF8StringEncoding]);
    }
    
    UIView *navView = [[UIView alloc]init];
    navView.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.6];
    CGRect frame = self.navigationController.navigationBar.bounds;
    frame.size.height = frame.size.height+20;
    navView.frame = frame;
    [self.view addSubview:navView];
    self.navigationController.navigationBarHidden = YES;
    
    //增加3个按钮
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"第一个";
    [navView addSubview:titleLabel];
    [titleLabel sizeToFit];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView).with.offset(-10);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [pushBtn setTitle:@"下一个" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushBtn sizeToFit];
    [navView addSubview:pushBtn];
    [pushBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    
    [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(navView).with.offset(-10);
        make.centerY.mas_equalTo(titleLabel);
    }];
    
}

- (void)next{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController2 *twoVC = [sb instantiateViewControllerWithIdentifier:@"twoVC"];
    [self.navigationController pushViewController:twoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
