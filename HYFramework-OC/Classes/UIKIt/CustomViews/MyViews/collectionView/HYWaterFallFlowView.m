//
//  HYWaterFallFlowView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/7.
//

#import "HYWaterFallFlowView.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "HYBaseCollectionViewCell.h"
#import "HYConstMacro.h"
#import "SDWebImage.h"

@interface HYWaterFallFlowView ()

@end

@implementation HYWaterFallFlowView

#pragma mark - 工厂方法，获取对象
/**
 * 获取指定类型的HYCollectionView对象
 */
+ (HYWaterFallFlowView *)flowCollectionView
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    HYWaterFallFlowView *collection = (HYWaterFallFlowView *)[self collectionViewWithLayout:layout];
    
    // 设置CollectionDatasource
    [collection setupCollectionDataSource];
    
    return collection;
}

#pragma mark - 设置CollectionDatasource
// 设置CollectionDatasource
- (void)setupCollectionDataSource
{
    [super setupCollectionDataSource];
    
    WeakSelf
    // 注册cell
    [self registCell:@"HYBaseCollectionViewCell"];
    // cell
    self.hyDataSource.cellForItemAtIndexPath = ^UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collection, NSIndexPath * _Nonnull indexPath) {
        HYBaseCollectionViewCell *cell = (HYBaseCollectionViewCell *)[collection dequeueReusableCellWithReuseIdentifier:@"HYBaseCollectionViewCell" forIndexPath:indexPath];
        
        // 数据model
        HYImageVideoModel *imageModel = Weakself.hyDataSource.dataSourceArray[indexPath.item];
        
        // 图片显示
        if (imageModel.image) {
            // 设置本地图片
            cell.imageView.image = imageModel.image;
        }else {
            // 设置网络图片
            [cell.imageView sd_setImageWithURL:HYUrlWithString(imageModel.remoteUrl) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
        }
        
        // 文本内容显示
        cell.textLabel.text = imageModel.content;
        
        return cell;
    };
    // size
    self.hyDataSource.sizeForItemAtIndexPath = ^CGSize(NSIndexPath * _Nonnull indexPath) {
        return CGSizeMake(150, 150);
    };
}

#pragma mark - setter
// 设置图片列表
- (void)setImageListArray:(NSArray<HYImageVideoModel *> *)imageListArray
{
    _imageListArray = imageListArray;
    
    // 刷新瀑布流列表
    [self.hyDataSource resetDataWithArray:imageListArray];
}

@end
