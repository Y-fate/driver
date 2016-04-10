//
//  MyDataManager.h
//  driver2
//
//  Created by 易飞 on 15/12/25.
//  Copyright © 2015年 易飞. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    chapter,  //章节练习数据
    answer,   //答题数据
    subChapter//专项练习
}DataType;
@interface MyDataManager : NSObject
+(NSArray *)getData:(DataType)type;
@end
