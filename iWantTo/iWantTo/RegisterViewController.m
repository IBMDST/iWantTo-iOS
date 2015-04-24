//
//  RegisterViewController.m
//  iWantTo
//
//  Created by LiuChao on 3/18/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "RegisterViewController.h"
#import "HttpRequestUtility.h"
#import "PromptUtility.h"
#import "GlobalVariableManager.h"
#import "DatetimeUtility.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)completeTextInputting:(id)sender
{
    [_usernameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_retypeTF resignFirstResponder];
    [_emailTF resignFirstResponder];
    
    if (_usernameTF.text.length <= 3) {
        [PromptUtility showPromptWithMessage:@"The username you input must longer than 3 characters."];
    }
    else if(![_passwordTF.text isEqualToString:_retypeTF.text])
    {
        [PromptUtility showPromptWithMessage:@"The password you input is not matched."];
    }
    else
    {
        
        [PromptUtility showHUDInController:self];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        [params setObject:_usernameTF.text forKey:@"username"];
        [params setObject:_passwordTF.text forKey:@"password"];
        [params setObject:[DatetimeUtility currentTimestampStringSince1970] forKey:@"createdOn"];
        [params setObject:_emailTF.text forKey:@"email"];
        
        [HttpRequestUtility sendPostFromAPIPath:@"users" withPath:@"" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
            [PromptUtility hideHUDInThreadWithController:self];
            NSDictionary *responseInfo = completedOperation.responseJSON;
            NSLog(@"response info:%@",responseInfo);
            [GlobalVariableManager sharedInstance].userID = [responseInfo objectForKey:@"uid"];
            [GlobalVariableManager sharedInstance].sessionID = [responseInfo objectForKey:@"id"];
            [GlobalVariableManager sharedInstance].username = _usernameTF.text;
            
            [self performSegueWithIdentifier:@"speechListView" sender:self];
            
            
        } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
            [PromptUtility hideHUDInThreadWithController:self];
            [PromptUtility showPromptWithMessage:completedOperation.responseString];
        }];
    }
    
}

@end
