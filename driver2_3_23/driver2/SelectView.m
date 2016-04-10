//
//  SelectView.m
//  driver2
//
//  Created by 易飞 on 15/10/25.
//  Copyright © 2015年 易飞. All rights reserved.
//
//首页透明选车型界面
#import "SelectView.h"

@implementation SelectView
{
    UIButton *_button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype) initWithFrame:(CGRect)frame andButton:(UIButton *)btn{
    _button=btn;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self creatbtn];
    }
    return self;
    
}
-(void) creatbtn{
    char imgname = '\0';
    for (int i=0; i<4; i++) {
        switch (i) {
            case 0:
                imgname='a';
                break;
            case 1:
                imgname='b';
                break;
            case 2:
                imgname='c';
                break;
            case 3:
                imgname='d';
                break;
            default:
                break;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.frame.size.width/4*i+self.frame.size.width/4/2-30, self.frame.size.height-80, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%c.png",imgname]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    }];
}
-(void) click:(UIButton *)btn{
    [_button setImage:[btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{self.alpha=0;}];
}
@end
