//
//  NSString+YBCodec.h
//  YBArchitectureDemo
//
//  Created by 杨波 on 2018/11/20.
//  Copyright © 2018 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extras)
+ (NSString *)currentDataStringWithFormatString:(NSString *)format;
+ (NSString *)getSumStringByArray:(NSArray *)array;
+ (NSNumber *)getNormalSumNumberByArray:(NSArray *)array;
+ (NSNumber *)getPropertTotalNumberByArray:(NSArray *)array;
+ (NSNumber *)getPropertAmountNumberByArray:(NSArray *)array;
- (NSString *)yb_encodingUTF8;

- (NSString *)yb_MD5;

- (BOOL)match:(NSString *)express;

+ (BOOL)isPureInt:(NSString *)string;
+ (BOOL)isEmpty:(NSString *)text;
+ (id)isValueNSStringWith:(NSString *)str;
+ (BOOL)getDataSuccessed:(NSDictionary *)dic;
+(BOOL)getLNDataSuccessed:(NSDictionary *)dic;

+ (NSString *)transToHMSSeparatedByUnitFormatSecond:(NSInteger)second;
+ (NSString *)transToHMSSeparatedByColonFormatSecond:(NSInteger)second;


+ (NSString *)currentDateComparePastDate:(NSDate *)pDate;
+ (NSString *)currentDateCompareFutureDate:(NSDate *)fDate;

+ (NSString *)mdSeparatedByPointFormatString;
+ (NSString *)mdSeparatedByHyphenFormatString;
+ (NSString *)mdSeparatedBySlashFormatString;
+ (NSString *)mdSeparatedByUnitFormatString;

+ (NSString *)ymSeparatedByPointFormatString;
+ (NSString *)ymSeparatedByHyphenFormatString;
+ (NSString *)ymSeparatedBySlashFormatString;
+ (NSString *)ymSeparatedByUnitFormatString;

+ (NSString *)ymdSeparatedByPointFormatString;
+ (NSString *)ymdSeparatedByHyphenFormatString;
+ (NSString *)ymdSeparatedBySlashFormatString;
+ (NSString *)ymdSeparatedByUnitFormatString;

+ (NSString *)dateStrWithString:(NSString *)string formatString:(NSString *)formatString;

+ (NSString *)dataStringWithFormatString:(NSString *)formatString setDate:(NSDate *)setDate;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image isImgPositionOnlyLeft:(BOOL)isOnlyLeft;

+ (CGFloat)getAttributeContentHeightWithAttributeString:(NSAttributedString*)atributedString withFontSize:(float)fontSize boundingRectWithWidth:(CGFloat)width;
+ (CGFloat)getContentHeightWithParagraphStyleLineSpacing:(CGFloat)lineSpacing fontWithString:(NSString*)fontWithString fontOfSize:(CGFloat)fontOfSize boundingRectWithWidth:(CGFloat)width;

+(CGFloat)getTextWidth:(NSString *)string withFontSize:(UIFont *)font withHeight:(CGFloat)height;

+(CGFloat)calculateTextWidth:(NSString *)string withFontSize:(float)fontSize withWidth:(float)width;
+(CGFloat)calculateAttributeTextWidth:(NSAttributedString *)atributedString withFontSize:(float)fontSize withWidth:(float)width;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
