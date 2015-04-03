//
//  ViewController.m
//  iWantTo
//
//  Created by LiuChao on 3/18/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "LoginViewController.h"

#import "HttpRequestUtility.h"

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

- (IBAction)signinButtonHander:(id)sender
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    [params setObject:_usernameTF.text forKey:@"username"];
    [params setObject:_passwordTF.text forKey:@"password"];

    [HttpRequestUtility sendRequestFromAPIPath:@"users" withPath:@"/login" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
        NSLog(@"response headers: %@", completedOperation.readonlyResponse.allHeaderFields);
        
        [self performSegueWithIdentifier:@"speechListView" sender:self];
    }];
    
    //[self performSegueWithIdentifier:@"speechListView" sender:self];
}

@end
