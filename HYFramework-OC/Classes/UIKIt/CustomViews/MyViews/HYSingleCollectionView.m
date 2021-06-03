//
//  HYSingleCollectionView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//

#import "HYSingleCollectionView.h"

@implementation HYSingleCollectionView

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
                         itemAtIndexPath:(void (^)(UICollectionViewCell *cell, NSIndexPath *indexPath))itemAtIndexPath
{
    // 注册cell
    [self registCell:@"UICollectionViewCell"];
    self.hyDataSource.numberOfItemForRow = numberOfItemForRow;
    self.hyDataSource.minimumLineSpacingForSectionAtIndex = ^CGFloat(NSInteger section) {
        return lineSpacing;
    };
    self.hyDataSource.minimumInteritemSpacingForSectionAtIndex = ^CGFloat(NSInteger section) {
        return interitemSpacing;
    };
    // cell
    self.hyDataSource.cellForItemAtIndexPath = ^UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collection, NSIndexPath * _Nonnull indexPath) {
        UICollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        
        // 用于对cell的单独设置
        if (itemAtIndexPath) {
            itemAtIndexPath(cell,indexPath);
        }
        
        return cell;
    };
}

@end
