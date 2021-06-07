//
//  HYSingleCollectionView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//

#import "HYSingleCollectionView.h"
#import "HYConstMacro.h"
#import "HYCollectionHeaderView.h"

@implementation HYSingleCollectionView

#pragma mark - 工厂方法，获取对象
// 获取HYCollectionView对象，UICollectionViewFlowLayout类型布局
+ (HYCollectionView *)collectionView
{
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return [self collectionViewWithLayout:layout];
}

#pragma mark - 其他
/**
 * 简单的collectionView，九宫格布局等使用(cell上下间隔和左右间隔均为1)
 * @param numberOfItemForRow 每一行有多少个cell
 * @param itemAtIndexPath 每一个cell单独设置回调
 */
- (void)setupSingleCollectionCountForRow:(NSInteger)numberOfItemForRow
                         itemAtIndexPath:(void (^)(UICollectionViewCell *cell, NSIndexPath *indexPath))itemAtIndexPath
{
    [self setupSingleCollectionCountForRow:numberOfItemForRow lineSpacing:1 interitemSpacing:1 itemAtIndexPath:itemAtIndexPath];
}


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
    [self setupSingleCollectionCountForRow:numberOfItemForRow lineSpacing:lineSpacing interitemSpacing:interitemSpacing itemAtIndexPath:itemAtIndexPath heightForHeader:nil titleForSectionHeader:nil sectionHeaderBlock:nil];
}

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
                         heightForHeader:(CGFloat (^)(NSInteger section))heightForHeader
                   titleForSectionHeader:(NSString *(^)(NSInteger section))titleForSectionHeader
                      sectionHeaderBlock:(void (^)(UIView *sectionHeaderBgView,UILabel *sectionHeaderTextLabel, NSInteger section))sectionHeaderBlock
{
    // 注册cell
    [self registCell:@"UICollectionViewCell"];
    // 一行有多少个item
    self.hyDataSource.numberOfItemForRow = numberOfItemForRow;
    // item上下间距
    self.hyDataSource.minimumLineSpacingForSectionAtIndex = ^CGFloat(NSInteger section) {
        return lineSpacing;
    };
    // item左右间距
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
    // 注册头部
    [self registHeader:@"HYCollectionHeaderView" kind:UICollectionElementKindSectionHeader];
    // item 头部size
    self.hyDataSource.sizeForHeaderInSection = ^CGSize(UICollectionView * _Nonnull collectionView, NSInteger section) {
        CGFloat sH = heightForHeader ? heightForHeader(section) : 0;
        if ([(UICollectionViewFlowLayout *)collectionView.collectionViewLayout scrollDirection] == UICollectionViewScrollDirectionVertical) {
            // 垂直滚动
            return CGSizeMake(HYSCREEN_Width, sH);
        }else {
            // 水平滚动
            return CGSizeMake(sH, HYSCREEN_Height);
        }
    };
    // item头部
    self.hyDataSource.viewForHeaderAtIndexPath = ^UICollectionReusableView * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        HYCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYCollectionHeaderView" forIndexPath:indexPath];
        NSString *tText = titleForSectionHeader ? titleForSectionHeader(indexPath.section) : @"";
        headerView.tLabel.text = tText;
        
        // 对section header额外设置
        if (sectionHeaderBlock) {
            sectionHeaderBlock(headerView.contentView,headerView.tLabel,indexPath.section);
        }
        
        return headerView;
    };
}

@end
