//
//  HYBaseCollectionViewCell.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/7.
//

#import "HYBaseCollectionViewCell.h"
#import "UIView+HYAdd.h"
#import "HYConstMacro.h"
#import "Masonry.h"

@interface HYBaseCollectionViewCell ()

// 图片
@property (nonatomic, weak, readwrite) UIImageView *imageView;

// 文本显示
@property (nonatomic, weak, readwrite) UILabel *textLabel;

@end

@implementation HYBaseCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置子视图
        [self setupSubViews];
    }
    return self;
}

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubViews
{
    [super setupSubViews];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = HYColorBgLight1;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
    }];

    // 文本显示
    UILabel *textLabel = UILabel.new;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = HYFontSystem(16);
    textLabel.textColor = HYColorTextNormal;
    [self.contentView addSubview:textLabel];
    self.textLabel = textLabel;
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(10);
        make.top.equalTo(imageView.mas_bottom);
    }];
    // 文本框默认高度为30
    self.textHeight = 30;
}

#pragma mark - setter
// 是否显示文本，默认YES
- (void)setShowText:(BOOL)showText
{
    _showText = showText;
    
    // 设置文本框的高度
    self.textHeight = showText ? self.textHeight : 0;
}

// 文本框的高度，默认30
- (void)setTextHeight:(CGFloat)textHeight
{
    _textHeight = textHeight;
    
    [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
}

@end
