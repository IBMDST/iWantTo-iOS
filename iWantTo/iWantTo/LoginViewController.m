//
//  ViewController.m
//  iWantTo
//
//  Created by LiuChao on 3/18/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "LoginViewController.h"
#import "PromptUtility.h"
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
    
    [PromptUtility showHUDInController:self];

    [HttpRequestUtility sendPostFromAPIPath:@"users" withPath:@"/login" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *responseInfo = completedOperation.responseJSON;
        
        [GlobalVariableManager sharedInstance].userID = [responseInfo objectForKey:@"uid"];
        [GlobalVariableManager sharedInstance].sessionID = [responseInfo objectForKey:@"id"];
        [GlobalVariableManager sharedInstance].username = _usernameTF.text;
        
        [self performSegueWithIdentifier:@"speechListView" sender:self];
    }  runOnFailed: ^(MKNetworkOperation *completedOperation, NSError *error){
        [PromptUtility hideHUDInThreadWithController:self];
        
        NSInteger statusCode = completedOperation.readonlyResponse.statusCode;
        
        if (statusCode == 401) {
            [PromptUtility showPromptWithMessage:@"Invalid username or password!"];
        }
        else{
            [PromptUtility showServerErrorMessage];
        }
    }];
}

- (void)validateUser{
    
}

@end
