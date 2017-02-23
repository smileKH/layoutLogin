//
//  MainViewController.m
//  AutoLogin
//
//  Created by aplle on 16/1/13.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH-200, 40)];
    label.text  = @"主界面";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    UIButton *canceBt = [[UIButton alloc]initWithFrame:CGRectMake(50, 300,SCREEN_WIDTH -100, 50)];
    
    [canceBt setTitle:@"注销账号" forState:UIControlStateNormal];
    [canceBt setBackgroundImage:[UIImage imageNamed:@"mm_nav"] forState:UIControlStateNormal];
    [canceBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    canceBt.titleLabel.font = [UIFont systemFontOfSize:20];
    [canceBt addTarget:self action:@selector(canceLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canceBt];
    
}
//注销登录
-(void)canceLogin{

    //此处为网络请求部分
    //模拟注销
    [LoginManage sharedManager].loginState = 0;
    [[LoginManage sharedManager] judgeLoginState];
    
    //获取账号信息
    NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults] objectForKey:AUTOLOGIN];
    NSString *account = [accountDic objectForKey:ACCOUNT];
    if (account == nil) {
        account = @"";
    }
    
    //保存账号，不保存密码
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:account,ACCOUNT,@"",PASSWORD, nil];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:AUTOLOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
