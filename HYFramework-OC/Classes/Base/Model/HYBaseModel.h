//
//  BaseModel.h
//  FindmiWorkers
//
//  Created by 臻尚 on 2020/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseModel : NSObject

// id
@property (nonatomic, copy) NSString *ID;
// content
@property (nonatomic, copy) NSString *content;
// content2
@property (nonatomic, copy) NSString *content2;
// content3
@property (nonatomic, copy) NSString *content3;
// content4
@property (nonatomic, copy) NSString *content4;
// content5
@property (nonatomic, copy) NSString *content5;

// 额外数据
@property (nonatomic, strong) id extensionData;

// 是否选中
@property (nonatomic, assign) BOOL sel;

// 快速创建model
+ (instancetype)model;

// 时间戳转换成日期
- (NSString *)dateStringTranslate:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
