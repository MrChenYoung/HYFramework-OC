//
//  HYUserSingleton.m
//  AFNetworking
//
//  Created by 臻尚 on 2021/5/20.
//

#import "HYUserSingleton.h"

@implementation HYUserSingleton

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

@end
