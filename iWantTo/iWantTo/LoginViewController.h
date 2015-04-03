//
//  ViewController.h
//  iWantTo
//
//  Created by LiuChao on 3/18/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *usernameTF;
@property (nonatomic, strong) IBOutlet UITextField *passwordTF;

- (IBAction)completeTextInputting:(id)sender;
- (IBAction)signinButtonHander:(id)sender;

@end

