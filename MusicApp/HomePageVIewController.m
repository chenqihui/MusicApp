//
//  HomePageVIewController.m
//  testMyBackNavigation
//
//  Created by chen on 14-7-15.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "HomePageVIewController.h"

#import "SubViewController.h"
#import "PlayBoxViewController.h"

#define kALPHA  0.7

@interface HomePageVIewController ()
{
    UIScrollView *_hpScrollV;
    
    UIView *_oneTopV;
    UIView *_oneBottomV;
    
    UIView *_twoSearchV;
    UIView *_twoTopV;
    UIView *_twoMiddleV;
    UIView *_twoBottomV;
    
    UIView *_musicBottomV;
    
    PlayBoxViewController *_playBoxVC;
}

@end

@implementation HomePageVIewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageBgV setImage:[UIImage imageNamed:@"skinBackImage_1.jpg"]];
    [self.view addSubview:imageBgV];
    
    _hpScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_hpScrollV setPagingEnabled:YES];
    [_hpScrollV setShowsHorizontalScrollIndicator:NO];
    [_hpScrollV setContentSize:CGSizeMake(_hpScrollV.frame.size.width * 2, _hpScrollV.frame.size.height)];
    [self.view addSubview:_hpScrollV];
    [_hpScrollV scrollRectToVisible:CGRectMake(_hpScrollV.frame.size.width, 0, self.view.frame.size.width, _hpScrollV.frame.size.height) animated:NO];
    [_hpScrollV setBackgroundColor:[UIColor clearColor]];
    
    UIView *bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:kALPHA];
    
    _oneTopV = [[UIView alloc] initWithFrame:CGRectMake(10, 120, self.view.frame.size.width - 20, 205)];
    [_oneTopV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_oneTopV.bounds];
    [_oneTopV addSubview:bg];
    [_hpScrollV addSubview:_oneTopV];
    
    bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:kALPHA];
    
    _oneBottomV = [[UIView alloc] initWithFrame:CGRectMake(10, _oneTopV.frame.origin.y + _oneTopV.frame.size.height + 5, self.view.frame.size.width - 20, 115)];
    [_oneBottomV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_oneBottomV.bounds];
    [_oneBottomV addSubview:bg];
    [_hpScrollV addSubview:_oneBottomV];
    
    bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor blackColor]];
    [bg setAlpha:0.5];
    
    _twoSearchV = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width + 10, 120, self.view.frame.size.width - 20, 45)];
    [_twoSearchV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_twoSearchV.bounds];
    [_twoSearchV addSubview:bg];
    [_hpScrollV addSubview:_twoSearchV];
    
    bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:kALPHA];
    
    _twoTopV = [[UIView alloc] initWithFrame:CGRectMake(_twoSearchV.frame.origin.x, _twoSearchV.frame.origin.y + _twoSearchV.frame.size.height + 10, self.view.frame.size.width - 20, 150)];
    [_twoTopV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_twoTopV.bounds];
    [_twoTopV addSubview:bg];
    [_hpScrollV addSubview:_twoTopV];
    
    bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:kALPHA];
    
    _twoMiddleV = [[UIView alloc] initWithFrame:CGRectMake(_twoSearchV.frame.origin.x, _twoTopV.frame.origin.y + _twoTopV.frame.size.height + 5, self.view.frame.size.width - 20, 115)];
    [_twoMiddleV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_twoMiddleV.bounds];
    [_twoMiddleV addSubview:bg];
    [_hpScrollV addSubview:_twoMiddleV];
    
    bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:kALPHA];
    
    _twoBottomV = [[UIView alloc] initWithFrame:CGRectMake(_twoSearchV.frame.origin.x, _twoMiddleV.frame.origin.y + _twoMiddleV.frame.size.height + 5, self.view.frame.size.width - 20, 44)];
    [_twoBottomV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_twoBottomV.bounds];
    [_twoBottomV addSubview:bg];
    [_hpScrollV addSubview:_twoBottomV];
    
    bg = [[UIView alloc] init];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [bg setAlpha:0.9];
    
    _musicBottomV = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 54, self.view.frame.size.width, 54)];
    [_musicBottomV setBackgroundColor:[UIColor clearColor]];
    [bg setFrame:_musicBottomV.bounds];
    [_musicBottomV addSubview:bg];
    [[UIApplication sharedApplication].keyWindow addSubview:_musicBottomV];
    
    UIImageView *m = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 50, 50)];
    [m setImage:[UIImage imageNamed:@"play_bar_singerbg.png"]];
    [_musicBottomV addSubview:m];
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] init];
    singleTapRecognizer.numberOfTapsRequired = 1;
    [singleTapRecognizer addTarget:self action:@selector(showPlayBox:)];
    [_musicBottomV addGestureRecognizer:singleTapRecognizer];
}

- (void)hiddenMusicControl:(BOOL)bHidden
{
    float yy = 0;
    if (bHidden)
        yy = [[UIScreen mainScreen] bounds].size.height;
    else
        yy = [[UIScreen mainScreen] bounds].size.height - 54;
    
    [UIView animateWithDuration:0.2 animations:^
     {
         [_musicBottomV setFrame:CGRectMake(0, yy, self.view.frame.size.width, 54)];
     } completion:^(BOOL finished)
     {
         
     }];
}

- (void)showPlayBox:(UITapGestureRecognizer *)ges
{
    if(_playBoxVC == nil)
    {
        _playBoxVC = [[PlayBoxViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_playBoxVC.view];
        [_playBoxVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _playBoxVC.view.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         _playBoxVC.view.transform = CGAffineTransformIdentity;
     } completion:^(BOOL finished) {}];
    
}

@end
