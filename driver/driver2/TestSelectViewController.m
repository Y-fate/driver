//
//  TestSelectViewController.m
//  driver2
//
//  Created by 易飞 on 15/12/12.
//  Copyright © 2015年 易飞. All rights reserved.
//
//第一章章节练习选择界面
#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"
#import "subTestSelectModel.h"


@interface TestSelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_myTitle;
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self creatTableview];
}
-(void)creatTableview{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _dataArray.count;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"TestSelectTableViewCell";
    TestSelectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil]lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.numberLable.layer.masksToBounds=YES;
        cell.numberLable.layer.cornerRadius=8;
    }
    if (_type==1){
        TestSelectModel *model=_dataArray[indexPath.row];
        cell.numberLable.text=model.pid;
        cell.titleLable.text=model.pname;
    }else if(_type==2){
        subTestSelectModel *model=_dataArray[indexPath.row];
        cell.numberLable.text=model.serial;
        cell.titleLable.text=model.sname;
        
    }
    
        
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController * answer=[[AnswerViewController alloc]init];
    
    if (_type==1) {
        answer.type=1;
        answer.number=(int)indexPath.row;
    }else{
        answer.type=4;
        subTestSelectModel *subModel=_dataArray[indexPath.row];
        answer.subStrNumber=subModel.sid;
        NSLog(@"/////////%@////",subModel.sid);
    }
    
    [self.navigationController pushViewController:answer animated:YES];
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
