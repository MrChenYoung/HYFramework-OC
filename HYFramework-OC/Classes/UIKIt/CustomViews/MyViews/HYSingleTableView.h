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
 * @param titleForSectionHeader section头部显示内容
 * @param sectionHeader sectionHeader修改回调
 * @param cellForRow cell修改回调
 */
- (void)setupSingleTableRowH:(CGFloat)rowHeight
                   cellStyle:(UITableViewCellStyle)cellStyle
       titleForSectionHeader:(NSString *(^)(NSInteger section))titleForSectionHeader
               sectionHeader:(void (^)(UIView *sectionHeaderBgView,UILabel *sectionHeaderTextLabel, NSInteger section))sectionHeader
                  cellForRow:(void (^)(HYBaseTableViewCell *cell,NSIndexPath *indexPath))cellForRow;

@end

NS_ASSUME_NONNULL_END
