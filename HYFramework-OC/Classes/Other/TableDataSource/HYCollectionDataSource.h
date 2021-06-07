//
//  HYCollectionViewDataSource.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYCollectionDataSource : NSObject

// 数据集合
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

// 水平一行/垂直一行显示item个数(用于在不指定itemSize的情况下，计算每个item的大小)
@property (nonatomic, assign) NSInteger numberOfItemForRow;

// 每一行样式
@property (nonatomic, copy) UICollectionViewCell* (^cellForItemAtIndexPath)(UICollectionView *collection, NSIndexPath *indexPath);

// 点击每一个item回调
@property (nonatomic, copy) void(^didSelectItemAtIndexPath)(UICollectionView *collection, NSIndexPath *indexPath);

// section数量(默认1)
@property (nonatomic, copy) NSInteger(^numberOfSectionsInCollectionView)(void);

// item数量(默认为dataSourceArray属性count)
@property (nonatomic, copy) NSInteger(^numberOfItemsInSection)(NSInteger section);

// item大小，默认 50 * 50
@property (nonatomic, copy) CGSize (^sizeForItemAtIndexPath)(NSIndexPath *indexPath);

// item上下间距
@property (nonatomic, copy) CGFloat (^minimumLineSpacingForSectionAtIndex)(NSInteger section);

// item左右间距
@property (nonatomic, copy) CGFloat (^minimumInteritemSpacingForSectionAtIndex)(NSInteger section);

#pragma mark - section 头部&尾部
// sectionHeader size
@property (nonatomic, copy) CGSize (^sizeForHeaderInSection)(UICollectionView *collectionView, NSInteger section);

// sectionHeader view
@property (nonatomic, copy) UICollectionReusableView *(^viewForHeaderAtIndexPath)(UICollectionView *collectionView, NSIndexPath *indexPath);

// sectionFooter size
@property (nonatomic, copy) CGSize (^sizeForFooterInSection)(UICollectionView *collectionView, NSInteger section);

// sectionFooter view
@property (nonatomic, copy) UICollectionReusableView *(^viewForFooterAtIndexPath)(UICollectionView *collectionView, NSIndexPath *indexPath);

#pragma mark - 工厂方法
// 获取对象
+ (instancetype)dataSourceWithCollection:(UICollectionView *)collectionView;

#pragma mark - 其他
// 设置数据列表
- (void)resetDataWithArray:(NSArray *)array;

// 添加新数据
- (void)addDataWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
