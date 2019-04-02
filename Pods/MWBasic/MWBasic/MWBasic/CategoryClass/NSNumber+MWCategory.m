//
//  NSNumber+MWCategory.m
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/8/31.
//  Copyright © 2017年 mwk All rights reserved.
//

#import "NSNumber+MWCategory.h"

@implementation NSNumber (MWCategory)
- (NSUInteger)length{
    NSString *str=[NSString stringWithFormat:@"%@",self];
    return [str length];
}
@end
