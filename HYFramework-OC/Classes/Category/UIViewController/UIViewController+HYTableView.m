//
//  UIViewController+TableView.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/9.
//

#import "UIViewController+HYTableView.h"
#import <objc/runtime.h>
#import "HYFramework.h"

static char HYTableViewPropertyKey;

@implementation UIViewController (HYTableView)

#pragma mark - 添加tableView
// 创建并添加tableView到self.view
- (void)setupTableView:(void (^)(MASConstraintMaker *make))mas_makeConstraints
{
    [self setupTableViewOnView:self.view mas_makeConstraints:mas_makeConstraints];
}

// 创建并添加tableView到指定的view上
- (void)setupTableViewOnView:(UIView *)onView mas_makeConstraints:(void (^)(MASConstraintMaker *make))mas_makeConstraints
{
    // 添加tableView
    [onView addSubview:self.tableView];
    
    self.tableView.hyDelegate = self;
    // 设置tableView约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (mas_makeConstraints) {
            mas_makeConstraints(make);
        }else {
            make.edges.mas_equalTo(0);
        }
    }];
    
    // 设置tableDatasource
    [self.tableView setupTableDataSource];
}


#pragma mark - 其他
/**
 * 设置简单的tableView
 * @param rowHeight 行高
 * @param cellStyle cell类型
 * @param cellForRow cell修改回调
 */
- (void)setupSingleTableRowH:(CGFloat)rowHeight
                   cellStyle:(UITableViewCellStyle)cellStyle
                  cellForRow:(void (^)(HYBaseTableViewCell *cell,NSIndexPath *indexPath))cellForRow
{
    [(HYSingleTableView *)self.tableView setupSingleTableRowH:rowHeight cellStyle:cellStyle cellForRow:cellForRow];
}

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
       titleForSectionHeader:(NSString *(^)(NSInteger section))titleForSectionHeader
          sectionHeaderBlock:(void (^)(UIView *sectionHeaderBgView,UILabel *sectionHeaderTextLabel, NSInteger section))sectionHeaderBlock
{
    [(HYSingleTableView *)self.tableView setupSingleTableRowH:rowHeight cellStyle:cellStyle cellForRow:cellForRow headerHeight:headerHeight titleForSectionHeader:titleForSectionHeader sectionHeaderBlock:sectionHeaderBlock];
}

#pragma mark - 关联属性
//getter
- (HYTableView *)tableView
{
    HYTableView *table = objc_getAssociatedObject(self, &HYTableViewPropertyKey);
    if (table == nil) {
        table = [HYSingleTableView tableView];
        self.tableView = table;
    }
    return table;
}
- (void)setTableView:(HYTableView *)tableView
{
    objc_setAssociatedObject(self, &HYTableViewPropertyKey, tableView, OBJC_ASSOCIATION_RETAIN);
}


@end
