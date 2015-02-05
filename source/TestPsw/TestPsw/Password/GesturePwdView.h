//
//  NAmeview.h
//  ADDD
//
//  Created by guosm on 15/1/23.
//  Copyright (c) 2015年 gsm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTEST_ACOUNT_KEY   @"userName"
#define kTEST_ACOUNT_VALUE @"zhangsan"


//密码视图协议
@protocol PasswordDelegate <NSObject>

-(void)theResoutOfInput:(NSString *)alertSender withResult:(NSString *)resultSender;
-(void)callbackGestureContinueFalse;
@end





typedef enum ePasswordSate {
    ePasswordUnset,//未设置
    ePasswordExist//密码设置成功
}ePasswordSate;
@interface GesturePwdView : UIView<UIAlertViewDelegate>{
    ePasswordSate state;
    NSMutableArray *mutalearray;
    NSMutableArray *mutag;
    CGPoint curentpoint;
    NSString *resultStr;
    NSString *str;          
    NSString *tempStr;      //创建和重置密码时第一次绘制结果
    NSString *tempStr1;     //创建和重置密码时第二次绘制结果
    BOOL isReset;           //创建和重置密码时是否已经绘制一次标示
    NSMutableArray *getArray;
    BOOL isOver;
}

@property (nonatomic,copy) void(^callbackGestureContinueFalse)();

@property (nonatomic,weak) id<PasswordDelegate> delegate;
//重置密码
-(void)resetPassword;
//判断手势密码是否设置
-(ePasswordSate)isPasswordState;
@end
