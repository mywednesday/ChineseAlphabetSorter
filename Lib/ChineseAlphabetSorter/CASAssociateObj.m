//
//  CASAssociateObj.m
//  MQRJ
//
//  Created by qnsoft on 16/3/22.
//  Copyright © 2016年 北京青牛科技有限公司. All rights reserved.
//

#import "CASAssociateObj.h"
#import "pinyin.h"


@implementation CASAssociateObj



+(instancetype) associateObj:(id) obj byKeyPath:(NSString *) keyPath {
    return [[self alloc] initWithObj:obj byKeyPath:keyPath];
}



-(instancetype) initWithObj:(id) obj byKeyPath:(NSString *) keyPath {
    self = [self init];
    if (self) {
        _obj = obj;
        
        
        id keyValue = [obj valueForKeyPath:keyPath];
        if ([keyValue isKindOfClass:[NSString class]]) {
            _spell = [self pinYinUpperCase: keyValue];
        } else {
            _spell = @"";
            NSLog(@"****** keyPath 指定的数据类型必须是 NSString ******");
        }
        
    }
    return self;
}


/**
 *  返回str的全大写拼音
 *
 *  @param str 输入字符串
 *
 *  @return str的大写拼音
 */
-(NSString *) pinYinUpperCase:(NSString *) str {
    //提取对应汉字的拼音
    
    if(str==nil)
        return @"";
    
    if(![str isEqualToString:@""]){
        NSString *pinYinResult = [NSString string];
        for(int j=0;j<str.length;j++){
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([str characterAtIndex:j])]uppercaseString];
            
            pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        return pinYinResult;
    }else{
        return @"";
    }
    return @"";
}





@end
