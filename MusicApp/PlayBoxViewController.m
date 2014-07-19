//
//  PlayBoxViewController.m
//  KGApp
//
//  Created by chen on 14/7/17.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "PlayBoxViewController.h"

@interface PlayBoxViewController ()<UIGestureRecognizerDelegate>
{
    CGPoint _startTouch;
    
    CGFloat startBackViewX;
}

@property (nonatomic,assign) BOOL isMoving;

@end

@implementation PlayBoxViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageBgV setImage:[UIImage imageNamed:@"skinBackImage_1.jpg"]];
    [self.view addSubview:imageBgV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(20, 40, 60, 30)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    btn.layer.masksToBounds = YES;
//    btn.layer.cornerRadius = 8.0;
//    btn.layer.borderWidth = 1;
//    btn.layer.borderColor = [UIColor blueColor].CGColor;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UIView *bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:0.9];
    
    UIView *musicControlV = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 115, self.view.frame.size.width, 115)];
    [musicControlV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:musicControlV.bounds];
    [musicControlV addSubview:bg];
    [self.view addSubview:musicControlV];
    
    [self setAnchorPoint:CGPointMake(0.5, 1.2) forView:self.view];
}

//直接收回页面
- (void)back
{
    [UIView animateWithDuration:0.3 animations:^
     {
         [self moveViewWithX:1910];
     } completion:^(BOOL finished) {
     }];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)recoginzer
{
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan)
    {
        _isMoving = YES;
        _startTouch = touchPoint;
        
    }else if (recoginzer.state == UIGestureRecognizerStateEnded)
    {
        if (touchPoint.x - _startTouch.x > 180)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:1910];
            } completion:^(BOOL finished) {
                _isMoving = NO;
            }];
        }else if (touchPoint.x - _startTouch.x < -180)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:-1910];
            } completion:^(BOOL finished) {
                _isMoving = NO;
            }];
        }else
        {
            [UIView animateWithDuration:0.3 animations:^
             {
                 self.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _isMoving = NO;
            }];
            
        }
//        [self setDefaultAnchorPointForView:self.view];
        return;
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
        }];
        return;
    }
    if (_isMoving)
        [self moveViewWithX:touchPoint.x - _startTouch.x];
}

- (void)moveViewWithX:(float)x
{
//    self.view.layer.anchorPoint = CGPointMake(0.5, 1);
    
    double r = M_PI/6 * (x/320);
    self.view.transform = CGAffineTransformMakeRotation(r);
    
//    self.view.transform = CGAffineTransformRotate(self.view.transform, r);
    
//    CGAffineTransform at = CGAffineTransformMakeRotation(r);
//    at = CGAffineTransformTranslate(at, self.view.frame.size.width/2, self.view.frame.size.height);
//    [self.view setTransform:at];
}

//设置防止view刚开始旋转时发生跳屏
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

//还原设置，不然view的其他改变会不正常
- (void)setDefaultAnchorPointForView:(UIView *)view
{
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:view];
}

@end
