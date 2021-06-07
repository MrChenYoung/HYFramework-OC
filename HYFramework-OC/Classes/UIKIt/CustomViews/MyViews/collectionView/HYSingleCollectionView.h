//
//  HYSingleCollectionView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//
#import "HYCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYSingleCollectionView : HYCollectionView

#pragma mark - 工厂方法，获取对象
// 获取HYCollectionView对象，UICollectionViewFlowLayout类型布局
+ (HYCollectionView *)collectionView;


#pragma mark - 其他
/**
 * 简单的collectionView，九宫格布局等使用(cell上下间隔和左右间隔均为1)
 * @param numberOfItemForRow 每一行有多少个cell
 * @param itemAtIndexPath 每一个cell单独设置回调
 */
- (void)setupSingleCollectionCountForRow:(NSInteger)numberOfItemForRow
                         itemAtIndexPath:(void (^)(UICollectionViewCell *cell, NSIndexPath *indexPath))itemAtIndexPath;

/**
 * 简单的collectionView，九宫格布局等使用
 * @param numberOfItemForRow 每一行有多少个cell
 * @param lineSpacing cell上下间距
 * @param interitemSpacing cell左右间距
 * @param itemAtIndexPath 每一个cell单独设置回调
 */
- (void)setupSingleCollectionCountForRow:(NSInteger)numberOfItemForRow
                             lineSpacing:(CGFloat)lineSpacing
                        interitemSpacing:(CGFloat)interitemSpacing
                         itemAtIndexPath:(void (^)(UICollectionViewCell *cell, NSIndexPath *indexPath))itemAtIndexPath;

/**
 * 简单的collectionView，九宫格布局等使用
 * @param numberOfItemForRow 每一行有多少个cell
 * @param lineSpacing cell上下间距
 * @param interitemSpacing cell左右间距
 * @param itemAtIndexPath 每一个cell单独设置回调
 * @param heightForHeader 头部高度
 * @param titleForSectionHeader 头部标题
 * @param sectionHeaderBlock 头部设置
 */
- (void)setupSingleCollectionCountForRow:(NSInteger)numberOfItemForRow
                             lineSpacing:(CGFloat)lineSpacing
                        interitemSpacing:(CGFloat)interitemSpacing
                         itemAtIndexPath:(void (^)(UICollectionViewCell *cell, NSIndexPath *indexPath))itemAtIndexPath
                         heightForHeader:(nullable CGFloat (^)(NSInteger section))heightForHeader
                   titleForSectionHeader:(nullable NSString *(^)(NSInteger section))titleForSectionHeader
                      sectionHeaderBlock:(nullable void (^)(UIView *sectionHeaderBgView,UILabel *sectionHeaderTextLabel, NSInteger section))sectionHeaderBlock;

@end

NS_ASSUME_NONNULL_END
