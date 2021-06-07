//
//  HYCollectionView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/2.
//

#import "HYCollectionView.h"
#import "HYConstMacro.h"

@interface HYCollectionView ()

// dataSource对象
@property (nonatomic, strong, readwrite) HYCollectionDataSource *hyDataSource;

// 是否是加载更多
@property(nonatomic, assign, readwrite) BOOL isLoadMore;

// 没有数据的时候显示的背景view
@property (nonatomic, strong, readwrite) HYNoneDataView *noneDataBgView;

@end

@implementation HYCollectionView

#pragma mark - 工厂方法，获取对象
/**
 * 获取指定类型的HYCollectionView对象
 * @param layout 布局对象
 */
+ (HYCollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout
{
    // 创建collectionView 通过一个布局策略layout来创建
    HYCollectionView *collect = [[self alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collect.backgroundColor = HYColorWhite;
    // 设置collectionDataSource信息
    [collect setupCollectionDataSource];
    // 页码 默认1
    collect.pageIndex = 1;
    
    return collect;
}

// 所有view加载完成，也可以当做reloadData完成后调用的方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 没有数据的时候显示背景
    if ([self totalItemNumber] == 0) {
        self.backgroundView = self.noneDataBgView;
    }else {
        self.backgroundView = nil;
    }
}

#pragma mark - 注册cell
// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className
{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(NSClassFromString(className).class) bundle:nil] forCellWithReuseIdentifier:className];
}

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className
{
    [self registerClass:[NSClassFromString(className) class] forCellWithReuseIdentifier:className];
}

/**
 * 注册头部/尾部
 * @param className 类名
 * @param kind 类型(头部/尾部) UICollectionElementKindSectionHeader UICollectionElementKindSectionFooter
 */
- (void)registHeader:(NSString *)className kind:(NSString *)kind
{
    [self registerClass:NSClassFromString(className) forSupplementaryViewOfKind:kind withReuseIdentifier:className];
}

/**
 * 注册nib头部/尾部
 * @param className 类名
 * @param kind 类型(头部/尾部) UICollectionElementKindSectionHeader UICollectionElementKindSectionFooter
 */
- (void)registNibHeader:(NSString *)className kind:(NSString *)kind
{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(NSClassFromString(className).class) bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:className];
}

#pragma mark - 设置collectionView Datasource
// 设置collectionDataSource信息
- (void)setupCollectionDataSource
{
    // 创建datasource对象
    self.hyDataSource = [HYCollectionDataSource dataSourceWithCollection:self];
    
    // group类型的table section头部会有默认的空隙，设置头部高度去掉
    // section头部高度
//    self.hyDataSource.heightForHeaderInSection = ^CGFloat(UITableView * _Nonnull table, NSInteger section) {
//        return 0.00001;
//    };
//    self.hyDataSource.viewForHeaderInSection = ^UIView * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
//        return nil;
//    };
//    // section footer
//    self.hyDataSource.heightForFooterInSection = ^CGFloat(UITableView * _Nonnull table, NSInteger section) {
//        return 0.00001;
//    };
//    self.hyDataSource.viewForFooterInSection = ^UIView * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
//        return nil;
//    };
    
    // 调用代理设置的关于datasource和delegate方法
    if (self.hyDelegate && [self.hyDelegate respondsToSelector:@selector(hy_setupCollectionDataSource)]) {
        [self.hyDelegate hy_setupCollectionDataSource];
    }
}

#pragma mark - 其他
// 获取collectionView总共有多少个item
- (NSInteger)totalItemNumber
{
    NSInteger itemCount = 0;
    for (int i = 0; i < self.numberOfSections; i++) {
        itemCount += [self numberOfItemsInSection:i];
    }
    return itemCount;
}

// 设置默认数据
//- (void)setupDetaultsData
//{
//    // 页码 默认1
//    self.pageIndex = 1;
//
//    // section header属性
//    // 字体大小
//    self.sectionHeaderFont = HYFontSystem(16);
//
//    // 字体颜色
//    self.sectionHeaderTextColor = HYColorTextNormal;
//
//    // 背景颜色
//    self.sectionHeaderBgColor = HYColorBgLight2;
//    
//    // 左边距离屏幕距离
//    self.sectionHeaderLeftMargin = 10;
//
//    // 右边距离屏幕距离
//    self.sectionHeaderRightMargin = 10;
//}
//
//// 设置tableView高度自适应
//- (void)setupRowHeightAutomatic
//{
//    self.rowHeight = UITableViewAutomaticDimension;
//    self.estimatedRowHeight = 60;
//}

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

#pragma mark - setter
//// 是否显示默认的section header
//- (void)setShowDefaultSectionHeader:(BOOL)showDefaultSectionHeader
//{
//    _showDefaultSectionHeader = showDefaultSectionHeader;
//    
//    if (showDefaultSectionHeader) {
//        WeakSelf
//        // header 高度
//        self.hyDataSource.heightForHeaderInSection = ^CGFloat(UITableView * _Nonnull table, NSInteger section) {
//            return 50;
//        };
//        // header view
//        self.hyDataSource.viewForHeaderInSection = ^UIView * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
//            // 背景
//            UIView *bgView = UIView.new;
//            bgView.backgroundColor = Weakself.sectionHeaderBgColor;
//            bgView.backgroundColor = HYColorBgLight1;
//            
//            // label
//            UILabel *textLabel = UILabel.new;
//            textLabel.font = Weakself.sectionHeaderFont;
//            textLabel.textColor = Weakself.sectionHeaderTextColor;
//            if (Weakself.hyDataSource.titleForHeaderInSection) {
//                textLabel.text = Weakself.hyDataSource.titleForHeaderInSection(table,section);
//            }
//            [bgView addSubview:textLabel];
//            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(Weakself.sectionHeaderLeftMargin);
//                make.right.mas_equalTo(-Weakself.sectionHeaderRightMargin);
//                make.bottom.mas_equalTo(-5);
//                make.height.mas_equalTo(30);
//            }];
//            
//            return bgView;
//        };
//    }
//}

// 设置collectionView滚动方向
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [(UICollectionViewFlowLayout *)self.collectionViewLayout setScrollDirection:scrollDirection];
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
