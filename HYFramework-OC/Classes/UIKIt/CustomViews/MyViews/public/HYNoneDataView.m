//
//  HYNoneDataView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//

#import "HYNoneDataView.h"
#import "Masonry.h"
#import "HYConstMacro.h"
#import "NSString+HYFrame.h"

@interface HYNoneDataView ()

// 图片
@property (nonatomic, weak) UIImageView *imageView;

// 提示文本
@property (nonatomic, weak) UILabel *tipLabel;

// 刷新按钮
@property (nonatomic, weak) UIButton *refreshBtn;

@end

@implementation HYNoneDataView

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubViews
{
    [super setupSubViews];
    
    // 图片
    UIImage *image = [self podsImageWithName:@"empty"];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    [self addSubview:imageV];
    self.imageView = imageV;
    CGFloat hMargin = 120;
    CGFloat w = HYSCREEN_Width - hMargin * 2;
    CGFloat h = w/image.size.width * image.size.height;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hMargin);
        make.right.mas_equalTo(-hMargin);
        make.width.mas_equalTo(w);
        make.height.mas_equalTo(h);
        make.centerY.mas_equalTo(-h * 0.5 - 50);
    }];
    
    // 提示文字
    UILabel *tipLabel = UILabel.new;
    tipLabel.font = HYFontSystem(16);
    tipLabel.textColor = HYColorBgLight3;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"空空如也~";
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(imageV.mas_bottom).mas_equalTo(30);
    }];
    
    // 刷新按钮
    UIButton *refreshBtn = UIButton.new;
    refreshBtn.titleLabel.font = HYFontSystem(12);
    refreshBtn.layer.borderWidth = 1;
    refreshBtn.layer.borderColor = HYColorBgLight3.CGColor;
    refreshBtn.layer.cornerRadius = 3;
    refreshBtn.layer.masksToBounds = YES;
    NSString *title = @"刷新试试";
    CGFloat btnW = [title widthWithFont:refreshBtn.titleLabel.font] + 20;
    [refreshBtn setTitleColor:HYColorBgLight3 forState:UIControlStateNormal];
    [refreshBtn setTitle:title forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:refreshBtn];
    self.refreshBtn = refreshBtn;
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tipLabel);
        make.top.equalTo(tipLabel.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(btnW);
    }];
}

#pragma mark - 其他
// 获取图片
- (UIImage *)podsImageWithName:(NSString *)imageName
{
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/HYFramework-OC.bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageNamed:imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
}


#pragma mark - 事件
// 刷新按钮点击
- (void)refreshAction
{
    if (self.refreshBtnClickBlock) {
        self.refreshBtnClickBlock();
    }
}

#pragma mark - setter
// 重新设置views
- (void)setResetViewsBlock:(void (^)(UIView * _Nonnull, UILabel * _Nonnull, UIButton * _Nonnull))resetViewsBlock
{
    _resetViewsBlock = resetViewsBlock;
    
    // 如有需求 重新设置views
    if (resetViewsBlock) {
        resetViewsBlock(self.bgView,self.tipLabel,self.refreshBtn);
    }
}

@end
