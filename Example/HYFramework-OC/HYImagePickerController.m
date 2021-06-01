//
//  HYImagePickerController.m
//  HYFramework-OC_Example
//
//  Created by 臻尚 on 2021/6/1.
//  Copyright © 2021 mrchenyoung. All rights reserved.
//

#import "HYImagePickerController.h"

@interface HYImagePickerController ()

// 所有图片
@property (nonatomic, strong) NSMutableArray <HYImageVideoModel *>*imagesArray;

@end

@implementation HYImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubviews
{
    [super setupSubviews];
    
    // 标题
    self.title = @"图片选择器";
    
    WeakSelf
    // 添加底部按钮
    [self addBottomButtons:@[@"系统自带",@"第三方"] btnBgColors:@[HYColorBgLight1,HYColorTheme3] btnTColors:@[HYColorTheme3,HYColorWhite] actions:@[^{
        // 系统的
        [Weakself showActionSheetWithTitle:nil btnTitles:@[@"相册",@"相机"] btnActionBlocks:@[^{
            // 相册
            [Weakself openImagePickerView:PickerTypeAlbum pickerFileType:PickerFileTypeImage complete:^(HYImageVideoModel * _Nonnull imageVideoModel) {
                [Weakself.imagesArray addObject:imageVideoModel];
                
                // 刷新图片显示
                [Weakself updateImageViews];
            }];
        },^{
            // 相机
            [Weakself openImagePickerView:PickerTypeCamera pickerFileType:PickerFileTypeImage complete:^(HYImageVideoModel * _Nonnull imageVideoModel) {
                [Weakself.imagesArray addObject:imageVideoModel];
                
                // 刷新图片显示
                [Weakself updateImageViews];
            }];
        }] showCancelBtn:YES];
    },^{
        // 第三方的
        
    }]];
    [self.fview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(60 + HYSCREEN_Bottom_Safe_Height);
    }];
    
    // 添加scroll
    [self setupScrollView];
    // 约束
    [self.scrollV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(10);
        make.bottom.equalTo(self.fview.mas_top);
    }];
    
    
//    self.navController.navBarGlobalTitleColor = HYColorRed;
//    self.navController.navBarGlobalTitleFont = HYFontSystem(14);
//    self.navController.navBarGlobalBgColor = HYColorBlue;
//    self.navController.navBarGlobalBgColor
}

// 显示所有图片
- (void)updateImageViews
{
    // 移除所有图片
    [self.scrollContentView removeSubviewsWithClass:[UIImageView class]];
    
    // 图片宽高
    CGFloat imageW = HYSCREEN_Width/4.0;
    
    // 添加所有的图片
    CGFloat leftMargin = 0;
    CGFloat topMargin = 0;
    for (int i = 0; i < self.imagesArray.count; i++) {
        HYImageVideoModel *model = self.imagesArray[i];
        leftMargin = i%4 * imageW;
        topMargin = i/4 * imageW;
        UIImageView *imageV = [[UIImageView alloc]initWithImage:model.image];
//        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollContentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin);
            make.top.mas_equalTo(topMargin);
            make.width.height.mas_equalTo(imageW);
            // 最后一张图片
            if (i == self.imagesArray.count - 1) {
                make.bottom.equalTo(self.scrollContentView);
            }
        }];
    }
}

#pragma mark - 懒加载
// 所有图片
- (NSMutableArray<HYImageVideoModel *> *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

@end
