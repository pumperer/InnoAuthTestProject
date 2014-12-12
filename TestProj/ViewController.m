//
//  ViewController.m
//  TestProj
//
//  Created by hsshin on 2014. 11. 11..
//  Copyright (c) 2014년 Innospark. All rights reserved.
//

#import "ViewController.h"
#import "InnoAuth.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isLogin = NO;
    self.buttonFriends.enabled = NO;
    // Do any additional setup after loading the view, typically from a nib.
    [[InnoAuth sharedInstance] socialAutoLogin:InnoAuthTypeFaceBook completeBlock:^(NSString *result) {
        if(result != nil) {
            [self onLogin];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAccounts
{
    [[InnoAuth sharedInstance] socialAccounts:InnoAuthTypeFaceBook completeBlock:^(NSString *result) {
        if(result != nil) {
            NSLog(@"Get Accounts OK!");
            NSData* data = [result dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            [self.labelHello setText:[NSString stringWithFormat:@"%@ : %@", [json objectForKey:@"id"], [json objectForKey:@"first_name"]]];
            
            [self.labelData setText:result];
        }
    }];
}

- (IBAction)onClickButton:(id)sender {
    if(isLogin) {
        [[InnoAuth sharedInstance] socialLogout:InnoAuthTypeFaceBook completeBlock:^(NSString* result) {
            if(result != nil) {
                [self onLogout];
            }
        }];
    } else {
        [[InnoAuth sharedInstance] socialLogin:InnoAuthTypeFaceBook completeBlock:^(NSString* result) {
            if(result != nil) {
                [self onLogin];
            }
        }];
    }
}

- (IBAction)onClickFriends:(id)sender {
//    [[InnoAuth sharedInstance] socialFriendsUseThisApp:InnoAuthTypeFaceBook completeBlock:^(NSString* result) {
//        if(result != nil) {
//            NSLog(@"Get Friends OK!");
//            [self.labelData setText:result];
//        }
//    }];
    [self shareWithLink:@"https://plus.google.com/u/0/+IlyaGrigorik/posts/ahSpGgohSDo"];
}

- (void)onLogin
{
    NSLog(@"Login OK!");
    [self.buttonProcess setTitle:@"Logout" forState:UIControlStateNormal];
    [self.buttonProcess setTitle:@"Logout" forState:UIControlStateSelected];
    [self.buttonProcess setTitle:@"Logout" forState:UIControlStateHighlighted];
    [self.buttonProcess setTitle:@"Logout" forState:UIControlStateDisabled];
    
    isLogin = YES;
    self.buttonFriends.enabled = YES;
    [self requestAccounts];
}

- (void)onLogout
{
    NSLog(@"Logout OK!");
    [self.buttonProcess setTitle:@"Login" forState:UIControlStateNormal];
    [self.buttonProcess setTitle:@"Login" forState:UIControlStateSelected];
    [self.buttonProcess setTitle:@"Login" forState:UIControlStateHighlighted];
    [self.buttonProcess setTitle:@"Login" forState:UIControlStateDisabled];
    
    [self.labelHello setText:@"Please Login!"];
    
    [self.labelData setText:@""];
    
    isLogin = NO;
    self.buttonFriends.enabled = NO;
}

- (void)shareWithLink:(NSString*)linkUrl
{
    [[InnoAuth sharedInstance] socialShare:InnoAuthTypeFaceBook link:linkUrl title:nil caption:nil desc:nil picture:nil completeBlock:^(NSString *result) {
        if (result != nil) {
            NSLog(@"Share result : %@", result);
        }
    }];
}

@end
