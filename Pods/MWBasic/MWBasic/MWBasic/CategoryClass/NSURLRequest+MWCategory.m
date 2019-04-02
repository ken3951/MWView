//
//  NSURLRequest+MWCategory.m
//  FanCityProject
//
//  Created by mwk_pro on 2017/4/19.
//  Copyright © 2017年 mwk All rights reserved.
//

#import "NSURLRequest+MWCategory.h"

@implementation NSURLRequest (MWCategory)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
