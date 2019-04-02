//
//  UIWebView+MWCategory.m
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/11/10.
//  Copyright © 2017年 mwk All rights reserved.
//

#import "UIWebView+MWCategory.h"
#include <objc/runtime.h>

@implementation UIWebView (MWCategory)

+ (void)load{
    //  "v@:"
    Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");
    class_addMethod(class, @selector(setBeingRemoved), setBeingRemoved, "v@:");
    class_addMethod(class, @selector(willBeRemoved), willBeRemoved, "v@:");
    
    class_addMethod(class, @selector(removeFromSuperview), willBeRemoved, "v@:");
}

id setBeingRemoved(id self, SEL selector, ...)
{
    return nil;
}

id willBeRemoved(id self, SEL selector, ...)
{
    return nil;
}

@end
