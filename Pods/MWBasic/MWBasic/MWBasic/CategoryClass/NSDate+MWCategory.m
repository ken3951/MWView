//
//  NSDate+MWCategory.m
//  FunCity_Merchant
//
//  Created by mwk_pro on 2016/12/1.
//  Copyright © 2016年 mwk All rights reserved.
//

#import "NSDate+MWCategory.h"

@implementation NSDate (MWCategory)

- (NSInteger)mw_year
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    return component.year;
}

- (NSInteger)mw_month
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMonth
                                              fromDate:self];
    return component.month;
}

- (NSInteger)mw_day
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay
                                              fromDate:self];
    return component.day;
}

- (NSInteger)mw_weekday
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return component.weekday;
}

- (NSInteger)mw_weekOfYear
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return component.weekOfYear;
}

- (NSInteger)mw_hour
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitHour
                                              fromDate:self];
    return component.hour;
}

- (NSInteger)mw_minute
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMinute
                                              fromDate:self];
    return component.minute;
}

- (NSInteger)mw_second
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitSecond
                                              fromDate:self];
    return component.second;
}

- (NSInteger)mw_numberOfDaysInMonth
{
    NSCalendar *c = [NSCalendar mw_sharedCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:self];
    return days.length;
}

- (NSString *)mw_stringWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter mw_sharedDateFormatter];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

+ (instancetype)mw_dateFromString:(NSString *)string format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter mw_sharedDateFormatter];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}
+ (instancetype)mw_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *components = [NSDateComponents mw_sharedDateComponents];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [calendar dateFromComponents:components];
    components.year = NSIntegerMax;
    components.month = NSIntegerMax;
    components.day = NSIntegerMax;

    return date;
}
+ (instancetype)othermw_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSCalendar *calendar = [NSCalendar mw_sharedCalendar];
    NSDateComponents *components = [NSDateComponents mw_sharedDateComponents];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour =hour;
    components.minute =minute;
    components.second =second;
    NSDate *date = [calendar dateFromComponents:components];
    components.year = NSIntegerMax;
    components.month = NSIntegerMax;
    components.day = NSIntegerMax;
    components.hour = NSIntegerMax;
    components.minute = NSIntegerMax;
    components.second = NSIntegerMax;
    return date;
}

@end

@implementation NSCalendar (MWCategory)

+ (instancetype)mw_sharedCalendar
{
    static id instance;
    static dispatch_once_t mw_sharedCalendar_onceToken;
    dispatch_once(&mw_sharedCalendar_onceToken, ^{
        instance = [NSCalendar currentCalendar];
    });
    return instance;
}
@end

@implementation NSDateFormatter (MWExtension)

+ (instancetype)mw_sharedDateFormatter
{
    static id instance;
    static dispatch_once_t mw_sharedDateFormatter_onceToken;
    dispatch_once(&mw_sharedDateFormatter_onceToken, ^{
        instance = [[NSDateFormatter alloc] init];
    });
    return instance;
}
@end

@implementation NSDateComponents (MWCategory)

+ (instancetype)mw_sharedDateComponents
{
    static id instance;
    static dispatch_once_t mw_sharedDateFormatter_onceToken;
    dispatch_once(&mw_sharedDateFormatter_onceToken, ^{
        instance = [[NSDateComponents alloc] init];
    });
    return instance;
}

@end
