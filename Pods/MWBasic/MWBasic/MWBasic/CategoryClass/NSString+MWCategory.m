//
//  NSString+MWCategory.m
//  ShopManagerProgect
//
//  Created by mwk_pro on 2017/3/30.
//  Copyright © 2017年 mwk All rights reserved.
//

#import "NSString+MWCategory.h"
@implementation NSString (MWCategory)


- (CGSize)mw_sizeWithmaxSize:(CGSize)maxSize font:(UIFont*)font{
    CGSize textSize;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [self boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
        textSize = [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return textSize;
}

- (CGSize)mw_sizeWithmaxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode font:(UIFont*)font{
    CGSize textSize;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:lineBreakMode];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [self boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
        textSize = [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
    }
    
    return textSize;
}

- (BOOL)mw_isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)mw_isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

///汉字转拼音
- (NSString *)mw_toSpell {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [[str uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return pinYin;
}

///是纯英文
- (BOOL)mw_isPureEnglish{
    NSString *string = self;
    NSInteger length=string.length;
    for (NSInteger i=0; i<length; i++) {
        NSString *subString=[string substringWithRange:NSMakeRange(i, 1)];
        char subChar=[subString characterAtIndex:0];
        if ((subChar>64&&subChar<91)||(subChar>96&&subChar<123)) {
            if (i==length-1) {
                return YES;
            }
        }else{
            return NO;
        }
    }
    return NO;
}

//随机UUID
+ (NSString*)mw_createUUID{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

///获取中文大写数字
-(NSString *)mw_getCnMoney{
    
    // 设置数据格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // NSLocale的意义是将货币信息、标点符号、书写顺序等进行包装，如果app仅用于中国区应用，为了保证当用户修改语言环境时app显示语言一致，则需要设置NSLocal（不常用）
    numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 全拼格式
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    // 小数点后最少位数
    [numberFormatter setMinimumFractionDigits:2];
    // 小数点后最多位数
    [numberFormatter setMaximumFractionDigits:6];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    //
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    //通过NSNumberFormatter转换为大写的数字格式 eg:一千二百三十四
    //替换大写数字转为金额
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"一" withString:@"壹"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"二" withString:@"贰"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"三" withString:@"叁"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"四" withString:@"肆"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"五" withString:@"伍"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"六" withString:@"陆"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"七" withString:@"柒"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"八" withString:@"捌"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"九" withString:@"玖"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"千" withString:@"仟"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"百" withString:@"佰"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"十" withString:@"拾"];
    // 对小数点后部分单独处理
    // rangeOfString 前面的参数是要被搜索的字符串，后面的是要搜索的字符
    if ([formattedNumberString rangeOfString:@"点"].length>0)
    {
        // 将“点”分割的字符串转换成数组，这个数组有两个元素，分别是小数点前和小数点后
        NSArray* arr = [formattedNumberString componentsSeparatedByString:@"点"];
        // 如果对一不可变对象复制，copy是指针复制（浅拷贝）和mutableCopy就是对象复制（深拷贝）。如果是对可变对象复制，都是深拷贝，但是copy返回的对象是不可变的。
        // 这里指的是深拷贝
        
        NSMutableString* lastStr = [[arr lastObject] mutableCopy];
        NSLog(@"---%@---长度%ld", lastStr, lastStr.length);
        if (lastStr.length>=2)
        {
            // 在最后加上“分”
            [lastStr insertString:@"分" atIndex:lastStr.length];
        }
        if (![[lastStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"零"])
            
        {
            // 在小数点后第一位后边加上“角”
            [lastStr insertString:@"角" atIndex:1];
        }
        // 在小数点左边加上“元”
        formattedNumberString = [[arr firstObject] stringByAppendingFormat:@"元%@",lastStr];
    }else{
        // 如果没有小数点
        formattedNumberString = [formattedNumberString stringByAppendingString:@"元整"];
    }
    return formattedNumberString;
}

@end
