//
//  MyDataManager.m
//  driver2
//
//  Created by 易飞 on 15/12/25.
//  Copyright © 2015年 易飞. All rights reserved.
//
//数据管理类
#import "MyDataManager.h"
#import "FMDatabase.h"
#import "TestSelectModel.h"
#import "AnswerModel.h"
#import "subTestSelectModel.h"
@implementation MyDataManager
+(NSArray *)getData:(DataType)type{
    static FMDatabase *dataBase;
    //初始化数据库
    NSMutableArray *array=[[NSMutableArray alloc]init];
    if (dataBase==nil) {
        NSString *_path=[[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase=[[FMDatabase alloc]initWithPath:_path];
    }
    //判断是否打开数据库
    if ([dataBase open]) {
        NSLog(@" open ok");
    } else {
        return array;
    }
    //查找想要的数据
    switch (type) {
        case chapter:      //章节练习数据
        {   NSString *path=@"select pid,pname,pcount FROM firstlevel";
            FMResultSet *rs=[dataBase executeQuery:path];
            while ([rs next]) {
                TestSelectModel *model=[[TestSelectModel alloc]init];
                model.pid=[NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname=[rs stringForColumn:@"pname"];
                model.pcount=[NSString stringWithFormat:@"%d",[rs intForColumn:@"pcount"]];
                [array addObject:model];
                           
            }
        }
            break;
        case answer:      //答题数据
        {   NSString *path=@"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM leaflevel";
            FMResultSet *rs=[dataBase executeQuery:path];
            while ([rs next]) {
                AnswerModel *model=[[AnswerModel alloc]init];
                model.mquestion=[rs stringForColumn:@"mquestion"];
                model.mdesc=[rs stringForColumn:@"mdesc"];
                model.mid=[NSString stringWithFormat:@"%d",[rs intForColumn:@"mid"]];
                model.manswer=[rs stringForColumn:@"manswer"];
                model.mimage=[rs stringForColumn:@"mimage"];
                model.pid=[NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname=[rs stringForColumn:@"pname"];
                model.sid=[rs stringForColumn:@"sid"];
                model.sname=[rs stringForColumn:@"sname"];
                model.mtype=[NSString stringWithFormat:@"%d",[rs intForColumn:@"mtype"]];
                [array addObject:model];
                
   
            }
        }
            break;
        case subChapter:      //专项练习数据
        {   NSString *path=@"select serial,sid,sname,pid,scount,rcount FROM secondlevel";
            FMResultSet *rs=[dataBase executeQuery:path];
            while ([rs next]) {
                subTestSelectModel *model=[[subTestSelectModel alloc]init];
                model.serial=[NSString stringWithFormat:@"%d",[rs intForColumn:@"serial"]];
                model.sid=[rs stringForColumn:@"sid"];
                model.sname=[rs stringForColumn:@"sname"];
                model.pid=[NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.scount=[NSString stringWithFormat:@"%d",[rs intForColumn:@"scount"]];
                model.rcount=[NSString stringWithFormat:@"%d",[rs intForColumn:@"rcount"]];
                [array addObject:model];
                
            }
        }
            break;
            
        default:
            break;
    }
    return array;
}
@end
