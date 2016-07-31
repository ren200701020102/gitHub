//
//  ViewController2.m
//  隐藏导航栏
//
//  Created by 任海平 on 16/7/30.
//  Copyright © 2016年 任海平. All rights reserved.
//

#import "ViewController2.h"
#import <Masonry.h>

@interface ViewController2 ()

@property (nonatomic, assign) BOOL interacting;

@property (nonatomic, assign) BOOL shouldComplete;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *navView = [[UIView alloc]init];
    navView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.6];
    CGRect frame = self.navigationController.navigationBar.bounds;
    frame.size.height = frame.size.height+20;
    navView.frame = frame;
    [self.view addSubview:navView];
//    self.navigationController.navigationBarHidden = YES;
    
    //增加3个按钮
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"第二个";
    [navView addSubview:titleLabel];
    [titleLabel sizeToFit];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(navView).with.offset(-10);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [popBtn setTitle:@"上一个" forState:UIControlStateNormal];
    [popBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [popBtn sizeToFit];
    [navView addSubview:popBtn];
    [popBtn addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchDown];
    
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(navView).with.offset(10);
        make.centerY.mas_equalTo(titleLabel);
    }];

    
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(-2, 0);
    self.view.layer.shadowOpacity = 0.6;
}

- (void) previous{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)dealloc{
    NSLog(@"two销毁了");
}

@end
