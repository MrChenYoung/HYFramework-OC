//
//  HYCollectionSectionView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/7.
//

#import "HYCollectionSectionView.h"
#import "UIView+HYAdd.h"
#import "Masonry.h"
#import "HYConstMacro.h"

@interface HYCollectionSectionView ()

// 内容视图
@property (nonatomic, weak, readwrite) UIView *contentView;

// 文本显示
@property (nonatomic, weak, readwrite) UILabel *tLabel;

@end

@implementation HYCollectionSectionView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    // 设置子视图
    [self setupSubViews];
}

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubViews
{
    [super setupSubViews];
    
    // 内容视图
    UIView *contentView = UIView.new;
    contentView.backgroundColor = HYColorWhite;
    [self addSubview:contentView];
    self.contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 文本显示
    UILabel *tLabel = UILabel.new;
    tLabel.font = HYFontSystem(16);
    tLabel.textColor = HYColorTextNormal;
    [self.contentView addSubview:tLabel];
    self.tLabel = tLabel;
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
}

@end
