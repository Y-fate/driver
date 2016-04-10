//
//  QuestionCollectManager.h
//  driver2
//
//  Created by 易飞 on 16/3/6.
//  Copyright © 2016年 易飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCollectManager : NSObject

+(NSArray *)getwrongQuestion;
+(void)addWrongQuestion:(int)mid;
+(void)removeWrongQuestion:(int)mid;

+(NSArray *)getCollectQuestion;
+(void)addCollectQuestion:(int)mid;
+(void)removecollectQuestion:(int)mid;

+(int)getScore;
+(void)setScore:(int)score;


@end
