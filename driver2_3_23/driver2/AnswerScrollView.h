//
//  AnswerScrollView.h
//  driver2
//
//  Created by 易飞 on 15/12/27.
//  Copyright © 2015年 易飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerModel.h"

@interface AnswerScrollView : UIView
{
    @public
    UIScrollView * _scrollView;
}
@property(nonatomic,assign,readonly)int currentPage;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *hadAnswerArray;  //我回答的答案
@property(nonatomic,copy)AnswerModel *currentModel;   //当前答案的model

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;
-(void)reloadData;

@end
