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
    
    HYWaterFallFlowView *flowView = [HYWaterFallFlowView flowCollectionView];
    [self.view addSubview:flowView];
    [flowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 1; i < 14; i++) {
        HYImageVideoModel *imageModel = [HYImageVideoModel model];
        NSString *imageName = [NSString stringWithFormat:@"flow%d",i];
        imageModel.content = imageName;
        imageModel.image = HYImageNamed(imageName);
        [arrM addObject:imageModel];
    }
    flowView.imageListArray = [arrM copy];
    
    // 添加刷新
    [self.collectionView addHeaderRefresh];
    [self.collectionView addFootRefresh];
}


- (void)hy_reloadData
{
    NSLog(@"下拉刷新");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView stopAllRefresh];
    });
}

- (void)hy_loadMoreData
{
    NSLog(@"上拉加载更多");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView stopAllRefresh];
    });
}

// 设置tableDatasource
- (void)hy_setupTableDataSource
{
//    [self setupSingleTableRowH:60 cellStyle:UITableViewCellStyleSubtitle cellForRow:^(HYBaseTableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
//        cell.textLabel.text = @"标题";
//        cell.detailTextLabel.text = @"副标题";
//    }];
    
    [self setupSingleTableRowH:60 cellStyle:UITableViewCellStyleSubtitle cellForRow:^(HYBaseTableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"标题";
        cell.detailTextLabel.text = @"副标题";
    } headerHeight:^CGFloat(NSInteger section) {
        return 50;
    } titleForSectionHeader:^NSString * _Nonnull(NSInteger section) {
        return [NSString stringWithFormat:@"第%ld个section",section];
    } sectionHeaderBlock:^(UIView * _Nonnull sectionHeaderBgView, UILabel * _Nonnull sectionHeaderTextLabel, NSInteger section) {
        
    }];
    
//    [self setupSingleTableRowH:60 cellStyle:UITableViewCellStyleSubtitle titleForSectionHeader:^NSString * _Nonnull(NSInteger section) {
//        return [NSString stringWithFormat:@"第%ld个section",section];
//    } sectionHeader:^(UIView * _Nonnull sectionHeaderBgView, UILabel * _Nonnull sectionHeaderTextLabel, NSInteger section) {
//        
//    } cellForRow:^(HYBaseTableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
//        cell.textLabel.text = @"标题";
//        cell.detailTextLabel.text = @"副标题";
//    }];
    self.tableView.hyDataSource.numberOfSections = ^NSInteger{
        return 2;
    };
    self.tableView.hyDataSource.numberOfRowsInSection = ^NSInteger(NSInteger section) {
//        if (section == 0) {
//            return 0;
//        }else {
//            return 10;
//        }
        return 10;
    };
    
    [self.tableView.hyDataSource resetDataWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
}


@end
