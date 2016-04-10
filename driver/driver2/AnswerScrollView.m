
//
//  AnswerScrollView.m
//  driver2
//
//  Created by 易飞 on 15/12/27.
//  Copyright © 2015年 易飞. All rights reserved.
//
//答题页面的布局和滚动实现
#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#import "QuestionCollectManager.h"

#define SIZE self.frame.size

@interface AnswerScrollView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{

}
@end
@implementation AnswerScrollView
{
    
    UITableView *_leftTableView;
    UITableView *_mainTableView;
    UITableView *_rightTableView;
}
//初始化滚动视图和答题列表
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    self=[super initWithFrame:frame];
    if (self) {
        _currentPage=0;
        _dataArray=[[NSArray alloc]initWithArray:array];
        _hadAnswerArray=[[NSMutableArray alloc]init];
        for (int i=0; i<_dataArray.count; i++) {
            [_hadAnswerArray addObject:@"0"];
        }
        _scrollView=[[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate=self;
        if (_dataArray.count>2) {
            _leftTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
            _mainTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
            _rightTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
            _leftTableView.dataSource=self;
            _mainTableView.dataSource=self;
            _rightTableView.dataSource=self;
            _leftTableView.delegate=self;
            _mainTableView.delegate=self;
            _rightTableView.delegate=self;
        }if (_dataArray.count==2) {
            _leftTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
            _rightTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
            _leftTableView.dataSource=self;
            _rightTableView.dataSource=self;
            _leftTableView.delegate=self;
            _rightTableView.delegate=self;
        }if (_dataArray.count==1) {
            _leftTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
            _leftTableView.dataSource=self;
            _leftTableView.delegate=self;
        }
        
        [self createView];
    }
    return self;
}
//实例化复用列表以及添加列表到滚动视图
-(void)createView{
    if(_dataArray.count>2){
        _leftTableView.frame=CGRectMake(0, 0, SIZE.width, SIZE.height);
        _mainTableView.frame=CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
        [_scrollView addSubview:_leftTableView];
        [_scrollView addSubview:_mainTableView];
        [_scrollView addSubview:_rightTableView];
    }else if(_dataArray.count==2){
        _leftTableView.frame=CGRectMake(0, 0, SIZE.width, SIZE.height);
//        _mainTableView.frame=CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
        [_scrollView addSubview:_leftTableView];
//        [_scrollView addSubview:_mainTableView];
        [_scrollView addSubview:_rightTableView];
    }else if(_dataArray.count==1){
        _leftTableView.frame=CGRectMake(0, 0, SIZE.width, SIZE.height);
//        _mainTableView.frame=CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
//        _rightTableView.frame=CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
        [_scrollView addSubview:_leftTableView];
//        [_scrollView addSubview:_mainTableView];
//        [_scrollView addSubview:_rightTableView];
    }
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.indicatorStyle=UIScrollViewIndicatorStyleBlack;
   if (_dataArray.count>1) {
        _scrollView.contentSize=CGSizeMake(self.frame.size.width*2, 0);
   }else{
       _scrollView.contentSize=CGSizeMake(self.frame.size.width, 0);
   }
    [self addSubview:_scrollView];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AnswerModel * model=[self getTheFitModel:tableView];
    CGFloat height;
    if ([model.mtype intValue]==1) {
        NSString *str=[[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont * font=[UIFont systemFontOfSize:16];
        height=[Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        NSString *str=model.mquestion;
        UIFont * font=[UIFont systemFontOfSize:16];
        height=[Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    if (height<=80) {
        return 80;
    }else{
        return height;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel * model=[self getTheFitModel:tableView];
    NSString * str=[NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont * font=[UIFont systemFontOfSize:16];
    return [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AnswerModel * model=[self getTheFitModel:tableView];
    CGFloat height;
    NSString *str;
    if ([model.mtype intValue]==1) {
        str=[[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont * font=[UIFont systemFontOfSize:16];
        height=[Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        str=model.mquestion;
        UIFont * font=[UIFont systemFontOfSize:16];
        height=[Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    lable.numberOfLines=0;
    lable.text=[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    lable.font=[UIFont systemFontOfSize:16];
    [view addSubview:lable];
    return view;
    }
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AnswerModel * model=[self getTheFitModel:tableView];
    CGFloat height;
    NSString *str;
    str=[NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont * font=[UIFont systemFontOfSize:16];
    height=[Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    lable.text=str;
    lable.textColor=[UIColor greenColor];
    lable.font=[UIFont systemFontOfSize:16];
    lable.numberOfLines=0;
    [view addSubview:lable];

    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue] != 0) {
        return view;
    }else{
        return nil;
    }
}
//获取当前页数
-(int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    if (tableView ==_leftTableView && page == 0) {
        return 1;
    } else if(tableView ==_leftTableView && page >0){
        return page;
    }else if(tableView ==_mainTableView && page == 0){
        return 2;
    }else if(tableView ==_mainTableView && page >0&& page<_dataArray.count-1){
        return page+1;
    }else if(tableView ==_mainTableView && page==_dataArray.count-1){
        return page;
    }else if(tableView ==_rightTableView && page <_dataArray.count-1){
        return page+2;
    }else if(tableView ==_rightTableView && page ==_dataArray.count-1){
        return page+1;
    }else{
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue] != 0) {
        return;
    }else{
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    //错误存档
    AnswerModel *model;
    model=[self getTheFitModel:tableView];
    if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
        [QuestionCollectManager addWrongQuestion:[model.mid intValue]];
        NSLog(@"%@",[QuestionCollectManager getwrongQuestion]);
    }
    [self reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"AnswerTableViewCell";
    AnswerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.numberLable.layer.masksToBounds=YES;
        cell.numberLable.layer.cornerRadius=10;
       // cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
    cell.numberLable.text=[NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel *model;
    model=[self getTheFitModel:tableView];
    if([model.mtype intValue]==1){
            cell.answerLable.text=[[Tools getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
        }
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue] != 0) {
        //显示正确答案对号图标并且————判断选中项且错误的显示错号
        if ([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]){
            cell.numberImage.hidden=NO;
            cell.numberImage.image=[UIImage imageNamed:@"w.png"];
        }else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1] intValue]-1]]&&indexPath.row==[_hadAnswerArray[page-1] intValue]-1) {
            cell.numberImage.hidden=NO;
            cell.numberImage.image=[UIImage imageNamed:@"x.png"];
        }else{
            cell.numberImage.hidden=YES;
        }

    }else{
        cell.numberImage.hidden=YES;
    }
    return  cell;
}
-(AnswerModel *)getTheFitModel:(UITableView *)tableView{
    AnswerModel *model;
    if (_dataArray.count>2) {
        if (tableView ==_leftTableView && _currentPage == 0) {
            model=_dataArray[_currentPage];
        } else if(tableView ==_leftTableView && _currentPage >0){
            model=_dataArray[_currentPage-1];
        }else if(tableView ==_mainTableView && _currentPage == 0){
            model=_dataArray[_currentPage+1];
        }else if(tableView ==_mainTableView && _currentPage >0&& _currentPage<_dataArray.count-1){
            model=_dataArray[_currentPage];
        }else if(tableView ==_mainTableView && _currentPage==_dataArray.count-1){
            model=_dataArray[_currentPage-1];
        }else if(tableView ==_rightTableView && _currentPage <_dataArray.count-1){
            model=_dataArray[_currentPage+1];
        }else if(tableView ==_rightTableView && _currentPage ==_dataArray.count-1){
            model=_dataArray[_currentPage];
        }
    }
    if (_dataArray.count==2) {
        if (tableView ==_leftTableView && _currentPage == 0) {
            model=_dataArray[_currentPage];
        } else if(tableView ==_leftTableView && _currentPage >0){
            model=_dataArray[_currentPage-1];
        }else if(tableView ==_rightTableView && _currentPage <_dataArray.count-1){
            model=_dataArray[_currentPage+1];
        }else if(tableView ==_rightTableView && _currentPage ==_dataArray.count-1){
            model=_dataArray[_currentPage];
        }
    }
    if (_dataArray.count==1) {
        if (tableView ==_leftTableView && _currentPage == 0) {
            model=_dataArray[_currentPage];
        }
    }
    
    
    //给外部提供一个当前答案的接口
    _currentModel=model;
    
    return  model;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint   currentOffset=_scrollView.contentOffset;
    int page=currentOffset.x/SIZE.width;
    //page是从0开始的参数
    if (_dataArray.count>2) {   //数据在两个以上
        if (page<_dataArray.count-1 && page>0) {
            _scrollView.contentSize=CGSizeMake(currentOffset.x+SIZE.width*2, 0);
            _leftTableView.frame=CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
            _mainTableView.frame=CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
            _rightTableView.frame=CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
        }else if (page==_dataArray.count-1&&page>0){
            _scrollView.contentSize=CGSizeMake(currentOffset.x+SIZE.width, 0);
            _mainTableView.frame=CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
            _rightTableView.frame=CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        }
    }else if(_dataArray.count==2){  //数据等于两个
        _scrollView.contentSize=CGSizeMake(SIZE.width*2, 0);
        _leftTableView.frame=CGRectMake(currentOffset.x-(currentOffset.x!=0 ? SIZE.width:0), 0, SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
       
    }else if (_dataArray.count==1){ //数据等于一个
        _scrollView.contentSize=CGSizeMake(SIZE.width, 0);
        _leftTableView.frame=CGRectMake(0, 0, SIZE.width, SIZE.height);
    }
    _currentPage=page;
    [self reloadData];
}

-(void)reloadData{
    [_leftTableView reloadData];
    [_mainTableView reloadData];
    [_rightTableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
