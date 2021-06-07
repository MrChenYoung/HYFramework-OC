//
//  HYCollectionView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/2.
//

#import <UIKit/UIKit.h>
#import "HYCollectionDataSource.h"
#import "UIScrollView+HYRefresh.h"
#import "HYNoneDataView.h"

NS_ASSUME_NONNULL_BEGIN

// 刷新数据一级设置数据源回调代理
@protocol HYCollectionDelegate <NSObject>

// 下拉刷新调用方法
- (void)hy_reloadData;

// 上拉加载更多调用方法
- (void)hy_loadMoreData;

// 设置tableDataSource信息
- (void)hy_setupCollectionDataSource;

@end

@interface HYCollectionView : UICollectionView

// dataSource对象
@property (nonatomic, strong, readonly) HYCollectionDataSource *hyDataSource;

// 设置collectionView滚动方向
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

// 页码
@property(nonatomic, assign) NSInteger pageIndex;

// 是否是加载更多
@property(nonatomic, assign, readonly) BOOL isLoadMore;

// 是否显示默认的section头部
@property(nonatomic, assign) BOOL showDefaultSectionHeader;

// 代理, 用于设置下拉刷新和上拉加载更多调用方法，以及设置collectionDatasource
@property (nonatomic, weak) id <HYCollectionDelegate>hyDelegate;

// 没有数据的时候显示的背景view
@property (nonatomic, strong, readonly) HYNoneDataView *noneDataBgView;

#pragma mark - 工厂方法，获取对象
/**
 * 获取指定类型的HYCollectionView对象
 * @param layout 布局对象
 */
+ (HYCollectionView *)collectionViewWithLayout:(UICollectionViewLayout *)layout;

#pragma mark - 注册cell/header/footer
// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className;

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className;

/**
 * 注册头部/尾部
 * @param className 类名
 * @param kind 类型(头部/尾部) UICollectionElementKindSectionHeader UICollectionElementKindSectionFooter
 */
- (void)registHeader:(NSString *)className kind:(NSString *)kind;

/**
 * 注册nib头部/尾部
 * @param className 类名
 * @param kind 类型(头部/尾部) UICollectionElementKindSectionHeader UICollectionElementKindSectionFooter
 */
- (void)registNibHeader:(NSString *)className kind:(NSString *)kind;


#pragma mark - 设置collectionView Datasource
// 设置collectionDataSource信息
- (void)setupCollectionDataSource;

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部下拉刷新
- (void)addHeaderRefresh;

// 添加尾部上拉加载更多
- (void)addFootRefresh;

// 头部开始刷新
- (void)startHeaderRefresh;

// 停止刷新(包括头部和尾部)
- (void)stopAllRefresh;

@end

NS_ASSUME_NONNULL_END
