//
//  HYSingleCollectionView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//
#import "HYCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYSingleCollectionView : HYCollectionView

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

@end

NS_ASSUME_NONNULL_END
