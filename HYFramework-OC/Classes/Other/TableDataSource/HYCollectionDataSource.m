//
//  HYCollectionViewDataSource.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/2.
//

#import "HYCollectionDataSource.h"
#import "UIView+HYFrame.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface HYCollectionDataSource ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CHTCollectionViewDelegateWaterfallLayout>

// collectionView
@property (nonatomic, weak) UICollectionView *collectionView;

// 不设置两个item上下间距属性(minimumLineSpacingForSectionAtIndex)，默认值
@property (nonatomic, assign) CGFloat lineSpacingDefault;

// 不设置两个item左右间距属性(minimumInteritemSpacingForSectionAtIndex)，默认值
@property (nonatomic, assign) CGFloat interitemSpacingDefault;


@end

@implementation HYCollectionDataSource

#pragma mark - 工厂方法
// 获取对象
+ (instancetype)dataSourceWithCollection:(UICollectionView *)collectionView
{
    HYCollectionDataSource *dataSource = [[self alloc]init];
    dataSource.collectionView = collectionView;
    collectionView.dataSource = dataSource;
    collectionView.delegate = dataSource;
    
    // 设置默认值
    [dataSource setupDetaultValues];
    
    return dataSource;
}

#pragma mark - 其他
// 设置数据列表
- (void)resetDataWithArray:(NSArray *)array
{
    [self.dataSourceArray removeAllObjects];
    [self addDataWithArray:array];
}

// 添加新数据
- (void)addDataWithArray:(NSArray *)array
{
    [self.dataSourceArray addObjectsFromArray:array];
    [self.collectionView reloadData];
}

// 设置默认数值
- (void)setupDetaultValues
{
    // 不设置两个item上下间距属性(minimumLineSpacingForSectionAtIndex)，默认值
    self.lineSpacingDefault = 5;
    // 不设置两个item左右间距属性(minimumInteritemSpacingForSectionAtIndex)，默认值
    self.interitemSpacingDefault = 5;
    
}


#pragma mark - UICollectionViewDataSource
// section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.numberOfSectionsInCollectionView) {
        return self.numberOfSectionsInCollectionView();
    }else {
        return 1;
    }
}

// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.numberOfItemsInSection) {
        return self.numberOfItemsInSection(section);
    }else {
        return self.dataSourceArray.count;
    }
}

// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellForItemAtIndexPath) {
        return self.cellForItemAtIndexPath(collectionView, indexPath);
    }else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    }
}

// 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectItemAtIndexPath) {
        self.didSelectItemAtIndexPath(collectionView, indexPath);
    }
}


// 头部大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.sizeForHeaderInSection) {
        return self.sizeForHeaderInSection(collectionView,section);
    }else {
        return CGSizeZero;
    }
}

// 尾部大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.sizeForFooterInSection) {
        return self.sizeForFooterInSection(collectionView,section);
    }else {
        return CGSizeZero;
    }
}

// 头部/尾部view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    // 区头
    if (kind == UICollectionElementKindSectionHeader) {
        if (self.viewForHeaderAtIndexPath) {
            reusableView = self.viewForHeaderAtIndexPath(collectionView,indexPath);
        }
    }
    
    
    // 区尾
    if (kind == UICollectionElementKindSectionFooter) {
        if (self.viewForFooterAtIndexPath) {
            reusableView = self.viewForFooterAtIndexPath(collectionView,indexPath);
        }
    }
    
    return reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sizeForItemAtIndexPath) {
        return self.sizeForItemAtIndexPath(indexPath);
    }else {
        // 根据设置的item间距计算item size
        CGFloat itemW = 0;
        UICollectionViewScrollDirection scrollDirection = UICollectionViewScrollDirectionVertical;
        if ([collectionViewLayout respondsToSelector:@selector(scrollDirection)]) {
            scrollDirection = [(UICollectionViewFlowLayout *)collectionViewLayout scrollDirection];
        }

        if (scrollDirection == UICollectionViewScrollDirectionVertical) {
            // 垂直滚动
            CGFloat horizontalSpace = self.minimumInteritemSpacingForSectionAtIndex ? self.minimumInteritemSpacingForSectionAtIndex(indexPath.section) : self.interitemSpacingDefault;
            NSInteger itemNumber = self.numberOfItemForRow == 0 ? 10 : self.numberOfItemForRow;
            itemW = (collectionView.hy_width - (itemNumber - 1) * horizontalSpace)/itemNumber;
        }else if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            // 水平滚动
            CGFloat verticalSpace = self.minimumLineSpacingForSectionAtIndex ? self.minimumLineSpacingForSectionAtIndex(indexPath.section) : self.lineSpacingDefault;
            NSInteger itemNumber = self.numberOfItemForRow == 0 ? 10 : self.numberOfItemForRow;
            itemW = (collectionView.hy_height - (itemNumber - 1) * verticalSpace)/itemNumber;
        }
        return CGSizeMake(itemW, itemW);
    }
}


// 两个item的上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.minimumLineSpacingForSectionAtIndex) {
        return self.minimumLineSpacingForSectionAtIndex(section);
    }else {
        // 取默认值
        return self.lineSpacingDefault;
    }
}

// 两个item的左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.minimumInteritemSpacingForSectionAtIndex) {
        return self.minimumInteritemSpacingForSectionAtIndex(section);
    }else {
        // 取默认值
        return self.interitemSpacingDefault;
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
// 瀑布流相关代理
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//   
////    ItemModel *model = [self.dataArray objectAtIndex:indexPath.row];
////    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
////        return model.imageSize;
////    }
//    return CGSizeMake(150, 150);
//}


#pragma mark - 懒加载
// 数据集合
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

@end
