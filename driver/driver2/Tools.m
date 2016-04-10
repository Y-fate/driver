
//
//  Tools.m
//  driver2
//
//  Created by 易飞 on 15/12/31.
//  Copyright © 2015年 易飞. All rights reserved.
//
//工具类
#import "Tools.h"
//把字符串以<BR>为分割点封开
@implementation Tools
+(NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSArray *arr=[str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for (int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}
//获取字符串在指定字体大小和边界的情况下 的文本所占用大小     NSStringDrawingUsesFontLeading为使用字体信息来计算线高度
//可在“NSStringDrawingOptions”中查找对应的options信息
+(CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size{
    CGSize newSize=[str  boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return newSize;
}
@end
