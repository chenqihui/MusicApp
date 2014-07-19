//
//  MainScrollViewController.h
//  testMyBackNavigation
//
//  Created by chen on 14-7-15.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainScrollDelegate <NSObject>

@optional

- (void)hiddenMusicControl:(BOOL)bHidden;

@end

/**
 *  类似的UI框架及UI功能
 */
@interface MainScrollViewController : UIViewController

+ (MainScrollViewController *)getMain;

- (void)initViewControllerWithMain:(UIViewController<MainScrollDelegate> *)mainVC set:(UIViewController *)setVC;

//直接在后面加view
- (void)addViewController2Main:(UIViewController *)viewController;

//- (void)setView2SetViewController:(UIViewController *)viewController;

//删除superView后面的view， 再加view
- (void)addMain:(UIViewController *)superVC sub:(UIViewController *)subVC;

//返回上一个view
- (void)backView:(UIViewController *)vc;

@end
