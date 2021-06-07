//
//  HYBaseCollectionViewCell.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/7.
//

#import <UIKit/UIKit.h>
#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseCollectionViewCell : UICollectionViewCell

// 数据模型
@property (nonatomic, weak) HYBaseModel *model;

// 图片
@property (nonatomic, weak, readonly) UIImageView *imageView;

// 文本显示
@property (nonatomic, weak, readonly) UILabel *textLabel;

// 是否显示文本，默认YES
@property (nonatomic, assign) BOOL showText;

// 文本框的高度，默认30
@property (nonatomic, assign) CGFloat textHeight;

@end

NS_ASSUME_NONNULL_END
