//
//  UIViewController+HYCollectionView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/2.
//

#import "UIViewController+HYCollectionView.h"
#import <objc/runtime.h>
#import "HYSingleCollectionView.h"

static char HYCollectionViewPropertyKey;

@implementation UIViewController (HYCollectionView)

#pragma mark - 添加collectionView
// 创建并添加collectionView到当前控制器的view上
- (void)setupCollectionView:(void (^)(MASConstraintMaker *make))mas_makeConstraints
{
    [self setupCollectionViewOnView:self.view mas_makeConstraints:mas_makeConstraints];
}

// 创建并添加collectionView到指定的view上
- (void)setupCollectionViewOnView:(UIView *)onView mas_makeConstraints:(void (^)(MASConstraintMaker *make))mas_makeConstraints
{
    // 添加collection
    [onView addSubview:self.collectionView];
    
    self.collectionView.hyDelegate = self;
    // 设置collectionView约束
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (mas_makeConstraints) {
            mas_makeConstraints(make);
        }else {
            make.edges.mas_equalTo(0);
        }
    }];
    
    // 设置collectionDatasource
    [self.collectionView setupCollectionDataSource];
}

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
                         itemAtIndexPath:(void (^)(UICollectionViewCell *cell, NSIndexPath *indexPath))itemAtIndexPath
{
    [(HYSingleCollectionView *)self.collectionView setupSingleCollectionCountForRow:numberOfItemForRow lineSpacing:lineSpacing interitemSpacing:interitemSpacing itemAtIndexPath:itemAtIndexPath];
}


#pragma mark - 关联属性
//getter
- (HYCollectionView *)collectionView
{
    HYCollectionView *collection = objc_getAssociatedObject(self, &HYCollectionViewPropertyKey);
    if (collection == nil) {
        collection = [HYSingleCollectionView collectionView];
        self.collectionView = collection;
    }
    return collection;
}
- (void)setCollectionView:(HYCollectionView *)collectionView
{
    objc_setAssociatedObject(self, &HYCollectionViewPropertyKey, collectionView, OBJC_ASSOCIATION_RETAIN);
}



@end
