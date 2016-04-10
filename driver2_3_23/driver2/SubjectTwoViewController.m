//
//  SubjectTwoViewController.m
//  driver2
//
//  Created by 易飞 on 16/3/12.
//  Copyright © 2016年 易飞. All rights reserved.
//

#import "SubjectTwoViewController.h"
#import "SubjectTwoTableViewCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@interface SubjectTwoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation SubjectTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableView    Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID=@"SubjectTwoTableViewCell";
    SubjectTwoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    cell.titleImageView.image=[UIImage imageNamed:@"shipin.png"];
    cell.theTitleLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //设置视频播放器
    NSString *path=[[NSBundle mainBundle]pathForResource:@"subject" ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:path];
    AVPlayerViewController *playerViewController=[[AVPlayerViewController alloc]init];
    playerViewController.player=[AVPlayer playerWithURL:url];
    [playerViewController.player play];
    
    [self presentViewController:playerViewController animated:YES completion:nil];
    
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
