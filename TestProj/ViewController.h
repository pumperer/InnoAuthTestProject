//
//  ViewController.h
//  TestProj
//
//  Created by hsshin on 2014. 11. 11..
//  Copyright (c) 2014년 Innospark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    BOOL isLogin;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonProcess;
@property (weak, nonatomic) IBOutlet UIButton *buttonFriends;
@property (weak, nonatomic) IBOutlet UILabel *labelHello;
@property (weak, nonatomic) IBOutlet UITextView *labelData;

- (IBAction)onClickButton:(id)sender;
- (IBAction)onClickFriends:(id)sender;

@end

