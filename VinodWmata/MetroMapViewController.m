//
//  MetroMapViewController.m
//  VinodWmata
//
//  Created by vinod kumar lingamsetty on 6/2/16.
//  Copyright © 2016 vinod kumar lingamsetty. All rights reserved.
//

#import "MetroMapViewController.h"

@interface MetroMapViewController ()

@end

@implementation MetroMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     
    
    NSLog(@"Hello");
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wmataMap" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    webView.scalesPageToFit = YES;
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    
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
