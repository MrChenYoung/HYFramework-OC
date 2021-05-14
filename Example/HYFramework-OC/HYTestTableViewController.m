//
//  HYTestTableViewController.m
//  HYFramework_Example
//
//  Created by 臻尚 on 2021/4/13.
//  Copyright © 2021 mrchenyoung. All rights reserved.
//

#import "HYTestTableViewController.h"

@interface HYTestTableViewController ()

@end

@implementation HYTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置子视图
- (void)setupSubviews
{
    [super setupSubviews];
    
    // 添加tableView
    [self setupTableView];
    // 添加刷新
    [self addHeaderRefresh];
    [self addFootRefresh];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(HYSCREEN_Statusbar_Nav_Height);
    }];
}

- (void)reloadData
{
    [super reloadData];
}

- (void)loadMore
{
    [super loadMore];
    
}

@end
