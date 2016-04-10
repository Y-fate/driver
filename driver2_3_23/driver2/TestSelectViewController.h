//
//  TestSelectViewController.h
//  driver2
//
//  Created by 易飞 on 15/12/12.
//  Copyright © 2015年 易飞. All rights reserved.
//
//第一章章节练习选择界面

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController
@property(nonatomic,copy)NSString * myTitle;
@property(nonatomic,copy)NSArray * dataArray;
//type＝1 章节练习  type=2 专项练习
@property(nonatomic,assign)int type;
@end
