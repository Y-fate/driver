
//
//  WebViewController.m
//  driver2
//
//  Created by 易飞 on 16/3/13.
//  Copyright © 2016年 易飞. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIWebView *_webView;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(instancetype)initWithUrl:(NSString *)url
{

    self=[super init];
    if (self) {
        
       NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        _webView=[[UIWebView alloc]initWithFrame:self.view.frame];
        [_webView loadRequest:request];
//        [_webView loadHTMLString:@"<body>你好，世界！</body>" baseURL:nil];
        [self.view addSubview:_webView];
        
    }
    
    return self;
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
