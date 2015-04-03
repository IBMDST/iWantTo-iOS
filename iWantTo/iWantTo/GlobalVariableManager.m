//
//  GlobalVariableManager.m
//  iWantTo
//
//  Created by Josh on 4/2/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "GlobalVariableManager.h"

@implementation GlobalVariableManager

+ (GlobalVariableManager *)sharedInstance {
    static GlobalVariableManager *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GlobalVariableManager alloc] init];
    });
    
    sharedInstance.baseURL = @"share.in-sync.co";
    sharedInstance.port = 2403;
    
    return sharedInstance;
}

@end
