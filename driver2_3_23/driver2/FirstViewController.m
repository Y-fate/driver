//
//  FirstViewController.m
//  driver2
//
//  Created by 易飞 on 15/11/4.
//  Copyright © 2015年 易飞. All rights reserved.
//
//科目一理论考试界面
#import "FirstViewController.h"
#import"FirstTableViewCell.h"
#import"TestSelectViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
#import "MainTestViewController.h"
#import "AnswerModel.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataArray;
  
    
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=@[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout=UIRectEdgeNone;         //以导航栏下最左上边为原点
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTableview];
    [self creatView];  //创建界面下半部分视图
}
-(void) creatTableview{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview: _tableView];
}
-(void)creatView{
    
    //创建我的考试分析标签
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-140, 300, 30)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=@"................我的考试分析................";
    lable.font=[UIFont boldSystemFontOfSize:13];
    [self.view addSubview:lable];
    //创建四个分析按钮
    NSArray *_arr=@[@"我的错题",@"我的收藏",@"我的成绩",@"练习统计"];
    char imgname = '\0';
    for (int i=0; i<4; i++) {
        switch (i) {
                case 0:
                    imgname='l';
                    break;
                case 1:
                    imgname='m';
                    break;
                case 2:
                    imgname='n';
                    break;
                case 3:
                    imgname='o';
                    break;
                default:
                    break;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=201+i;
        [btn addTarget:self action:@selector(clickToolBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame=CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%c.png",imgname]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        //创建按钮下的四个文本
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-25, 60, 20)];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=_arr[i];
        lab.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lab];
        
    }
    
}

-(void)clickToolBtn:(UIButton *)btn{

    switch (btn.tag) {
        case 201:   //我的错题
        {
            
            AnswerViewController *_answerViewController=[[AnswerViewController alloc]init];
            _answerViewController.type=7;
            [self.navigationController pushViewController:_answerViewController animated:YES];
        
        }
            break;
        case 202:   //我的收藏
        {
            
            AnswerViewController *_answerViewController=[[AnswerViewController alloc]init];
            _answerViewController.type=8;
            [self.navigationController pushViewController:_answerViewController animated:YES];
        
        }
            break;
        case 203:   //我的成绩
        {
        
            
            
        }
            break;
    
    
            
        default:
            break;
    }
}


//当列表单元被选中时执行下面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://章节练习
        {
            TestSelectViewController *con=[[TestSelectViewController alloc]init];
            con.myTitle=@"章节练习";
            con.dataArray=[MyDataManager getData:chapter];
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            con.type=1;
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 1://顺序练习
        {
            AnswerViewController *_answerViewController=[[AnswerViewController alloc]init];
            _answerViewController.type=2;
            [self.navigationController pushViewController:_answerViewController animated:YES];
        }
            break;
        case 2://随机练习
        {
            AnswerViewController *_answerViewController=[[AnswerViewController alloc]init];
            _answerViewController.type=3;
            [self.navigationController pushViewController:_answerViewController animated:YES];
        }
            break;
        case 3://专项练习
        {
            TestSelectViewController *con=[[TestSelectViewController alloc]init];
            con.myTitle=@"专项练习";
            con.dataArray=[MyDataManager getData:subChapter];
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            con.type=2;
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 4://模拟仿真考试
        {
            MainTestViewController *con=[[MainTestViewController alloc]init];
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;                                       //返回一个分区
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"FirstTableViewCell";
    char imgname='\0';
    switch (indexPath.row) {
        case 0:
            imgname='g';
            break;
        case 1:
            imgname='h';
            break;
        case 2:
            imgname='i';
            break;
        case 3:
            imgname='j';
            break;
        case 4:
            imgname='k';
            break;
            
        default:
            break;
    }
   
    FirstTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    cell.myImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%c.png",imgname]];
    cell.myLable.text=_dataArray[indexPath.row];
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
