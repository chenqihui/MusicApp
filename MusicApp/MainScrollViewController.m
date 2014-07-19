//
//  MainScrollViewController.m
//  testMyBackNavigation
//
//  Created by chen on 14-7-15.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "MainScrollViewController.h"

@interface MainScrollViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_arViewControllers;
    UIScrollView *_scrollView;
    
    UIViewController<MainScrollDelegate> *_mainVC;
    UIViewController *_setVC;
    
    int _viewCount;
}

@end

@implementation MainScrollViewController

static MainScrollViewController *MVC;

- (void)loadView
{
    [super loadView];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    _scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    _scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.view addSubview:_scrollView];
}

- (void)viewDidLoad
{
    if (!_arViewControllers)
    {
        _arViewControllers = [NSMutableArray new];
    }
    MVC = self;
}

- (void)initViewControllerWithMain:(UIViewController<MainScrollDelegate> *)mainVC set:(UIViewController *)setVC
{
    _mainVC = mainVC;
    _setVC = setVC;
    _viewCount = 2;
    
    if (_mainVC == nil)
    {
        _mainVC = (UIViewController<MainScrollDelegate> *)[[UIViewController alloc] init];
        [_mainVC.view setBackgroundColor:[UIColor blueColor]];
    }
    
    if (_setVC == nil)
    {
        _setVC = [[UIViewController alloc] init];
        [_setVC.view setBackgroundColor:[UIColor blueColor]];
    }
    [_mainVC.view setFrame:CGRectMake(0, _mainVC.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [_scrollView addSubview:_mainVC.view];
    [_arViewControllers addObject:_mainVC];
    
    [_setVC.view setFrame:CGRectMake(self.view.frame.size.width, _setVC.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [_scrollView addSubview:_setVC.view];
    [_arViewControllers addObject:_setVC];
    
    _mainVC.view.tag = 1;
    _setVC.view.tag = 2;
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 2, _scrollView.frame.size.height)];
    [_scrollView scrollRectToVisible:_mainVC.view.frame animated:YES];
}

- (void)addMain:(UIViewController *)superVC sub:(UIViewController *)subVC
{
    if ([_arViewControllers count] > superVC.view.tag)
    {
        for (int i = (int)superVC.view.tag; i < [_arViewControllers count]; i++)
        {
            UIViewController *vc = [_arViewControllers objectAtIndex:i];
            [vc.view removeFromSuperview];
        }
        [_arViewControllers removeObjectsInRange:NSMakeRange(superVC.view.tag, [_arViewControllers count] - superVC.view.tag)];
    }
    [self addViewController2Main:subVC];
}

- (void)addViewController2Main:(UIViewController *)viewController
{
    [viewController.view setFrame:CGRectMake(_scrollView.frame.size.width * [_arViewControllers count], viewController.view.frame.origin.y, viewController.view.frame.size.width, viewController.view.frame.size.height)];
    [_scrollView addSubview:viewController.view];
    [_arViewControllers addObject:viewController];
    viewController.view.tag = [_arViewControllers count];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * [_arViewControllers count], _scrollView.frame.size.height)];
    [_scrollView scrollRectToVisible:viewController.view.frame animated:YES];
}

- (void)setView2SetViewController:(UIViewController *)viewController
{
    [_setVC.view addSubview:viewController.view];
    [_scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
}

+ (MainScrollViewController *)getMain
{
    return MVC;
}

- (void)backView:(UIViewController *)vc
{
    if (vc.view.tag <= [_arViewControllers count] && vc.view.tag > 1)
    {
        [_scrollView scrollRectToVisible:((UIViewController *)[_arViewControllers objectAtIndex:vc.view.tag - 1]).view.bounds animated:YES];
        if (vc.view.tag == 2)
        {
            [_mainVC hiddenMusicControl:NO];
        }
    }
}

#pragma mark - scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == _scrollView.frame.size.width)
    {
        [_mainVC hiddenMusicControl:YES];
    }else if (scrollView.contentOffset.x == 0)
    {
        [_mainVC hiddenMusicControl:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    if (offset < 0)
    {
        return;
    }
//    CGFloat width = scrollView.frame.size.width;
    
    for (UIViewController *viewController in _arViewControllers)
    {
        NSInteger index = [_arViewControllers indexOfObject:viewController];
        CGFloat width = _scrollView.frame.size.width;
        CGFloat y = index * width;
        CGFloat value = (offset-y)/width;
//        CGFloat scale = 1.f-fabs(value);
        CGFloat scale = fabs(cos(fabs(value)*M_PI/5));
        
//        if (scale > 1.f) scale = 1.f;
//        if (scale < .9f) scale = .9f;
        
        viewController.view.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    for (UIViewController *viewController in self.childViewControllers)
    {
        CALayer *layer = viewController.view.layer;
        layer.shadowPath = [UIBezierPath bezierPathWithRect:viewController.view.bounds].CGPath;
    }
}

@end
