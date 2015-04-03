//
//  HttpRequestTool.m
//  iWantTo
//
//  Created by Josh on 4/2/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "HttpRequestUtility.h"

@implementation HttpRequestUtility

+ (void)sendRequestFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess
{
    GlobalVariableManager *varManager = [GlobalVariableManager sharedInstance];
    MKNetworkEngine *netEngine = [[MKNetworkEngine alloc] initWithHostName:varManager.baseURL portNumber:varManager.port apiPath:api customHeaderFields:nil];
    MKNetworkOperation *op = [netEngine operationWithPath:path params:params httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"response headers: %@", completedOperation.readonlyResponse.allHeaderFields);
        onSuccess(completedOperation);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"Server error: %@", [error localizedDescription]);
    }];
    
    [netEngine enqueueOperation:op];
    
}

@end
