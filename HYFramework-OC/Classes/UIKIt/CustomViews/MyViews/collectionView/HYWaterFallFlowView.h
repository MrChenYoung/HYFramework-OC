//
//  HYWaterFallFlowView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/7.
//
#import "HYCollectionView.h"
#import "HYImageVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYWaterFallFlowView : HYCollectionView

#pragma mark - 工厂方法，获取对象
/**
 * 获取指定类型的HYCollectionView对象
 */
+ (HYWaterFallFlowView *)flowCollectionView;

/**
 * 图片列表 HYImageVideoModel类型
 * 单独设置image或remoteUrl(完整的网络地址)
 * 同时设置image和remoteUrl，使用image属性
 */
@property (nonatomic, copy) NSArray <HYImageVideoModel *>*imageListArray;

@end

NS_ASSUME_NONNULL_END
