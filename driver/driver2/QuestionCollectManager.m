//
//  QuestionCollectManager.m
//  driver2
//
//  Created by 易飞 on 16/3/6.
//  Copyright © 2016年 易飞. All rights reserved.
//

#import "QuestionCollectManager.h"

@implementation QuestionCollectManager

+(NSArray *)getwrongQuestion{

    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    if (array!=nil) {
        return array;
    } else {
        return @[];
    }
    
}


+(void)addWrongQuestion:(int)mid{
    
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    NSMutableArray  *mutArray=[NSMutableArray arrayWithArray:array];
    [mutArray  addObject:[NSString stringWithFormat:@"%d",mid]];
    [[NSUserDefaults standardUserDefaults] setObject:mutArray forKey:@"WRONG_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];    //同步到磁盘
    
}


+(void)removeWrongQuestion:(int)mid{

    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"WRONG_QUESTION"];
    NSMutableArray  *mutArray=[NSMutableArray arrayWithArray:array];
    for (int i=(int)mutArray.count-1; i>=0; i--) {
        
        if ((int)mutArray[i]==mid) {
            [mutArray removeObjectAtIndex:i];
        }
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutArray forKey:@"WRONG_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+(NSArray *)getCollectQuestion{
    
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"COLLECT_QUESTION"];
    if (array!=nil) {
        return array;
    } else {
        return @[];
    }
    
}


+(void)addCollectQuestion:(int)mid{
    
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"COLLECT_QUESTION"];
    NSMutableArray  *mutArray=[NSMutableArray arrayWithArray:array];
    [mutArray  addObject:[NSString stringWithFormat:@"%d",mid]];
    [[NSUserDefaults standardUserDefaults] setObject:mutArray forKey:@"COLLECT_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];    //同步到磁盘
    
}


+(void)removecollectQuestion:(int)mid{
    
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"COLLECT_QUESTION"];
    NSMutableArray  *mutArray=[NSMutableArray arrayWithArray:array];
    for (int i=(int)mutArray.count-1; i>=0; i--) {
        
        if ((int)mutArray[i]==mid) {
            [mutArray removeObjectAtIndex:i];
        }
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutArray forKey:@"COLLECT_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+(int)getScore{

    int score=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"MY_SCORE"];
    return score;

}



+(void)setScore:(int)score{

    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"MY_SCORE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
@end
