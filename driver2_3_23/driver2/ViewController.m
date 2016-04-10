//
//  ViewController.m
//  driver2
//
//  Created by 易飞 on 15/10/23.
//  Copyright © 2015年 易飞. All rights reserved.
//
//首页界面

#import "ViewController.h"
#import"SelectView.h"
#import"FirstViewController.h"
#import "SubjectTwoViewController.h"
#import "WebViewController.h"
@interface ViewController ()
{
    SelectView *_selectView;
    __weak IBOutlet UIButton *selectbtn;
}
@end

@implementation ViewController

- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.3 animations:^{_selectView.alpha=1;}];
        }
            break;
        case 101: //科目一
        {
            //跳转到FistViewController
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController  pushViewController:[[FirstViewController alloc] init] animated:YES];
        }
    
            break;
        case 102://科目二
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController  pushViewController:[[SubjectTwoViewController alloc] init] animated:YES];
        }
            break;
        case 103:
        {
        
        }
            break;
        case 104:
        {
        
        }
            break;
        case 105:
        {
            
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController  pushViewController:[[WebViewController alloc] initWithUrl:@"http://m.jxedt.com/mnks/"] animated:YES];
            
        }
            break;
        case 106:
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController  pushViewController:[[WebViewController alloc] initWithUrl:@"http://m.jxedt.com/mnks/"] animated:YES];
            
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectView= [[SelectView alloc] initWithFrame:self.view.frame andButton:selectbtn];
    _selectView.alpha=0;
    [self.view addSubview:_selectView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
