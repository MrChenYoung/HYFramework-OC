//
//  HYTestListCell.m
//  HYFramework_Example
//
//  Created by MrChen on 2021/4/7.
//  Copyright © 2021 mrchenyoung. All rights reserved.
//

#import "HYTestListCell.h"

@interface HYTestListCell ()

// 文本显示
@property (nonatomic, weak) UILabel *textL;

@end

@implementation HYTestListCell

#pragma mark - 设置子view
- (void)setupSubViews
{
    [super setupSubViews];
    
    UILabel *label = UILabel.new;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = HYColorBgLight3;
    label.font = HYFontSystem(15);
    label.textColor = HYColorTextNormal;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(40);
    }];
    self.textL = label;
}

#pragma mark - 绑定数据
- (void)setModel:(HYBaseModel *)model
{
    [super setModel:model];
    
    self.textL.text = model.content;
}

@end
