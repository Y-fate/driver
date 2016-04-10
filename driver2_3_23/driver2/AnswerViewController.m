
//
//  AnswerViewController.m
//  driver2
//
//  Created by 易飞 on 15/12/27.
//  Copyright © 2015年 易飞. All rights reserved.
//
//答题视图控制器
#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
#import "QuestionCollectManager.h"

@interface AnswerViewController ()<sheetViewDelegate>
{
    AnswerScrollView *_answerScrollView;
    SelectModelView *modelView;
    SheetView *_sheetView;
    NSTimer *_timer;
    UILabel *_timerLabel;    //答题页顶部模拟考试时间
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatModelView];
    [self creatData];
    [self.view addSubview:_answerScrollView];
    [self creatSheetView];
}

//创建数据
-(void)creatData{

    if (_type==1) {
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        NSArray * arr=[MyDataManager getData:answer];
        for (int i=0; i<arr.count-1; i++) {
            AnswerModel *model=arr[i];
            if ([model.pid intValue]==_number+1) {
                [array addObject:model];
            }
        }
        
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:array];
        
    }else if (_type==2){
    
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:[MyDataManager getData:answer]];
        
    }else if(_type==3){
    
        NSArray *arr=[MyDataManager getData:answer];
        NSMutableArray *temArray=[[NSMutableArray alloc]init];  //创建临时数组
        NSMutableArray *array=[[NSMutableArray alloc]init];
        [temArray addObjectsFromArray:arr];
        for (int i=0; i<temArray.count; ) {
            int index;
            index=arc4random()%(temArray.count);
            [array addObject:temArray[index]];
            [temArray removeObject:temArray[index]];
            
        }
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:array];
    }else if (_type==4) {
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        NSArray * arr=[MyDataManager getData:answer];
        for (int i=0; i<arr.count-1; i++) {
            AnswerModel *model=arr[i];
            if ([model.sid  isEqualToString:_subStrNumber]) {
                [array addObject:model];
            }
            
        }
        
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:array];
        
    }else if (_type==5){
    
        NSArray *arr=[MyDataManager getData:answer];
        NSMutableArray *temArray=[[NSMutableArray alloc]init];  //创建临时数组
        NSMutableArray *array=[[NSMutableArray alloc]init];
        [temArray addObjectsFromArray:arr];
        for (int i=0; i<100;i++ ) {
            int index;
            index=arc4random()%(temArray.count);
            [array addObject:temArray[index]];
            [temArray removeObject:temArray[index]];
        }
        
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:array];
        
        [self creatNavBtn];
    
    }
    
    //我的错题
    if (_type==7) {
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        NSArray * arr=[MyDataManager getData:answer];
        NSArray *wrongArray=[QuestionCollectManager getwrongQuestion];
        for (NSString *num in wrongArray) {
            for (AnswerModel *model in arr) {
             
                if ([model.mid isEqualToString:num]){
                    [array addObject:model];
                }
                
            }
        }
        
        
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:array];
        
    }
    
    
    //我的收藏
    if (_type==8) {
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        NSArray * arr=[MyDataManager getData:answer];
        NSArray *collectArray=[QuestionCollectManager getCollectQuestion];
        for (NSString *num in collectArray) {
            for (AnswerModel *model in arr) {
                
                if ([model.mid isEqualToString:num]){
                    [array addObject:model];
                }
                
            }
        }
        
        
        _answerScrollView=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:array];
        
    }

    
    
    if (_type!=5&&_type!=6){
        
        [self creatToolBar];
        
    }else{
    
        [self creatTestToolBar];
        //设置定时器
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
        _timerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
        _timerLabel.text=@"60:00";
        _timerLabel.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView=_timerLabel;
        
        
    }
   
}


-(void)runTime{

    static int Time=3600;
    Time--;
    _timerLabel.text=[NSString stringWithFormat:@"%d:%d",Time/60,Time%60];

}


-(void)creatNavBtn{

    UIBarButtonItem *itemLeft=[[UIBarButtonItem alloc]init];
    itemLeft.title=@"返回";
    [itemLeft setTarget:self];
    [itemLeft setAction:@selector(clickNavBtnReturn)];
    self.navigationItem.leftBarButtonItem=itemLeft;
    
    UIBarButtonItem *itemRight=[[UIBarButtonItem alloc]init];
    itemRight.title=@"交卷";
    [itemRight setTarget:self];
    [itemRight setAction:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem=itemRight;
    
}
-(void)clickRightItem{

    //创建一个提示框
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"时间还多确定要离开吗？"preferredStyle:UIAlertControllerStyleAlert];
    //上面preferredStyle还可以写成UIAlertControllerStyleActionSheet选择这个枚举类型后发现这个提示框从底部弹出
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"不，谢谢！" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"我要交卷" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    //做交卷处理
        NSArray *answerArray=_answerScrollView.dataArray;
        NSArray *myAnswerArray=_answerScrollView.hadAnswerArray;
        
        int score=0;
        for (int i=0; i<myAnswerArray.count; i++) {
#warning 做题目类型判断
            
            AnswerModel *model=answerArray[i];
            NSString *answerStr=model.manswer;
            NSString *myAnswerStr=[NSString stringWithFormat:@"%c",'A'-1+[myAnswerArray[i] intValue]];
            
            if ([answerStr isEqualToString:myAnswerStr]) {
                score++;
            }
            [QuestionCollectManager setScore:score];
            NSLog(@"成就：%d",[QuestionCollectManager getScore]);
            
        }
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];

}


