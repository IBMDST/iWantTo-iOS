//
//  ViewController.m
//  iWantTo
//
//  Created by LiuChao on 3/18/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeTextInputting:(id)sender
{
    [_usernameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}

@end
