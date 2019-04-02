//
//  NSDate+MWCategory.h
//  FunCity_Merchant
//
//  Created by mwk_pro on 2016/12/1.
//  Copyright © 2016年 mwk All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MWCategory)

@property (readonly, nonatomic) NSInteger mw_year;
@property (readonly, nonatomic) NSInteger mw_month;
@property (readonly, nonatomic) NSInteger mw_day;
@property (readonly, nonatomic) NSInteger mw_weekday;
@property (readonly, nonatomic) NSInteger mw_weekOfYear;
@property (readonly, nonatomic) NSInteger mw_hour;
@property (readonly, nonatomic) NSInteger mw_minute;
@property (readonly, nonatomic) NSInteger mw_second;

@property (readonly, nonatomic) NSInteger mw_numberOfDaysInMonth;

- (NSString *)mw_stringWithFormat:(NSString *)format;
+ (instancetype)mw_dateFromString:(NSString *)string format:(NSString *)format;
+ (instancetype)othermw_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (instancetype)mw_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end


@interface NSCalendar (MWCategory)

+ (instancetype)mw_sharedCalendar;

@end

@interface NSDateFormatter (MWExtension)

+ (instancetype)mw_sharedDateFormatter;

@end

@interface NSDateComponents (MWCategory)

+ (instancetype)mw_sharedDateComponents;

@end
