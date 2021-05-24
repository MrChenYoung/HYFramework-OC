//
//  HYUserSingleton.m
//  AFNetworking
//
//  Created by 臻尚 on 2021/5/20.
//

#import "HYUserSingleton.h"
#import "HYFramework.h"

@implementation HYUserSingleton

#pragma mark - 单利创建
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static HYUserSingleton *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = [super allocWithZone:zone];
    });
    
    return singleTon;
}

+ (instancetype)share
{
    return [[self alloc]init];
}

#pragma mark - 其他
// 保存用户信息到磁盘
- (void)saveUserInfoOnDisk
{
    // 账号
    [HYUserDefaultsTool saveObjWithKey:HYUserAccountKey value:self.account];

    // 用户名
    [HYUserDefaultsTool saveObjWithKey:HYUserNameKey value:self.userName];

    // token
    [HYUserDefaultsTool saveObjWithKey:HYUserTokenKey value:self.token];

    // 是否已经认证
    [HYUserDefaultsTool saveBoolWithKey:HYUserApprovKey value:self.ifApprove];

    // 是否登录
    [HYUserDefaultsTool saveBoolWithKey:HYUserLoginStateKey value:self.isLogin];
}

// 从磁盘读取用户信息
- (void)readUserInfoFromDisk
{
    // 账号
    self.account = [HYUserDefaultsTool readObjWithKey:HYUserAccountKey];

    // 用户名
    self.userName = [HYUserDefaultsTool readObjWithKey:HYUserNameKey];

    // token
    self.token = [HYUserDefaultsTool readObjWithKey:HYUserTokenKey];

    // 是否已经认证
    self.ifApprove = [HYUserDefaultsTool readBoolWithKey:HYUserApprovKey];

    // 是否登录
    self.login = [HYUserDefaultsTool readBoolWithKey:HYUserLoginStateKey];
}

@end
