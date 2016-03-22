//
//  RJTestModel.m
//  MQRJ
//
//  Created by qnsoft on 16/3/22.
//  Copyright © 2016年 北京青牛科技有限公司. All rights reserved.
//

#import "RJTestModel.h"

@implementation RJTestModel


-(instancetype)initWithDepartment:(NSString *) department name:(NSString *) name;{
    self = [self init];
    if (self) {
        _department = department;
        _people = [[People alloc] initWithAddress:name];
    }
    return self;
}
@end




@implementation People
-(instancetype)initWithAddress:(NSString *) name {
    self = [self init];
    if (self) {
        _name = name;
    }
    return self;
}
@end