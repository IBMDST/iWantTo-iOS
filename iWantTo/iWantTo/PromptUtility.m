//
//  PromptUtility.m
//  iWantTo
//
//  Created by Josh on 4/3/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "PromptUtility.h"
#import "MBProgressHUD.h"

@implementation PromptUtility


+ (void)showPromptWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iWantTo" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (void)showServerErrorMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iWantTo" message:@"Could not connect to server, please try later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (void)showHUDInController:(UIViewController *)controller
{
    [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
}

+ (void)hideHUDInThreadWithController:(UIViewController *)controller{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:controller.view animated:YES];
        });
    });
}

+ (void)showLoadingHUDInController:(UIViewController *)controller;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];

    hud.labelText = @"Loading";
}

+ (void)hideLoadingHUDInThreadWithController:(UIViewController *)controller{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:controller.view animated:YES];
        });
    });
    
}
@end
