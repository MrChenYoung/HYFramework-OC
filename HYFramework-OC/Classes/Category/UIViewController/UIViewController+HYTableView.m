//
//  UIViewController+TableView.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/9.
//

#import "UIViewController+HYTableView.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "HYConstMacro.h"
#import "UIScrollView+HYRefresh.h"

static char HYTableViewPropertyKey;
static char HYDatasourcePropertyKey;
static char HYPageIndexPropertyKey;
static char HYRowHPropertyKey;
static char HYLoadMoreDataKey;

@implementation UIViewController (HYTableView)

#pragma mark - 设置子视图
// 设置tableView
- (void)setupTableView
{
    // 默认cell分割线左右边距
//    self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 5);
    
    // 页码 默认从第一页开始
    self.pageIndex = 1;
    // 添加table
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    // 设置tableDataSource信息
    [self setupTableDataSource];
}

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部刷新
- (void)addHeaderRefresh
{
    WeakSelf
    [self.tableView addHeaderRefreshBlock:^{
        if ([Weakself respondsToSelector:@selector(reloadData)]) {
            [Weakself reloadData];
        }
    }];
}

// 添加上拉加载更多
- (void)addFootRefresh
{
    WeakSelf
    [self.tableView addFootRefreshBlock:^{
        if ([Weakself respondsToSelector:@selector(loadMore)]) {
            [Weakself loadMore];
        }
    }];
}

// 头部开始刷新
- (void)startRefresh
{
    [self.tableView startRefresh];
}

// 停止刷新(包括头部和尾部)
- (void)stopRefresh
{
    [self.tableView stopRefresh];
}

// 下拉刷新
- (void)reloadData
{
    // 复位页码
    self.pageIndex = 1;
    self.loadMoreData = NO;
    [self.dataSource.dataSourceArray removeAllObjects];
}

// 上拉加载更多
- (void)loadMore
{
    self.pageIndex++;
    self.loadMoreData = YES;
}

// 加载更多的情况下数据处理
- (void)loadMoreDataHandle:(NSArray *)newData
{
    if (self.loadMoreData && newData && newData.count != 0) {
        // 记录原有的数据
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.dataSource.dataSourceArray];
        
        // 添加新的数据
        [arrM addObjectsFromArray:newData];
        
        [self.dataSource resetDataWithArray:[arrM copy]];
    }
}


#pragma mark - 其他
// 设置tableDataSource信息
- (void)setupTableDataSource
{
    
}

// 设置tableView高度自适应
- (void)setupTableViewHeightAutomatic
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
}

// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(NSClassFromString(className).class) bundle:nil] forCellReuseIdentifier:className];
}

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className
{
    [self.tableView registerClass:[NSClassFromString(className) class] forCellReuseIdentifier:className];
}

#pragma mark - 关联属性
//getter
- (UITableView *)tableView
{
    UITableView *table = objc_getAssociatedObject(self, &HYTableViewPropertyKey);
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.tableFooterView = UIView.new;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.backgroundColor = HYColorBgLight;
        // 分割线颜色
        table.separatorColor = HYColorRGB(231, 231, 231);
        self.tableView = table;
    }
    return  table;
}
- (void)setTableView:(UITableView *)tableView
{
    objc_setAssociatedObject(self, &HYTableViewPropertyKey, tableView, OBJC_ASSOCIATION_RETAIN);
}

- (HYTableDataSource *)dataSource
{
    HYTableDataSource *dataSource = objc_getAssociatedObject(self, &HYDatasourcePropertyKey);
    if (dataSource == nil) {
        dataSource = [HYTableDataSource dataSourceWithTable:self.tableView];
        self.dataSource = dataSource;
    }
    return dataSource;
}
- (void)setDataSource:(HYTableDataSource *)dataSource
{
    objc_setAssociatedObject(self, &HYDatasourcePropertyKey, dataSource, OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)pageIndex
{
    NSNumber *pageIn = objc_getAssociatedObject(self, &HYPageIndexPropertyKey);
    return [pageIn integerValue];
}
- (void)setPageIndex:(NSInteger)pageIndex
{
    objc_setAssociatedObject(self, &HYPageIndexPropertyKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)rowHeight
{
    NSNumber *rowH = objc_getAssociatedObject(self, &HYRowHPropertyKey);
    return [rowH floatValue];
}
- (void)setRowHeight:(CGFloat)rowHeight
{
    objc_setAssociatedObject(self, &HYRowHPropertyKey, @(rowHeight), OBJC_ASSOCIATION_ASSIGN);
    self.tableView.rowHeight = rowHeight;
}

- (BOOL)loadMoreData
{
    NSNumber *rowH = objc_getAssociatedObject(self, &HYLoadMoreDataKey);
    return [rowH boolValue];
}
- (void)setLoadMoreData:(BOOL)loadMoreData
{
    objc_setAssociatedObject(self, &HYLoadMoreDataKey, @(loadMoreData), OBJC_ASSOCIATION_ASSIGN);
}

@end
