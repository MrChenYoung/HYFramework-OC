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
- (void)saveUserInfoOnDiskComplete:(void (^)(void))complete
{
    // 异步保存
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
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
        
        // 保存完成
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete();
            }
        });
    });
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

// 清空用户信息（退出登录时使用）
- (void)clearAllUserInfoComplete:(void (^)(void))complete
{
    // 账号
    self.account = nil;

    // 用户名
    self.userName = nil;

    // token
    self.token = nil;

    // 是否已经认证
    self.ifApprove = NO;

    // 是否登录
    self.login = NO;
    
    [self saveUserInfoOnDiskComplete:complete];
}

@end
