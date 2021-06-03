//
//  HYSingleTableView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/3.
//

#import "HYSingleTableView.h"
#import "HYConstMacro.h"

@implementation HYSingleTableView

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
                  cellForRow:(void (^)(HYBaseTableViewCell *cell,NSIndexPath *indexPath))cellForRow
{
    // 行高
    self.rowHeight = rowHeight;
    
    if (titleForSectionHeader) {
        // header 高度
        self.hyDataSource.heightForHeaderInSection = ^CGFloat(UITableView * _Nonnull table, NSInteger section) {
            return 50;
        };
        
        // header view
        self.hyDataSource.viewForHeaderInSection = ^UIView * _Nonnull(UITableView * _Nonnull table, NSInteger section) {
            // 背景
            UIView *bgView = UIView.new;
            bgView.backgroundColor = HYColorBgLight1;
            
            // label
            UILabel *textLabel = UILabel.new;
            textLabel.font = HYFontSystem(16);
            textLabel.textColor = HYColorTextNormal;
            if (titleForSectionHeader) {
                textLabel.text = titleForSectionHeader(section);
            }
            [bgView addSubview:textLabel];
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.bottom.mas_equalTo(-5);
                make.height.mas_equalTo(30);
            }];
            
            // 用于对sectionHeader的修改
            if (sectionHeader) {
                sectionHeader(bgView,textLabel,section);
            }
            
            return bgView;
        };
    }
    
    // cell
    self.hyDataSource.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        HYBaseTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"HYBaseTableViewCell"];
        
        if (cell == nil) {
            cell = [[HYBaseTableViewCell alloc]initWithStyle:cellStyle reuseIdentifier:@"HYBaseTableViewCell"];
        }
        
        // 对cell的扩展
        if (cellForRow) {
            cellForRow(cell,indexPath);
        }
        
        return cell;
    };
}

@end
