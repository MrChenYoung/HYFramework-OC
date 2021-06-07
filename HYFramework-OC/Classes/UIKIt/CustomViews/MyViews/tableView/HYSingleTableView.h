//
//  HYSingleTableView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//
#import "HYTableView.h"
#import "HYBaseTableViewCell.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYSingleTableView : HYTableView

/**
 * 设置简单的tableView
 * @param rowHeight 行高
 * @param cellStyle cell类型
 * @param cellForRow cell修改回调
 */
- (void)setupSingleTableRowH:(CGFloat)rowHeight
                   cellStyle:(UITableViewCellStyle)cellStyle
                  cellForRow:(void (^)(HYBaseTableViewCell *cell,NSIndexPath *indexPath))cellForRow;

/**
 * 设置简单的tableView
 * @param rowHeight 行高
 * @param cellStyle cell类型
 * @param cellForRow cell修改回调
 * @param headerHeight section头部高度
 * @param titleForSectionHeader section头部显示内容
 * @param sectionHeaderBlock section头部修改回调
 */
- (void)setupSingleTableRowH:(CGFloat)rowHeight
                   cellStyle:(UITableViewCellStyle)cellStyle
                  cellForRow:(void (^)(HYBaseTableViewCell *cell,NSIndexPath *indexPath))cellForRow
                headerHeight:(nullable CGFloat (^)(NSInteger section))headerHeight
       titleForSectionHeader:(nullable NSString *(^)(NSInteger section))titleForSectionHeader
          sectionHeaderBlock:(nullable void (^)(UIView *sectionHeaderBgView,UILabel *sectionHeaderTextLabel, NSInteger section))sectionHeaderBlock;

@end

NS_ASSUME_NONNULL_END
