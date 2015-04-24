//
//  DatetimeUtility.m
//  iWantTo
//
//  Created by Josh on 4/24/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "DatetimeUtility.h"

@implementation DatetimeUtility

+ (NSString *)currentTimestampStringSince1970
{
    return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
}

@end
