//
//  LoginManage.m
//  AutoLogin
//
//  Created by aplle on 16/1/13.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import "LoginManage.h"
#import "LoginViewController.h"

@implementation LoginManage


+(instancetype)sharedManager{

    static LoginManage *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedManager = [[LoginManage alloc]init];
    });
    return _sharedManager;
}

//判断登录状态，已登录返回yes，未登录则弹出登录页面
//已登录返回yes，未登录返回no
-(BOOL)judgeLoginState{

    BOOL flag = NO;
    if (self.loginState ==1) {
        flag = YES;
    }
    else{
        [self showLoginView];
    }
    return flag;
}

//自动登录，登录失败则弹出登录页面

-(void)autoLogin{

    if (self.loginState !=1) {
        [self login];
    }
}

//弹出登录界面
-(void)showLoginView{
    
    
    UIViewController *currentVC = [app getNowViewController];
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:login];
    [currentVC presentViewController:navController animated:YES completion:nil];
    
    
    
}
//登录
-(void)login{

    //获取账号信息
    NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults]objectForKey:AUTOLOGIN];
    NSString *account = [accountDic objectForKey:ACCOUNT];
    NSString *password = [accountDic objectForKey:PASSWORD];
    if (account == nil || account.length == 0) {
        [self showLoginView];
        return;
    }
    if (password == nil || password.length == 0) {
        [self showLoginView];
        return;
    }
    
    //此处为网络请求部分
    //模拟登录
    if ([account isEqualToString:@"zhangsan"]&&[password isEqualToString:@"123"]) {
        
        //登录成功
        [LoginManage sharedManager].loginState = 1;
        
        //保存账号，不保存密码
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:account,ACCOUNT,password,PASSWORD ,nil];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:AUTOLOGIN];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        //请求错误或者登录失败
        [self showLoginView];
    }
}

@end
