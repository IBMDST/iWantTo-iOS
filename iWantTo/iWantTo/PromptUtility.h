//
//  PromptUtility.h
//  iWantTo
//
//  Created by Josh on 4/3/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PromptUtility : NSObject

+ (void)showPromptWithMessage:(NSString *)message;
+ (void)showServerErrorMessage;
+ (void)showHUDInController:(UIViewController *)controller;
+ (void)hideHUDInThreadWithController:(UIViewController *)controller;

+ (void)showLoadingHUDInController:(UIViewController *)controller;
+ (void)hideLoadingHUDInThreadWithController:(UIViewController *)controller;

@end
