//
//  LoginViewController.m
//  AutoLogin
//
//  Created by aplle on 16/1/13.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManage.h"
@interface LoginViewController ()
{
    UIView          *contentView;
    UITextField     *accountTF;
    UITextField     *passwordTF;
    
}
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    //获取账号
    NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults]objectForKey:AUTOLOGIN];
    NSString *account = [accountDic objectForKey:ACCOUNT];
    NSString *password = [accountDic objectForKey:PASSWORD];
    if (account != nil && account.length >0) {
        accountTF.text = account;
    }
    if (password != nil && password.length >0) {
        passwordTF.text = password;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    contentView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    [self contentViewAddSubviews];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}
-(void)contentViewAddSubviews{

    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 102, 146)];
    iv.center = CGPointMake(self.view.bounds.size.width/2, (ISIOS7_OR_LATER?60:80) +146/2);
    iv.image = [UIImage imageNamed:@"zhucheye"];
    [contentView addSubview:iv];
    CGFloat offY = ISIOS7_OR_LATER?250:290;
    
    //---------账号---------
    iv = [[UIImageView alloc]initWithFrame:CGRectMake(50, offY +7.5, 27.5, 14.5)];
    iv.image = [UIImage imageNamed:@"zhanghu"];
    [contentView addSubview:iv];
    
    accountTF = [[UITextField alloc]initWithFrame:CGRectMake(70, offY, self.view.bounds.size.width-120, 30)];
    accountTF.backgroundColor = [UIColor clearColor];
    accountTF.placeholder = @"请输入账号";
    accountTF.textColor = [UIColor blackColor];
    accountTF.keyboardType = UIKeyboardTypeNumberPad;
    [contentView addSubview:accountTF];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(50, offY+30, self.view.bounds.size.width -100, 0.5)];
    line.backgroundColor = [UIColor blackColor];
    [contentView addSubview:line];
    offY += 45;
    //----------密码------------
    iv = [[UIImageView alloc]initWithFrame:CGRectMake(50, offY +7.5, 27.5, 14.5)];
    iv.image = [UIImage imageNamed:@"mima"];
    [contentView addSubview:iv];
    
    passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(70, offY, self.view.bounds.size.width-120, 30)];
    passwordTF.backgroundColor = [UIColor clearColor];
    passwordTF.placeholder = @"请输入密码";
    passwordTF.textColor = [UIColor blackColor];
    [passwordTF setSecureTextEntry:YES];
    passwordTF.keyboardType = UIKeyboardTypePhonePad;
    [contentView addSubview:passwordTF];
    
    line = [[UIImageView alloc]initWithFrame:CGRectMake(50, offY +30, self.view.bounds.size.width -100, 0.5)];
    line.backgroundColor = [UIColor blackColor];
    [contentView addSubview:line];
    offY +=35;
    
    //---------忘记密码--------
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, offY, 90, 30)];
    [button setTitle:@"忘记密码》" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    
    //-----------注册------------
    button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50-55, offY, 55, 30)];
    [button setTitle:@"注册》" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal
     ];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    offY += 70;
    
    UIButton *useBt = [[UIButton alloc]initWithFrame:CGRectMake(50, offY, self.view.bounds.size.width-100, 50)];
    [useBt setTitle:@"确定" forState:UIControlStateNormal];
    [useBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
     [useBt setBackgroundImage:[UIImage imageNamed:@"mm_nav"] forState:UIControlStateNormal];
     useBt.titleLabel.font = [UIFont systemFontOfSize:20];
     [useBt addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:useBt];
}
//忘记密码
-(void)forgetPassword{

}

//注册
-(void)regist{

    
}
//登录
-(void)submit{

    NSString *account = accountTF.text;
    NSString *password = passwordTF.text;
    if (account.length == 0) {
        //请输入账号
        return;
    }
    if (password.length == 0) {
        //请输入密码
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
        
        [self back];
    }
    else{
        //请求错误或者登录失败
        
    }

    
}

-(void)back{

    [self dismissViewControllerAnimated:YES completion:nil];
}

//
-(void)closeKeyboard{

    [accountTF resignFirstResponder];
    [passwordTF resignFirstResponder];
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
