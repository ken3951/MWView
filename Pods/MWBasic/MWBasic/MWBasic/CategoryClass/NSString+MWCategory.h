//
//  NSString+MWCategory.h
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/3/30.
//  Copyright © 2017年 mwk All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MWCategory)
- (CGSize)mw_sizeWithmaxSize:(CGSize)maxSize font:(UIFont*)font;
- (CGSize)mw_sizeWithmaxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode font:(UIFont*)font;
///Int型
- (BOOL)mw_isPureInt;
///float型
- (BOOL)mw_isPureFloat;
///获取中文大写数字
-(NSString *)mw_getCnMoney;
///转英文
- (NSString *)mw_toSpell;
///是纯英文
- (BOOL)mw_isPureEnglish;
///随机UUID
+ (NSString*)mw_createUUID;
@end
