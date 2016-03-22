//
//  CASAssociateObj.h
//  MQRJ
//
//  Created by qnsoft on 16/3/22.
//  Copyright © 2016年 北京青牛科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CASAssociateObj : NSObject

@property (nonatomic, copy) NSString *spell;        //关联对象obj中的字段 对应的拼音 ，全部大写
@property (nonatomic, copy) id obj;               //关联对象

+(instancetype) associateObj:(id) obj byKeyPath:(NSString *) keyPath;


@end
