//
//  AnswerViewController.h
//  driver2
//
//  Created by 易飞 on 15/12/27.
//  Copyright © 2015年 易飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController
@property(nonatomic,assign)int number;
@property(nonatomic,copy)NSString *subStrNumber;
//type=1 章节练习 type＝2顺序练习  type＝3随机练习 type=4专项练习 type=5模拟考试（全真模拟）type=6模拟考试（优先考未做题） type＝7我的错题   type=8我的收藏
@property(nonatomic,assign)int type;
@end
