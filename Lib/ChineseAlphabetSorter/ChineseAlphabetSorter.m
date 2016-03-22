//
//  ChineseAlphabetSorter.m
//  MQRJ
//
//  Created by qnsoft on 16/3/21.
//  Copyright © 2016年 北京青牛科技有限公司. All rights reserved.
//

#import "ChineseAlphabetSorter.h"
#import "CASAssociateObj.h"







@implementation ChineseAlphabetSorter

-(NSArray *)orderedKey {
    if (!_orderedKey) {
        _orderedKey = [NSArray array];
    }
    return _orderedKey;
}
-(NSMutableDictionary *)orderedObjectDic {
    if (!_orderedObjectDic) {
        _orderedObjectDic = [NSMutableDictionary dictionary];
    }
    return _orderedObjectDic;
}



+(instancetype)sharedInstance{
    return [self new];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
-(instancetype)init{
    static dispatch_once_t onceToken;
    static typeof(self) instance;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}



/**
 *  将对象排序
 *  默认升序排列:ascending = YES
 *  @param mutArr  要排序的目标对象
 *  @param keyPath 排序的关键字 NSString   KVO
 */
-(void) sortObejct:(NSArray *) objArr byKeyPath:(NSString *) keyPath {
    [self sortObejct:objArr byKeyPath:keyPath ascending: YES];
}



/**
 *  将对象排序
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyword 排序的关键字 NSString   KVO    eg: people.address
 *  @param ascending 排列顺序
 */
-(void) sortObejct:(NSArray *) objArr byKeyPath:(NSString *) keyPath ascending:(BOOL)ascending {
    
    [self sortObejct:objArr byKeyPath:keyPath ascending:ascending completeBlock:nil];
}







/**
 *  将对象排序（支持中文和英文）
 *  默认升序排列
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyPath 排序的关键字 NSString ;  KVO    eg: people.address ;   keyPath对应的变量可以是汉字 和 字母，或者两者的组合
 */
-(void) sortObejct:(NSArray *) objArr
         byKeyPath:(NSString *) keyPath
     completeBlock:(void(^)(NSArray *orderedKey, NSDictionary *orderedObjectDic)) completeBlock {
    
    [self sortObejct:objArr byKeyPath:keyPath ascending:YES completeBlock:completeBlock];
}



/**
 *  将对象排序（支持中文和英文）
 *  默认升序排列:ascending = YES
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyword 排序的关键字 NSString   KVO    eg: people.address
 *  @param ascending 排列顺序
 */
-(void) sortObejct:(NSArray *) objArr
         byKeyPath:(NSString *) keyPath
         ascending:(BOOL)ascending
     completeBlock:(void(^)(NSArray *orderedKey, NSDictionary *orderedObjectDic)) completeBlock {

    if(![objArr count])
        return;
    
    //初始化
    self.orderedObjectDic = nil;
    
    
    // 1. 封装数据格式
    NSMutableArray *selfMutArr = [NSMutableArray array];
    for (id obj in objArr) {
        [selfMutArr addObject:[CASAssociateObj associateObj:obj byKeyPath:keyPath]];
    }
    
    //    NSLog(@"%@",selfMutArr);
    
    // 2. 排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"spell" ascending:ascending]];
    [selfMutArr sortUsingDescriptors:sortDescriptors];
    
    
    // 3. 分组
    for(int i=0; i<[selfMutArr count];i++){
        CASAssociateObj *associateObj = [selfMutArr objectAtIndex:i];
        if ([associateObj.spell length] < 1)
            continue;
        
        
        NSString *s=[associateObj.spell substringToIndex:1];
        
        
        
        if ([s isEqualToString:@"A"] || [s isEqualToString:@"B"] || [s isEqualToString:@"C"] || [s isEqualToString:@"D"] || [s isEqualToString:@"E"] ||
            [s isEqualToString:@"F"] || [s isEqualToString:@"G"] || [s isEqualToString:@"H"] || [s isEqualToString:@"I"] || [s isEqualToString:@"J"] ||
            [s isEqualToString:@"K"] || [s isEqualToString:@"L"] || [s isEqualToString:@"M"] || [s isEqualToString:@"N"] || [s isEqualToString:@"O"] ||
            [s isEqualToString:@"P"] || [s isEqualToString:@"Q"] || [s isEqualToString:@"R"] || [s isEqualToString:@"S"] || [s isEqualToString:@"T"] ||
            [s isEqualToString:@"U"] || [s isEqualToString:@"V"] || [s isEqualToString:@"W"] || [s isEqualToString:@"X"] || [s isEqualToString:@"Y"] ||
            [s isEqualToString:@"Z"]) {
            
            NSMutableArray *arrTmp = (NSMutableArray *)[self.orderedObjectDic objectForKey: s];
            if (nil == arrTmp) {
                arrTmp = [[NSMutableArray alloc] init];
            }
            [arrTmp addObject:associateObj.obj];
            [self.orderedObjectDic setObject:arrTmp forKey: s];
        }
    }
    
    // 4. 索引肤质并排序
    self.orderedKey = [[self.orderedObjectDic allKeys] sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if (ascending) {
            return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        } else {
            return [obj2 compare:obj1 options:NSCaseInsensitiveSearch];
        }
        
        return NSOrderedSame;
    }];
    
    //    // 5. 清理没有对象的分组 (并没有清理的必要， 不存在的Key其实是没有添加的)
    //    for (NSString *key in self.orderedKey) {
    //         NSMutableArray *arrTmp = (NSMutableArray *)[_orderedObjectDic objectForKey: key];
    //        if ([arrTmp count] == 0) {
    //            [_orderedObjectDic removeObjectForKey:key];
    //        }
    //    }

    
    
    if (completeBlock) {
        completeBlock(self.orderedKey, self.orderedObjectDic);
    }
    
}








@end
