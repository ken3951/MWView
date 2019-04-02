#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSDate+MWCategory.h"
#import "NSNumber+MWCategory.h"
#import "NSString+MWCategory.h"
#import "NSURLRequest+MWCategory.h"
#import "UIControl+MWCategory.h"
#import "UIImage+BlurGlass.h"
#import "UIImage+MWCategory.h"
#import "UIWebView+MWCategory.h"
#import "MWBasic-Bridging-Header.h"

FOUNDATION_EXPORT double MWBasicVersionNumber;
FOUNDATION_EXPORT const unsigned char MWBasicVersionString[];

