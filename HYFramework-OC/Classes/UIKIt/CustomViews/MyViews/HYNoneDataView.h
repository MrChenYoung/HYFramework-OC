//
//  HYNoneDataView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//

#import <UIKit/UIKit.h>
#import "HYBaseView.h"
#import "UIView+HYAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYNoneDataView : HYBaseView

// 重新设置views
@property (nonatomic, copy) void (^resetViewsBlock)(UIView *bgView, UILabel *tipLabel, UIButton *refreshBtn);

// 刷新按钮点击
@property (nonatomic, copy) void (^refreshBtnClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
