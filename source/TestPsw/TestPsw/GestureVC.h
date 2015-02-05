//
//  GestureVC.h
//  
//
//  Created by guosm on 15/1/23.
//  Copyright (c) 2015年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *pwdTitle;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;//用户头像
@property (weak, nonatomic) IBOutlet UILabel *userName;//用户名
@property (weak, nonatomic) IBOutlet UILabel *tipLable;//密码输入提示

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;//忘记手势密码按钮
- (IBAction)forgetAction:(UIButton *)sender;//忘记手势密码事件
@end
