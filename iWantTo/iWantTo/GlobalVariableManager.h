//
//  GlobalVariableManager.h
//  iWantTo
//
//  Created by Josh on 4/2/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariableManager : NSObject

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, assign) int port;

+ (GlobalVariableManager *)sharedInstance;

@end
