//
//  NSDate+FLUnits.h
//  FLToolDemo
//
//  Created by 孔凡列 on 16/7/12.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FLUnits)
/**
 *  是否为今天
 */
- (BOOL)fl_isToday;
/**
 *  是否为昨天
 */
- (BOOL)fl_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)fl_isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)fl_dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)fl_detaWithNow;

@end

@interface NSDate (FLExtension)

/**
 * 返回刚刚/x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)fl_timeInfo;
+ (NSString *)fl_timeInfoWithDate:(NSDate *)date;
+ (NSString *)fl_timeInfoWithDateString:(NSString *)dateString;

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)fl_day;
- (NSUInteger)fl_month;
- (NSUInteger)fl_year;
- (NSUInteger)fl_hour;
- (NSUInteger)fl_minute;
- (NSUInteger)fl_second;
+ (NSUInteger)fl_day:(NSDate *)date;
+ (NSUInteger)fl_month:(NSDate *)date;
+ (NSUInteger)fl_year:(NSDate *)date;
+ (NSUInteger)fl_hour:(NSDate *)date;
+ (NSUInteger)fl_minute:(NSDate *)date;
+ (NSUInteger)fl_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)fl_daysInYear;
+ (NSUInteger)fl_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)fl_isLeapYear;
+ (BOOL)fl_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)fl_weekOfYear;
+ (NSUInteger)fl_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)fl_formatYMD;
+ (NSString *)fl_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)fl_weeksOfMonth;
+ (NSUInteger)fl_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)fl_begindayOfMonth;
+ (NSDate *)fl_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)fl_lastdayOfMonth;
+ (NSDate *)fl_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)fl_dateAfterDay:(NSUInteger)day;
+ (NSDate *)fl_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)fl_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)fl_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)fl_offsetYears:(int)numYears;
+ (NSDate *)fl_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)fl_offsetMonths:(int)numMonths;
+ (NSDate *)fl_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)fl_offsetDays:(int)numDays;
+ (NSDate *)fl_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)fl_offsetHours:(int)hours;
+ (NSDate *)fl_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)fl_daysAgo;
+ (NSUInteger)fl_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)fl_weekday;
+ (NSInteger)fl_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)fl_dayFromWeekday;
+ (NSString *)fl_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)fl_isSameDay:(NSDate *)anotherDate;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)fl_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)fl_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)fl_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)fl_stringWithFormat:(NSString *)format;
+ (NSDate *)fl_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)fl_daysInMonth:(NSUInteger)month;
+ (NSUInteger)fl_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)fl_daysInMonth;
+ (NSUInteger)fl_daysInMonth:(NSDate *)date;


/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)fl_ymdFormat;
- (NSString *)fl_hmsFormat;
- (NSString *)fl_ymdHmsFormat;
+ (NSString *)fl_ymdFormat;
+ (NSString *)fl_hmsFormat;
+ (NSString *)fl_ymdHmsFormat;

@end
