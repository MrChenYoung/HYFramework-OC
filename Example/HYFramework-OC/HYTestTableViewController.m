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
    
//    [self setupTableView:nil];
    
    [self setupCollectionView:nil];
    // 添加刷新
    [self.collectionView addHeaderRefresh];
    [self.collectionView addFootRefresh];
}

- (void)hy_setupCollectionDataSource
{
    [self setupSingleCollectionCountForRow:3 lineSpacing:10 interitemSpacing:10 itemAtIndexPath:^(UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {

        UIView *v = UIView.new;
        v.backgroundColor = HYColorRed;
        [cell.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.center.equalTo(cell.contentView);
        }];
        cell.backgroundColor = HYColorBgLight1;
    }];
    self.collectionView.hyDataSource.didSelectItemAtIndexPath = ^(UICollectionView * _Nonnull collection, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"第%ld个section,第%ld个item",(long)indexPath.section,(long)indexPath.item);
    };

//    [self.collectionView.hyDataSource resetDataWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    
//    // 注册cell
//    [self.collectionView registCell:@"UICollectionViewCell"];
//    self.collectionView.hyDataSource.numberOfItemForRow = 3;
//    // item个数
//    self.collectionView.hyDataSource.numberOfItemsInSection = ^NSInteger(NSInteger section) {
//        return 9;
//    };
////    self.collectionView.hyDataSource.sizeForItemAtIndexPath = ^CGSize(NSIndexPath * _Nonnull indexPath) {
////        return CGSizeMake(100, 100);
////    };
//    self.collectionView.hyDataSource.minimumLineSpacingForSectionAtIndex = ^CGFloat(NSInteger section) {
//        return 2;
//    };
//    self.collectionView.hyDataSource.minimumInteritemSpacingForSectionAtIndex = ^CGFloat(NSInteger section) {
//        return 2;
//    };
//    // cell
//    self.collectionView.hyDataSource.cellForItemAtIndexPath = ^UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collection, NSIndexPath * _Nonnull indexPath) {
//        UICollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//        cell.backgroundColor = HYColorRed;
//        return cell;
//    };

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
    [self setupSingleTableRowH:60 cellStyle:UITableViewCellStyleSubtitle titleForSectionHeader:^NSString * _Nonnull(NSInteger section) {
        return [NSString stringWithFormat:@"第%ld个section",section];
    } sectionHeader:^(UIView * _Nonnull sectionHeaderBgView, UILabel * _Nonnull sectionHeaderTextLabel, NSInteger section) {
        
    } cellForRow:^(HYBaseTableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"标题";
        cell.detailTextLabel.text = @"副标题";
    }];
    self.tableView.hyDataSource.numberOfSections = ^NSInteger{
        return 0;
    };
    self.tableView.hyDataSource.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        if (section == 0) {
            return 0;
        }else {
            return 10;
        }
    };
    
//    [self.tableView.hyDataSource resetDataWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
}

@end
