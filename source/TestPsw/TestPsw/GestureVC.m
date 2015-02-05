//
//  GestureVC.m
//  
//
//  Created by guosm on 15/1/23.
//  Copyright (c) 2015年 gsm. All rights reserved.
//

#import "GestureVC.h"
#import "GesturePwdView.h"

@interface GestureVC ()<PasswordDelegate>{
    
    GesturePwdView *pswView;
    NSMutableArray *smalBtnArray;
    BOOL isError;
}

@end

@implementation GestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    smalBtnArray = [[NSMutableArray alloc] initWithCapacity:9];
    
    pswView = [[GesturePwdView alloc]initWithFrame:CGRectMake(0, 200, 320, 320)];
    pswView.delegate = self;
    pswView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pswView];
    
    for (int i = 0; i<9; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(145 + (i % 3) * (5 + 8), 100 + (i / 3) * (8 + 5), 8, 8);
        [btn setBackgroundImage:[UIImage imageNamed:@"smal_off"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"smal_on"] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;     //用户交互
        btn.alpha = 0.9;
        btn.tag = i+10000;
        [btn setHidden:YES];
        
        [smalBtnArray addObject:btn];
        [self.view addSubview:btn];
    }
    
    
    if ([pswView isPasswordState] == ePasswordUnset) {//没有设置手势密码
        
        [self.pwdTitle setText:@"手势密码设置"];
        [self.userName setText:@""];
        [self.tipLable setText:@"请绘制解锁图案"];
        [self createSmallView:nil];
        [self.forgetBtn setHidden:YES];
        [self.userPhoto setHidden:YES];
        
    }else{
        
        self.userPhoto.layer.masksToBounds = YES;
        self.userPhoto.layer.cornerRadius = 25;
        [self.userPhoto setImage:[UIImage imageNamed:@"yuan"]];
        [self.userPhoto setHidden:NO];
        [self.pwdTitle setText:@""];
        [self.userName setText:kTEST_ACOUNT_VALUE];
        [self.tipLable setText:@""];
        [self.forgetBtn setHidden:NO];
    }
    
}

// 用于记录第一次设置的手势密码的小视图
-(void)createSmallView:(NSMutableArray *)array{
    
    
    for (int i = 0; i < [smalBtnArray count]; i++) {
        
        UIButton *tempBtn = [smalBtnArray objectAtIndex:i];
        [tempBtn setHidden:NO];
        
        if (isError) {
           
            tempBtn.selected = NO;
            
        }else{
            
            [self setSelectes:tempBtn with:array];
            
        }
        
    }
}

-(void)setSelectes:(UIButton *)button with:(NSMutableArray *)array{
    if (array.count != 0) {
        for (int j = 0; j < array.count; j++) {
            if ((button.tag - 9999) == [array[j] integerValue]) {
                button.selected = YES;
                
            }
        }
    }
}


-(void)theResoutOfInput:(NSString *)alertSender withResult:(NSString *)resultSender{
    
    
    NSLog(@"手势密码=%@%@",alertSender,resultSender);
    
    [self.tipLable setText:alertSender];
    [self.tipLable setTextColor:[UIColor whiteColor]];
    
    if([alertSender hasPrefix:@"密码不能少于四位"]||[alertSender hasPrefix:@"密码错误"]|| [alertSender hasPrefix:@"两次不一致,请重新绘制"]){
        
        isError = YES;
        [self.tipLable setTextColor:[UIColor redColor]];
        [self shakeAnimationForView:self.tipLable];
        
    }else if ([alertSender hasPrefix:@"请再绘制一次"]){
        
        isError = NO;
        
    }else if([alertSender hasPrefix:@"创建密码成功"] || [alertSender hasPrefix:@"输入密码正确"]){
        
        isError = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    //用于判断是否需要创建小图密码框
    if ([pswView isPasswordState] == ePasswordUnset) {//没有设置手势密码
        
        NSMutableArray *selectedNumArray = [[NSMutableArray alloc] initWithCapacity:10];
        
        [selectedNumArray removeAllObjects];
        //将返回过来的手势密码字符串分解成数组保存
        NSInteger selectedNumber = [resultSender integerValue];
        while (selectedNumber) {
            int temp = selectedNumber % 10 ;
            selectedNumber = selectedNumber / 10;
            [selectedNumArray addObject:[NSString stringWithFormat:@"%d",temp]];
        }
        [self createSmallView:selectedNumArray];
    }
    
}

#pragma mark 抖动动画
- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark 密码delegate
-(void)callbackGestureContinueFalse{
    
    NSLog(@"您已连续5次输错手势,手势解锁已关闭,请重新登录");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新运行" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
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

- (IBAction)forgetAction:(UIButton *)sender {
    
    [pswView resetPassword];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新运行" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
@end
