//
//  ItemViewController.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/11/24.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "ItemViewController.h"
#import "PocketAPI.h"

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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                               target:self
                                                                               action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
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

- (void)save:(id)sender{
 
    NSURL *url = [NSURL URLWithString:_urlString];
    [[PocketAPI sharedAPI] saveURL:url handler: ^(PocketAPI *API, NSURL *URL,NSError *error){
        if(error){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Pocket" message:error.localizedDescription delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Pocket" message:@"Page Saved." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
