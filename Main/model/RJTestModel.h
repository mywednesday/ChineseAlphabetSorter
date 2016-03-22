//
//  RJTestModel.h
//  MQRJ
//
//  Created by qnsoft on 16/3/22.
//  Copyright © 2016年 北京青牛科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property (nonatomic, copy) NSString *name;
-(instancetype)initWithAddress:(NSString *) name;

@end




@interface RJTestModel : NSObject

@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) People *people;


-(instancetype)initWithDepartment:(NSString *) department name:(NSString *) name;

@end
