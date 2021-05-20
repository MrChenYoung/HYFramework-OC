//
//  HYUserSingleton.h
//  AFNetworking
//
//  Created by 臻尚 on 2021/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUserSingleton : NSObject

// token
@property (nonatomic, copy) NSString *token;

// 是否登录
@property (nonatomic, assign, getter=isLogin) BOOL login;


+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
