//
//  SheetView.h
//  driver2
//
//  Created by 易飞 on 16/2/19.
//  Copyright © 2016年 易飞. All rights reserved.
//
//科目一答题页面抽屉视图

#import <UIKit/UIKit.h>
@protocol   sheetViewDelegate
-(void)sheetViewClick:(int)index;
@end

@interface SheetView : UIView
{
    
@public
    UIView *_backView;
}
@property(nonatomic,weak)id<sheetViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)SuperView  andQuesCount:(int)count;

@end