-(void)clickNavBtnReturn{
    
    //创建一个提示框
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"时间还多确定要离开吗？"preferredStyle:UIAlertControllerStyleAlert];
                            //上面preferredStyle还可以写成UIAlertControllerStyleActionSheet选择这个枚举类型后发现这个提示框从底部弹出
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"不，谢谢！" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"我要离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
     

//创建抽屉视图
-(void)creatSheetView{

    _sheetView=[[SheetView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) withSuperView:self.view andQuesCount:(int)(_answerScrollView.dataArray.count)];
    _sheetView.delegate=self;
    [self.view addSubview:_sheetView];
    
}
#pragma mark - delegate
-(void)sheetViewClick:(int)index{
    
    UIScrollView *scrollView=_answerScrollView->_scrollView;
    scrollView.contentOffset=CGPointMake((index-1)*scrollView.frame.size.width, 0);
    [scrollView.delegate  scrollViewDidEndDecelerating:scrollView];
    
}
//创建选择模式
-(void)creatModelView{

    modelView=[[SelectModelView alloc]initWithFrame:self.view.frame addTouch:^(SelectModel model){
    
        NSLog(@"当前模式是：%d",model);
    
    }];
    [self.view addSubview:modelView];
    modelView.alpha=0;
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem=item;
}

-(void)modelChange:(UIBarButtonItem *)item{
    [UIView animateWithDuration:0.3 animations:^{
        modelView.alpha=1;
    }];
}

//创建模拟考试的答题视图下的工具栏
-(void)creatTestToolBar{
    
    NSArray *arr=@[[NSString stringWithFormat:@"%ld",_answerScrollView.dataArray.count],@"收藏本题"];
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64-60, self.view.frame.size.width, 60)];
    barView.backgroundColor=[UIColor whiteColor];
    char imgname = '\0';
    char imgname1 = '\0';
    for (int i=0; i<2; i++) {
        switch (i) {
            case 0:
                imgname='r';
                imgname1='q';
                break;
            case 1:
                imgname='v';
                imgname1='u';
                break;
            default:
                break;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/2*i+self.view.frame.size.width/2/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%c",imgname]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%c",imgname1]] forState:UIControlStateHighlighted];
        btn.tag=301+i;
        [btn addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.backgroundColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14];
        label.text=arr[i];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];


}
//创建答题视图下的工具栏
-(void)creatToolBar{
    NSArray *arr=@[[NSString stringWithFormat:@"%ld",_answerScrollView.dataArray.count],@"查看答案",@"收藏本题"];
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64-60, self.view.frame.size.width, 60)];
    barView.backgroundColor=[UIColor whiteColor];
    char imgname = '\0';
    char imgname1 = '\0';
    for (int i=0; i<3; i++) {
        switch (i) {
                case 0:
                    imgname='r';
                    imgname1='q';
                    break;
                case 1:
                    imgname='t';
                    imgname1='s';
                    break;
                case 2:
                    imgname='v';
                    imgname1='u';
                    break;
                default:
                    break;
            }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%c",imgname]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%c",imgname1]] forState:UIControlStateHighlighted];
        btn.tag=301+i;
        [btn addTarget:self action:@selector(clickToolBarBtn:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.backgroundColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14];
        label.text=arr[i];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
}
-(void)clickToolBarBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 301:   //抽屉视图
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame=CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView->_backView.alpha=0.8;
            }];
            
        }
            break;
            
        case 302:   //查看答案
        {
            
            if (_type!=5&&_type!=6) {
                
                if ([_answerScrollView.hadAnswerArray[_answerScrollView.currentPage] intValue]!= 0) {
                    return;
                } else {
                    AnswerModel *model=[_answerScrollView.dataArray objectAtIndex:_answerScrollView.currentPage];
                    NSString *answer=model.manswer;
                    char an=[answer characterAtIndex:0];
                    [_answerScrollView.hadAnswerArray replaceObjectAtIndex:_answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
                    [_answerScrollView reloadData];
                }

            }else{
            
                //收藏代码
                [QuestionCollectManager addCollectQuestion:[_answerScrollView.currentModel.mid intValue]];
                NSLog(@"%@",[QuestionCollectManager getCollectQuestion]);
            }
            
        }
            break;
        case 303:   //收藏
        {
            AnswerModel *model=_answerScrollView.dataArray[_answerScrollView.currentPage];
            [QuestionCollectManager addCollectQuestion:[model.mid intValue]];
            NSLog(@"%@",[QuestionCollectManager getCollectQuestion]);
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new answerScrollView controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
