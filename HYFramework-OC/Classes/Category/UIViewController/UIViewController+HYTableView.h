//
//  UIViewController+TableView.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/9.
//

#import <UIKit/UIKit.h>
#import "HYTableView.h"
#import "HYBaseTableViewCell.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYTableView)<HYTableDelegate>

// table
@property (nonatomic, strong) HYTableView *tableView;

#pragma mark - 添加tableView
// 创建并添加tableView到self.view
- (void)setupTableView:(nullable void (^)(MASConstraintMaker *make))mas_makeConstraints;

// 创建并添加tableView到指定的view上
- (void)setupTableViewOnView:(UIView *)onView mas_makeConstraints:(nullable void (^)(MASConstraintMaker *make))mas_makeConstraints;

#pragma mark - 其他
/**
 * 设置简单的tableView
 * @param rowHeight 行高
 * @param cellStyle cell类型
 * @param titleForSectionHeader section头部显示内容
 * @param sectionHeader sectionHeader修改回调
 * @param cellForRow cell修改回调
 */
- (void)setupSingleTableRowH:(CGFloat)rowHeight
                   cellStyle:(UITableViewCellStyle)cellStyle
       titleForSectionHeader:(nullable NSString *(^)(NSInteger section))titleForSectionHeader
               sectionHeader:(nullable void (^)(UIView *sectionHeaderBgView,UILabel *sectionHeaderTextLabel, NSInteger section))sectionHeader
                  cellForRow:(void (^)(HYBaseTableViewCell *cell,NSIndexPath *indexPath))cellForRow;

@end

NS_ASSUME_NONNULL_END
