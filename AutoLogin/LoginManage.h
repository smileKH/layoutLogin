//
//  LoginManage.h
//  AutoLogin
//
//  Created by aplle on 16/1/13.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface LoginManage : NSObject

@property (nonatomic , assign)NSInteger  loginState;

+(instancetype)sharedManager;

//判断登录状态，已登录返回yes，未登录则弹出登录页面
//已登录返回yes，未登录返回no
-(BOOL)judgeLoginState;

//自动登录，登录失败则弹出登录页面

-(void)autoLogin;

@end
