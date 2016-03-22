//
//  ChineseAlphabetSorter.h
//  MQRJ
//
//  Created by qnsoft on 16/3/21.
//  Copyright © 2016年 北京青牛科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface ChineseAlphabetSorter : NSObject

+(instancetype) sharedInstance;


//  有序的首字母  A B C D E F  NSString 类型
@property (nonatomic, copy) NSArray *orderedKey;

// ##组内## 有序的对象  以 orderedKey 作为 Key
@property (nonatomic, strong) NSMutableDictionary *orderedObjectDic;



/**
 *  将对象排序（支持中文和英文）
 *  默认升序排列
 *  结果：orderedKey 、 orderedObjectDic
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyPath 排序的关键字 NSString ;  KVO    eg: people.address ;   keyPath对应的变量可以是汉字 和 字母，或者两者的组合 */
-(void) sortObejct:(NSArray *) objArr byKeyPath:(NSString *) keyPath;



/**
 *  将对象排序（支持中文和英文）
 *  结果：orderedKey 、 orderedObjectDic
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyword 排序的关键字 NSString   KVO    eg: people.address
 *  @param ascending 排列顺序
 */
-(void) sortObejct:(NSArray *) objArr byKeyPath:(NSString *) keyPath ascending:(BOOL)ascending;


/**
 *  将对象排序（支持中文和英文）
 *  默认升序排列
 *  结果：orderedKey 、 orderedObjectDic   或者使用 completeBlock 返回结果
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyPath 排序的关键字 NSString ;  KVO    eg: people.address ;   keyPath对应的变量可以是汉字 和 字母，或者两者的组合
 */
-(void) sortObejct:(NSArray *) objArr
         byKeyPath:(NSString *) keyPath
     completeBlock:(void(^)(NSArray *orderedKey, NSDictionary *orderedObjectDic)) completeBlock;



/**
 *  将对象排序（支持中文和英文）
 *  结果：orderedKey 、 orderedObjectDic   或者使用 completeBlock 返回结果
 *
 *  @param mutArr  要排序的目标对象
 *  @param keyword 排序的关键字 NSString   KVO    eg: people.address
 *  @param ascending 排列顺序
 */
-(void) sortObejct:(NSArray *) objArr
         byKeyPath:(NSString *) keyPath
         ascending:(BOOL)ascending
     completeBlock:(void(^)(NSArray *orderedKey, NSDictionary *orderedObjectDic)) completeBlock;
















@end
