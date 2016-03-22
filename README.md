# ChineseAlphabetSorter
将对象按着其某个NSString类型的属性排序


//RJTestModel.h
@interface People : NSObject
@property (nonatomic, copy) NSString *name;
-(instancetype)initWithAddress:(NSString *) name;
@end




@interface RJTestModel : NSObject
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) People *people;
-(instancetype)initWithDepartment:(NSString *) department name:(NSString *) name;
@end





//测试／例子代码
NSArray *arr = [NSArray arrayWithObjects:[[RJTestModel alloc] initWithDepartment:@"公安局" name:@"王小华"],
                                              [[RJTestModel alloc] initWithDepartment:@"卫生局" name:@"孙小华"],
                                               [[RJTestModel alloc] initWithDepartment:@"法院" name:@"文大华"],
                                                [[RJTestModel alloc] initWithDepartment:@"旅游局" name:@"宋二华"],
                                                 [[RJTestModel alloc] initWithDepartment:@"公安局" name:@"赵将华"],
                                                  [[RJTestModel alloc] initWithDepartment:@"检察院" name:@"侯小华"],
                                                   [[RJTestModel alloc] initWithDepartment:@"电力局" name:@"侯大华"],
                                                    [[RJTestModel alloc] initWithDepartment:@"电力局" name:@"侯二华"],
                                                     [[RJTestModel alloc] initWithDepartment:@"电力局" name:@"王二华"], nil];
    
    
    ChineseAlphabetSorter *cas = [ChineseAlphabetSorter sharedInstance];
    [cas sortObejct:arr byKeyPath:@"people.name" ascending:NO];
    for (NSString *key in cas.orderedKey) {
        NSArray *modelArr = [cas.orderedObjectDic objectForKey:key];
        for (RJTestModel *model in modelArr) {
            NSLog(@"%@, %@", model.department, model.people.name);
        }
    }
    
    NSLog(@"\n\n\n#########################\n\n\n");
    
    
    [[ChineseAlphabetSorter sharedInstance] sortObejct:arr byKeyPath:@"department" ascending:YES completeBlock:^(NSArray *orderedKey, NSDictionary *orderedObjectDic) {
        for (NSString *key in orderedKey) {
            NSArray *modelArr = [orderedObjectDic objectForKey:key];
            for (RJTestModel *model in modelArr) {
                NSLog(@"%@, %@", model.department, model.people.name);
            }
        }
    }];
