//
//  HYFilePickerController.m
//  HYFramework-OC_Example
//
//  Created by 臻尚 on 2021/6/1.
//  Copyright © 2021 mrchenyoung. All rights reserved.
//

#import "HYFilePickerController.h"

@interface HYFilePickerController ()

@end

@implementation HYFilePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubviews
{
    [super setupSubviews];
    
    // 标题
    self.title = @"文件选择器";
    
//    self.navController.navBarGlobalTitleColor = HYColorRed;
//    self.navController.navBarGlobalTitleFont = HYFontSystem(14);
//    self.navController.navBarGlobalBgColor = HYColorBlue;
//    self.navController.navBarGlobalBgColor
}

@end
