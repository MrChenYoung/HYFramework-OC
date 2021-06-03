//
//  HYViewController.m
//  HYFramework-OC
//
//  Created by mrchenyoung on 05/14/2021.
//  Copyright (c) 2021 mrchenyoung. All rights reserved.
//

#import "HYRootViewController.h"
#import "HYFramework.h"
#import "HYTestListCell.h"
#import "HYTestTableViewController.h"
#import "HYTestIndicatorController.h"

@interface HYRootViewController ()

// 数据
@property (nonatomic, copy) NSArray <HYBaseModel *>*dataArray;

@end

@implementation HYRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


#pragma mark - 设置子view
- (void)setupSubviews
{
    [super setupSubviews];
    self.title = @"HYFramework";
    
    // 添加tableView
    [self setupTableView:nil];
    self.view.backgroundColor = self.tableView.backgroundColor = HYColorWhite;
    
    // 设置成简单的tableView
    WeakSelf
    [self setupSingleTableRowH:60 cellStyle:UITableViewCellStyleDefault titleForSectionHeader:nil sectionHeader:nil cellForRow:^(HYBaseTableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        HYBaseModel *model = Weakself.dataArray[indexPath.row];
        cell.textLabel.text = model.content;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
    
    // 设置数据
    [self.tableView.hyDataSource resetDataWithArray:self.dataArray];
}

- (void)hy_setupTableDataSource
{
    WeakSelf
    self.tableView.hyDataSource.didSelectRowAtIndexPath = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        HYBaseModel *model = Weakself.dataArray[indexPath.row];
        NSString *ctrName = model.content2;
        if (HYStringEmpty(ctrName)) return;
        
        // 进入指定的控制器
        UIViewController *ctr = [[NSClassFromString(ctrName) alloc]init];
        [Weakself.navigationController pushViewController:ctr animated:YES];
    };
}

#pragma mark - 操作
// 打开相册
- (void)openAlbum
{
    [self openImagePickerView:PickerTypeAlbum pickerFileType:PickerFileTypeImageAndVideo complete:^(HYImageVideoModel * _Nonnull imageVideoModel) {
        NSLog(@"选择的照片：%@",imageVideoModel);
    }];
}

// 打开相机
- (void)openCamera
{
    [self openImagePickerView:PickerTypeCamera pickerFileType:PickerFileTypeImageAndVideo complete:^(HYImageVideoModel * _Nonnull imageVideoModel) {
        NSLog(@"选择的照片：%@",imageVideoModel);
    }];
}

// 上传文件
- (void)uploadFile
{
    [self showActionSheetWithTitle:nil btnTitles:@[@"选择照片",@"选择文件"] btnActionBlocks:@[^{
        // 选择照片
        [self openImagePickerView:PickerTypeAlbum pickerFileType:PickerFileTypeImageAndVideo complete:^(HYImageVideoModel * _Nonnull imageVideoModel) {
            
        }];
    },^{
        // 选择文件
        [self openDocumentPickerViewComplete:^(HYFileModel * _Nonnull fileModel, BOOL success, NSError * _Nullable error) {
            
        }];
    }] showCancelBtn:YES];
}

// tableview
- (void)tableViewPage
{
    HYTestTableViewController *tableCtr = [[HYTestTableViewController alloc]init];
    [self pushWithCotroller:tableCtr];
}

// 图片浏览器
- (void)imageBrowser
{
    NSArray *images = @[
        @"https://pic1.zhimg.com/v2-4bba972a094eb1bdc8cbbc55e2bd4ddf_1440w.jpg?source=172ae18b",
        @"https://img.iplaysoft.com/wp-content/uploads/2019/free-images/free_stock_photo.jpg",
        @"https://static.runoob.com/images/demo/demo2.jpg",
        @"https://img95.699pic.com/photo/50046/5562.jpg_wh300.jpg",
        @"1",
        @"2",
        @"http://120.78.148.58:18//Upload/renwu/2021/04/13175402633347_1618307629123.png",
        @"http://114.115.151.66:1020/zhongboLoans-app/zhongboImage/2021042015/544382411685892096.jpg"
    ];

    //查看图片
    NSMutableArray *array = [NSMutableArray new];
    for (NSString *imageStr in images) {
        HYImageVideoModel *model = [[HYImageVideoModel alloc]init];
        if ([imageStr hasPrefix:@"http"] || [imageStr hasPrefix:@"https"]) {
            model.remoteUrl = imageStr;
        }else {
            model.image = HYImageNamed(imageStr);
        }

        [array addObject:model];
    }
    [UIViewController previewImageVideo:array];
}

- (void)testIndicator
{
    HYTestIndicatorController *ctr = [[HYTestIndicatorController alloc]init];
    [self.navigationController pushViewController:ctr animated:YES];
}


#pragma mark - 网络
// 上传文件
- (void)uploadFileRequest:(HYFileModel *)fileModel
{
//    [self uploadFileWithParams:<#(nonnull NSDictionary *)#> fileModel:<#(nonnull HYFileModel *)#> success:<#^(NSString * _Nullable returnUrl)success#> faile:<#^(void)faile#> showHud:<#(BOOL)#>]
}


#pragma mark - 懒加载
- (NSArray<HYBaseModel *> *)dataArray
{
    if (_dataArray == nil) {
        NSArray *titles = @[@{
                                @"text":@"图片选择器",
                                @"ctr":@"HYImagePickerController"
        },@{
                                @"text":@"文件选择器",
                                @"ctr":@"HYFilePickerController"
        },@{
                                @"text":@"图片浏览器",
                                @"ctr":@""
        },@{
                                @"text":@"测试tableView",
                                @"ctr":@"HYTestTableViewController"
        }];
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i = 0; i < titles.count; i++) {
            NSDictionary *dict = titles[i];
            HYBaseModel *m = [HYBaseModel model];
            m.content = dict[@"text"];
            m.content2 = dict[@"ctr"];
            [arrM addObject:m];
        }
        _dataArray = [arrM copy];
    }
    return _dataArray;
}

@end
