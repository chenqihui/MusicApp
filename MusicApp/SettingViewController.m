//
//  SettingViewController.m
//  KGApp
//
//  Created by chen on 14/7/16.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "SettingViewController.h"

#import "SubViewController.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *_navView;
    UITableView *_tableView;
    
    NSDictionary *_dicData;
    NSArray *_arKey;
}

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    UIView *statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 0.f)];
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        statusBarView.frame = CGRectMake(statusBarView.frame.origin.x, statusBarView.frame.origin.y, statusBarView.frame.size.width, 20.f);
        statusBarView.backgroundColor = [UIColor clearColor];
        ((UIImageView *)statusBarView).backgroundColor = RGBA(33,140,250,1);
        [self.view addSubview:statusBarView];
    }
    
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize, self.view.frame.size.width, 44.f)];
    ((UIImageView *)_navView).backgroundColor = RGBA(33,140,250,1);
    [self.view insertSubview:_navView belowSubview:statusBarView];
    _navView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_navView.frame.size.width - 200)/2, (_navView.frame.size.height - 40)/2, 200, 40)];
    [titleLabel setText:@"设置"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [_navView addSubview:titleLabel];
    
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lbtn setFrame:CGRectMake(10, 2, 40, 40)];
    [lbtn setTitle:@"左" forState:UIControlStateNormal];
    [lbtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:lbtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self initData];
}

- (void)initData
{
    _arKey = @[@"特色", @"偏好设置"];
    _dicData = @{@"特色": @[@"皮肤主题", @"占用空间大小"], @"偏好设置": @[@"边听边存", @"离线列表环境"]};
    [_tableView reloadData];
}

#pragma mark - action

- (void)leftAction:(UIButton *)btn
{
    [[MainScrollViewController getMain] backView:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dicData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_arKey objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[_dicData objectForKey:[_arKey objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [(NSArray *)[_dicData objectForKey:[_arKey objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    SubViewController *subViewController = [[SubViewController alloc] initWithFrame:[UIScreen mainScreen].bounds andSignal:@""];
    [[MainScrollViewController getMain] addMain:self sub:subViewController];
    subViewController.szSignal = cell.textLabel.text;
}

@end
