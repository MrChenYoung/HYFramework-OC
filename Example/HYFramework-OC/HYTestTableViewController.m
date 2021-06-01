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
    [self.tableView addHeaderRefresh];
    [self.tableView addFootRefresh];
    self.tableView.separatorColor = HYColorRed;
//    self.tableView.showDefaultSectionHeader = YES;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(HYSCREEN_Statusbar_Nav_Height);
    }];
}

- (void)hy_reloadData
{
    NSLog(@"下拉刷新");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView stopAllRefresh];
    });
}

- (void)hy_loadMoreData
{
    NSLog(@"上拉加载更多");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView stopAllRefresh];
    });
}

// 设置tableDatasource
- (void)hy_setupTableDataSource
{
    // 行高
//    self.tableView.rowHeight = 50;
//    // 注册cell
//    [self.tableView registCell:@"UITableViewCell"];
//    // section个数
//    self.tableView.hyDataSource.numberOfSections = ^NSInteger{
//        return 10;
//    };
//    self.tableView.hyDataSource.titleForHeaderInSection = ^NSString * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
//        return @"头部信息";
//    };
//    // 行数
//    self.tableView.hyDataSource.numberOfRowsInSection = ^NSInteger(NSInteger section) {
//        return 10;
//    };
//    // cell
//    self.tableView.hyDataSource.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
//        UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//
//        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
//
//        return cell;
//    };
    
    [super hy_setupTableDataSource];
    
    self.tableView.hyDataSource.numberOfSections = ^NSInteger{
        return 1;
    };
    self.tableView.hyDataSource.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        return 10;
    };
    self.textLabelContentBlock = ^NSString * _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return @"11111";
    };
    self.detailTextLabelContentBlock = ^NSString * _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return @"22222";
    };
    self.cellStyleBlock = ^UITableViewCellStyle(NSIndexPath * _Nonnull indexPath) {
        return UITableViewCellStyleSubtitle;
    };
    self.tableView.rowHeight = 80;
}

@end
