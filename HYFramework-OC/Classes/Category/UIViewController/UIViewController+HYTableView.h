//
//  UIViewController+TableView.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/9.
//

#import <UIKit/UIKit.h>
#import "HYTableDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYTableView)

// table
@property (nonatomic, strong) UITableView *tableView;

// dataSource对象
@property (nonatomic, strong) HYTableDataSource *dataSource;

// 页码
@property(nonatomic, assign) NSInteger pageIndex;

// 是不是加载更多
@property(nonatomic, assign) BOOL loadMoreData;

// 行高
@property (nonatomic, assign) CGFloat rowHeight;

#pragma mark - 设置子视图
// 设置tableView
- (void)setupTableView;

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部刷新
- (void)addHeaderRefresh;

// 添加上拉加载更多
- (void)addFootRefresh;

// 头部开始刷新
- (void)startRefresh;

// 停止刷新(包括头部和尾部)
- (void)stopRefresh;

// 下拉刷新
- (void)reloadData;

// 上拉加载更多
- (void)loadMore;

// 加载更多的情况下数据处理
- (void)loadMoreDataHandle:(NSArray *)newData;

#pragma mark - 其他
// 设置tableDataSource信息
- (void)setupTableDataSource;

// 设置tableView高度自适应
- (void)setupTableViewHeightAutomatic;

// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className;

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
