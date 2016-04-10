
//
//  SelectModelView.m
//  driver2
//
//  Created by 易飞 on 16/2/17.
//  Copyright © 2016年 易飞. All rights reserved.
//

#import "SelectModelView.h"

@implementation SelectModelView
{
    SelectTouch block;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch{
    self=[super initWithFrame:frame];
    if (self) {
        [self createUI];
        block=touch;
        _model=testmodel;
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    NSArray *array=@[@"答题模式",@"背题模式"];
    for (int i=0; i<2; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2-200+i*130, 100, 100);
        btn.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=8;
        btn.tag=401+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        image.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d11q.png",i+1]];
        [btn addSubview:image];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 75, 80, 20)];
        label.text=array[i];
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:15];
        [btn addSubview:label];
        
        [self addSubview:btn];
        
    }
    
}

-(void)click:(UIButton *)btn{

    if (btn.tag==401) {
        _model=testmodel;
    }else{
        _model=lookingmodel;
    }
    block(_model);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    }];
    
}
@end
