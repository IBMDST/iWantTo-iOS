//
//  HttpRequestTool.h
//  iWantTo
//
//  Created by Josh on 4/2/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "GlobalVariableManager.h"

@interface HttpRequestUtility : NSObject

+ (void)sendPostFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation, NSError *error)) onFailed;
+ (void)sendGetFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation, NSError *error)) onFailed;
+ (void)sendPutFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation, NSError *error)) onFailed;
@end
