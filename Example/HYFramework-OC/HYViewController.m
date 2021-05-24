//
//  HYViewController.m
//  HYFramework-OC
//
//  Created by mrchenyoung on 05/14/2021.
//  Copyright (c) 2021 mrchenyoung. All rights reserved.
//

#import "HYViewController.h"
#import "HYFramework.h"
#import "HYTestListCell.h"
#import "HYTestTableViewController.h"
#import "HYTestIndicatorController.h"

@interface HYViewController ()

// 数据
@property (nonatomic, copy) NSArray <HYBaseModel *>*dataArray;

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - 设置子view
- (void)setupSubviews
{
    [super setupSubviews];
    self.title = @"HYFramework";
    
    [self setupTableView];
    self.view.backgroundColor = self.tableView.backgroundColor = HYColorWhite;
    
    // 设置数据
    [self.dataSource resetDataWithArray:self.dataArray];
}

- (void)setupTableDataSource
{
    WeakSelf
    
    // 注册cell
    [self registCell:@"HYTestListCell"];
    // cell高度
    [self setupTableViewHeightAutomatic];
    // cell
    self.dataSource.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        HYTestListCell *cell = [table dequeueReusableCellWithIdentifier:@"HYTestListCell" forIndexPath:indexPath];
        cell.model = Weakself.dataArray[indexPath.row];
        return cell;
    };
    self.dataSource.didSelectRowAtIndexPath = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        switch (indexPath.row) {
            case 0:
                // 打开相册
                [Weakself openAlbum];
                break;
            case 1:
                // 打开相机
                [Weakself openCamera];
                break;
            case 2:
                // 上传文件
                [Weakself uploadFile];
                break;
            case 3:
                // tableView
                [Weakself tableViewPage];
                break;
            case 4:
                // 图片浏览器
                [Weakself imageBrowser];
                break;
            case 5:
                [Weakself testIndicator];
                break;
            default:
                break;
        }
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
        NSArray *titles = @[@"打开相册",@"打开相机",@"上传文件",@"tableView",@"图片浏览器",@"indicator"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i = 0; i < titles.count; i++) {
            NSString *t = titles[i];
            HYBaseModel *m = [HYBaseModel model];
            m.content = t;
            [arrM addObject:m];
        }
        _dataArray = [arrM copy];
    }
    return _dataArray;
}

@end
