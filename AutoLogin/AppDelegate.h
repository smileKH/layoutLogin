//
//  AppDelegate.h
//  AutoLogin
//
//  Created by aplle on 16/1/13.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MainViewController *_mainViewController;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic , strong)MainViewController * mainViewController;


- (UIViewController *)getNowViewController;
@end

