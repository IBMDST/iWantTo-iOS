//
//  HttpRequestTool.m
//  iWantTo
//
//  Created by Josh on 4/2/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "HttpRequestUtility.h"

@implementation HttpRequestUtility

+ (void)sendPostFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation, NSError *error)) onFailed
{
    GlobalVariableManager *varManager = [GlobalVariableManager sharedInstance];
    MKNetworkEngine *netEngine = [[MKNetworkEngine alloc] initWithHostName:varManager.baseURL portNumber:varManager.port apiPath:api customHeaderFields:nil];
    MKNetworkOperation *op = [netEngine operationWithPath:path params:params httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"response headers: %@", completedOperation.readonlyResponse.allHeaderFields);
        onSuccess(completedOperation);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"Server error: %@", [error localizedDescription]);
        onFailed(completedOperation, error);
    }];
    
    [netEngine enqueueOperation:op];
    
}
+ (void)sendGetFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation,  NSError *error)) onFailed{
    GlobalVariableManager *varManager = [GlobalVariableManager sharedInstance];
    MKNetworkEngine *netEngine = [[MKNetworkEngine alloc] initWithHostName:varManager.baseURL portNumber:varManager.port apiPath:api customHeaderFields:nil];
    MKNetworkOperation *op = [netEngine operationWithPath:path params:params httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"response: %@", completedOperation.responseJSON);
        onSuccess(completedOperation);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"Server error: %@", [error localizedDescription]);
        onFailed(completedOperation, error);
    }];
    
    [netEngine enqueueOperation:op];
}
+ (void)sendPutFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation, NSError *error)) onFailed
{
    GlobalVariableManager *varManager = [GlobalVariableManager sharedInstance];
    MKNetworkEngine *netEngine = [[MKNetworkEngine alloc] initWithHostName:varManager.baseURL portNumber:varManager.port apiPath:api customHeaderFields:nil];
    MKNetworkOperation *op = [netEngine operationWithPath:path params:params httpMethod:@"PUT"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //        NSLog(@"response headers: %@", completedOperation.readonlyResponse.allHeaderFields);
        onSuccess(completedOperation);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"Server error: %@", [error localizedDescription]);
        onFailed(completedOperation, error);
    }];
    
    [netEngine enqueueOperation:op];
}

+ (void)sendDeleteFromAPIPath:(NSString *)api withPath:(NSString *)path parameters:(NSDictionary *)params runOnSuccess:(void(^)(MKNetworkOperation *completedOperation)) onSuccess runOnFailed:(void(^)(MKNetworkOperation *completedOperation, NSError *error)) onFailed{
        GlobalVariableManager *varManager = [GlobalVariableManager sharedInstance];
        MKNetworkEngine *netEngine = [[MKNetworkEngine alloc] initWithHostName:varManager.baseURL portNumber:varManager.port apiPath:api customHeaderFields:nil];
        MKNetworkOperation *op = [netEngine operationWithPath:path params:params httpMethod:@"DELETE"];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSLog(@"response: %@", completedOperation.responseJSON);
            onSuccess(completedOperation);
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            DLog(@"Server error: %@", [error localizedDescription]);
            onFailed(completedOperation, error);
        }];
        
        [netEngine enqueueOperation:op];
}

@end
