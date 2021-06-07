//
//  HYCollectionSectionView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYCollectionSectionView : UICollectionReusableView

// 内容视图
@property (nonatomic, weak, readonly) UIView *contentView;

// 文本显示
@property (nonatomic, weak, readonly) UILabel *tLabel;

@end

NS_ASSUME_NONNULL_END
