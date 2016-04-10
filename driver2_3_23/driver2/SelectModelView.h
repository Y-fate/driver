//
//  SelectModelView.h
//  driver2
//
//  Created by 易飞 on 16/2/17.
//  Copyright © 2016年 易飞. All rights reserved.
//

//答题页选择模式视图
#import <UIKit/UIKit.h>

typedef enum{
    testmodel,
    lookingmodel
}SelectModel;
typedef void (^SelectTouch)(SelectModel model);

@interface SelectModelView : UIView

@property(nonatomic,assign)SelectModel model;
-(SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch;

@end
