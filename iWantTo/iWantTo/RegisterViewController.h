//
//  RegisterViewController.h
//  iWantTo
//
//  Created by LiuChao on 3/18/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *usernameTF;
@property (nonatomic, strong) IBOutlet UITextField *passwordTF;
@property (nonatomic, strong) IBOutlet UITextField *retypeTF;
@property (nonatomic, strong) IBOutlet UITextField *emailTF;

- (IBAction)completeTextInputting:(id)sender;

@end
