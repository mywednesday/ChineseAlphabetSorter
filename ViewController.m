//
//  ViewController.m
//  ChineseAlphabetSorter
//
//  Created by qnsoft on 16/3/22.
//  Copyright © 2016年 wzp. All rights reserved.
//

#import "ViewController.h"
#import "RJTestModel.h"
#import "ChineseAlphabetSorter.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
}
@end
