//
//  ItemViewController.m
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/24.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import "ItemViewController.h"

@interface ItemViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *itemWebViw;

@end

@implementation ItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_itemWebViw setDelegate:self];

    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_itemWebViw loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
