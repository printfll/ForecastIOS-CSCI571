//
//  UIViewController+AboutViewController.m
//  Forecast
//
//  Created by lu liu on 15/11/22.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize backBtn;

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)clickBack:(id)sender {
	[self dismissViewControllerAnimated:YES completion:^{}];
}
@end
