//
//  UIView+HYAdd.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, HYBorderPosition) {
    HYBorderPositionAll  = 0,
    HYBorderPositionTop = 1 << 0,
    HYBorderPositionBottom = 1 << 1,
    HYBorderPositionLeft = 1 << 2,
    HYBorderPositionRight = 1 << 3,
};

@interface UIView (HYAdd)

// 额外字符串类型的数据
@property (nonatomic, copy) NSString *extraString;

// 额外NSNumber类型的数据
@property (nonatomic, strong) NSNumber *extraNumber;

// 额外对象数据
@property (nonatomic, strong) id extraObject;

// view所在的控制器
@property (nonatomic, strong) UIViewController *viewController;


#pragma mark - 添加子视图
// 添加子视图
- (void)setupSubViews;



#pragma mark - 圆角
/**
 * 设置view圆角
 *  @param cornerRadius radius
 *  @param roundingCorners 圆角方向,可以设置多个,用|分割
 */
- (CAShapeLayer *)cornerWithRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;


#pragma mark - 边框
// 设置指定边有边框
- (void)borderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth borderPosition:(HYBorderPosition)borderPosition;

@end

NS_ASSUME_NONNULL_END
