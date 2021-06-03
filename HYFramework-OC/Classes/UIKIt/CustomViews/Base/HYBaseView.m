//
//  MyBaseCustemView.m
//  findme
//
//  Created by 臻尚 on 2021/2/20.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYBaseView.h"
#import "HYConstMacro.h"
#import "UIView+HYAdd.h"

@interface HYBaseView ()

@end

@implementation HYBaseView

#pragma mark - 工厂方法
// 自定义view初始化
+ (instancetype)view
{
    HYBaseView *v = [[self alloc]init];
    
    // 默认frame
    v.frame = HYSCREEN_Bounds;
    
    // 设置子view
    [v setupSubViews];
    
    return v;
}

@end
