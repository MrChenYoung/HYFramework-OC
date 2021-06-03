//
//  UIViewController+HYCollectionView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/2.
//

#import <UIKit/UIKit.h>
#import "HYCollectionView.h"
#import "HYConstMacro.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYCollectionView)<HYCollectionDelegate>

// collectionView
@property (nonatomic, strong) HYCollectionView *collectionView;

#pragma mark - 如果使用默认的cell，cell内容设置
// textlabel
@property (nonatomic, copy) NSString *(^textLabelContentBlock)(NSIndexPath *indexPath);
// detailTextLabel
@property (nonatomic, copy) NSString *(^detailTextLabelContentBlock)(NSIndexPath *indexPath);
// cell style
@property (nonatomic, copy) UITableViewCellStyle (^cellStyleBlock)(NSIndexPath *indexPath);
// cell accessType
@property (nonatomic, copy) UITableViewCellAccessoryType (^cellAccessoryTypeBlock)(NSIndexPath *indexPath);

#pragma mark - 添加collectionView
// 创建并添加collectionView到当前控制器的view上
- (void)setupCollectionView:(nullable void (^)(MASConstraintMaker *make))mas_makeConstraints;

// 创建并添加collectionView到指定的view上
- (void)setupCollectionViewOnView:(UIView * )onView mas_makeConstraints:(nullable void (^)(MASConstraintMaker *make))mas_makeConstraints;

#pragma mark - 其他
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
