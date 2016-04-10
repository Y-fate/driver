
//
//  SheetView.m
//  driver2
//
//  Created by 易飞 on 16/2/19.
//  Copyright © 2016年 易飞. All rights reserved.
//
//科目一答题页面抽屉视图

#import "SheetView.h"
@interface SheetView()
{
    UIView *_SuperView;
    UIScrollView *_scrollView;
    BOOL   _startMoving;
    CGFloat _width;  //抽屉宽度
    CGFloat _height; //抽屉高度
    CGFloat _y;      //抽屉原视图y坐标
    int _count;
}
@end

@implementation SheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)SuperView andQuesCount:(int)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _SuperView=SuperView;
        _startMoving=NO;
        _width=frame.size.width;
        _height=frame.size.height;
        _y=frame.origin.y;
        _count=count;
        [self creatView];
    }
    return self;
}

-(void)creatView{
    
    //创建背景视图
    _backView=[[UIView alloc]initWithFrame:_SuperView.frame];
    _backView.backgroundColor=[UIColor blackColor];
    _backView.alpha=0;
    [_SuperView addSubview:_backView];
    
    //创建上拉抽屉滚动视图
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height-70)];
    _scrollView.backgroundColor=[UIColor greenColor];
    [self addSubview:_scrollView];
    
    //创建所有抽屉内按钮
    for (int i=0; i<_count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake((_width-6*44)/2+44*(i%6), 10+44*(i/6), 40, 40);
        btn.backgroundColor=[UIColor colorWithRed:220/225.0 green:220/225.0 blue:220/225.0 alpha:1];
        if (i==0) {
            btn.backgroundColor=[UIColor orangeColor];
        }
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=8;
        [btn setTitle:[NSString stringWithFormat:@"%d",(i+1)] forState:UIControlStateNormal];
        btn.tag=101+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        
    }
    _scrollView.contentSize=CGSizeMake(0, 20+44*(_count/6+2));
    
}

-(void)click:(UIButton *)btn{
    int index=(int)btn.tag-100;
    for (int i=0; i<_count; i++) {
        UIButton *button=(UIButton *)[self viewWithTag:i+101];
        if ((index-1)!=i) {
            button.backgroundColor=[UIColor colorWithRed:220/225.0 green:220/225.0 blue:220/225.0 alpha:1];
        }else{
            button.backgroundColor=[UIColor orangeColor];
        }
        [_delegate sheetViewClick:index];
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    if (point.y<25) {
        _startMoving=YES;
    }
    if (_startMoving&&self.frame.origin.y>=_y-_height&&[self convertPoint:point toView:_SuperView].y>=80) {
        self.frame=CGRectMake(0, [self convertPoint:point toView:_SuperView].y, _width, _height);
    }
    float offset=(_SuperView.frame.size.height-self.frame.origin.y)/_SuperView.frame.size.height*0.8;
    _backView.alpha=offset;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (self.frame.origin.y>(_y-_height/2)){
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y, _width, _height);
            _backView.alpha=0;
        }];
        
    }else{

        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y-_height, _width, _height);
            _backView.alpha=0.8;
        }];

    }
    _startMoving=NO;
    
}

@end
