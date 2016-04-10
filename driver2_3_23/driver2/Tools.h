//
//  Tools.h
//  driver2
//
//  Created by 易飞 on 15/12/31.
//  Copyright © 2015年 易飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
@interface Tools : NSObject
+(NSArray *)getAnswerWithString:(NSString *)str;
+(CGSize )getSizeWithString:(NSString *)str withFont:(UIFont *)font  withSize:(CGSize)size;
@end
