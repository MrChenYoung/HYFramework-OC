//
//  HYTableView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/5/31.
//

#import "HYTableView.h"
#import "HYFramework.h"

@interface HYTableView ()

// dataSource对象
@property (nonatomic, strong, readwrite) HYTableDataSource *hyDataSource;

// 是否是加载更多
@property(nonatomic, assign, readwrite) BOOL isLoadMore;

// 没有数据的时候显示的背景view
@property (nonatomic, strong, readwrite) HYNoneDataView *noneDataBgView;

@end

@implementation HYTableView

#pragma mark - 工厂方法，获取对象
/**
 * 获取指定类型的HYTableView对象
 * @param style 类型
 * UITableViewStylePlain  table滚动，sectionHeader固定到屏幕顶部
 * UITableViewStyleGrouped table滚动，sectionHeader不固定到屏幕顶部
 */
+ (HYTableView *)tableViewWithStyle:(UITableViewStyle)style
{
    HYTableView *table = [[self alloc] initWithFrame:CGRectZero style:style];
    table.tableFooterView = UIView.new;
    table.backgroundColor = HYColorBgLight1;

    // 分割线颜色
    table.separatorColor = HYColorBgLight2;
    
    // 去掉默认的顶部空隙
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    // 设置默认数据
    [table setupDetaultsData];
    
    // 设置tableDataSource信息
    [table setupTableDataSource];
    
    return table;
}

// 获取HYTableView对象，plain类型
+ (HYTableView *)tableView
{
    return [self tableViewWithStyle:UITableViewStyleGrouped];
}

// 所有view加载完成，也可以当做reloadData完成后调用的方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 没有数据的时候显示背景
    if ([self totalRowNumber] == 0) {
        self.backgroundView = self.noneDataBgView;
    }else {
        self.backgroundView = nil;
    }
}

#pragma mark - 注册cell
// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className
{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(NSClassFromString(className).class) bundle:nil] forCellReuseIdentifier:className];
}

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className
{
    [self registerClass:[NSClassFromString(className) class] forCellReuseIdentifier:className];
}

#pragma mark - 设置tableView Datasource
// 设置tableDataSource信息
- (void)setupTableDataSource
{
    // 创建datasource对象
    self.hyDataSource = [HYTableDataSource dataSourceWithTable:self];
    
    // group类型的table section头部会有默认的空隙，设置头部高度去掉
    // section头部高度
    self.hyDataSource.heightForHeaderInSection = ^CGFloat(UITableView * _Nonnull table, NSInteger section) {
        return 0.00001;
    };
    self.hyDataSource.viewForHeaderInSection = ^UIView * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
        return nil;
    };
    // section footer
    self.hyDataSource.heightForFooterInSection = ^CGFloat(UITableView * _Nonnull table, NSInteger section) {
        return 0.00001;
    };
    self.hyDataSource.viewForFooterInSection = ^UIView * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
        return nil;
    };
    
    // 调用代理设置的关于datasource和delegate方法
    if (self.hyDelegate && [self.hyDelegate respondsToSelector:@selector(hy_setupTableDataSource)]) {
        [self.hyDelegate hy_setupTableDataSource];
    }
}

#pragma mark - 其他
// 设置默认数据
- (void)setupDetaultsData
{
    // 页码 默认1
    self.pageIndex = 1;
}

// 设置tableView高度自适应
- (void)setupRowHeightAutomatic
{
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 60;
}

// 获取tableView总共有多少行
- (NSInteger)totalRowNumber
{
    NSInteger rowCount = 0;
    for (int i = 0; i < self.numberOfSections; i++) {
        rowCount += [self numberOfRowsInSection:i];
    }
    return rowCount;
}

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部下拉刷新
- (void)addHeaderRefresh
{
    WeakSelf
    [self addHeaderRefreshBlock:^{
        if ([Weakself respondsToSelector:@selector(refreshData)]) {
            [Weakself refreshData];
        }
    }];
}

// 添加尾部上拉加载更多
- (void)addFootRefresh
{
    WeakSelf
    [self addFootRefreshBlock:^{
        if ([Weakself respondsToSelector:@selector(loadMoreData)]) {
            [Weakself loadMoreData];
        }
    }];
}

// 头部开始刷新
- (void)startHeaderRefresh
{
    [self startRefresh];
}

// 停止刷新(包括头部和尾部)
- (void)stopAllRefresh
{
    [self stopRefresh];
}

// 下拉刷新
- (void)refreshData
{
    // 复位页码
    self.pageIndex = 1;
    self.isLoadMore = NO;
    [self.hyDataSource.dataSourceArray removeAllObjects];
    
    // 调用代理的下拉刷新方法
    if (self.hyDelegate && [self.hyDelegate respondsToSelector:@selector(hy_reloadData)]) {
        [self.hyDelegate hy_reloadData];
    }
}

// 上拉加载更多
- (void)loadMoreData
{
    self.pageIndex++;
    self.isLoadMore = YES;
    
    // 调用代理的上拉加载更多方法
    if (self.hyDelegate && [self.hyDelegate respondsToSelector:@selector(hy_loadMoreData)]) {
        [self.hyDelegate hy_loadMoreData];
    }
}

// 加载更多的情况下数据处理
- (void)loadMoreDataHandle:(NSArray *)newData
{
    if (self.isLoadMore && newData && newData.count != 0) {
        // 记录原有的数据
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.hyDataSource.dataSourceArray];
        
        // 添加新的数据
        [arrM addObjectsFromArray:newData];
        
        [self.hyDataSource resetDataWithArray:[arrM copy]];
    }
}

#pragma mark - 懒加载
// 没有数据的时候显示的背景view
- (HYNoneDataView *)noneDataBgView
{
    if (!_noneDataBgView) {
        _noneDataBgView = [HYNoneDataView view];
        // 刷新
        WeakSelf
        _noneDataBgView.refreshBtnClickBlock = ^{
            // 调用代理的下拉刷新方法
            if (Weakself.hyDelegate && [Weakself.hyDelegate respondsToSelector:@selector(hy_reloadData)]) {
                [Weakself.hyDelegate hy_reloadData];
            }
        };
    }
    return _noneDataBgView;
}

@end
