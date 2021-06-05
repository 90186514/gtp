//
//  NSString+YBCodec.m
//  YBArchitectureDemo
//
//  Created by 杨波 on 2018/11/20.
//  Copyright © 2018 杨波. All rights reserved.
//

#import "NSString+Extras.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extras)
+ (NSString *)getSumStringByArray:(NSArray *)array
//[string or num]
{
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
//    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
//    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
//    NSLog(@"%fn%fn%fn%f",sum,avg,max,min);
    return [NSString stringWithFormat:@"%.2f",sum];
}
+ (NSNumber *)getNormalSumNumberByArray:(NSArray *)array
//[string or num]
{
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
//    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
//    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
//    NSLog(@"%fn%fn%fn%f",sum,avg,max,min);
    return @([[NSString stringWithFormat:@"%.2f",sum] floatValue]);
}

+ (NSNumber *)getPropertTotalNumberByArray:(NSArray *)array
//[string or num]
{
    CGFloat sum = [[array valueForKeyPath:@"@sum.kTotal"] floatValue];
//    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
//    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
//    NSLog(@"%fn%fn%fn%f",sum,avg,max,min);
    return @([[NSString stringWithFormat:@"%.2f",sum] floatValue]);
}

+ (NSNumber *)getPropertAmountNumberByArray:(NSArray *)array
//[string or num]
{
    CGFloat sum = [[array valueForKeyPath:@"@sum.kAmount"] floatValue];
//    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
//    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
//    NSLog(@"%fn%fn%fn%f",sum,avg,max,min);
    return @([[NSString stringWithFormat:@"%.2f",sum] floatValue]);
}

- (NSString *)yb_encodingUTF8 {
    NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self, NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    return result;
}

- (NSString *)yb_MD5 {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    
    NSString *finalStr = [ret lowercaseString];
    return finalStr;
}

- (BOOL)match:(NSString *)express {
    return [self isMatchedByRegex:express];
}

+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}
+(BOOL)isEmpty:(NSString *)text
{
    if ([[NSString isValueNSStringWith:text] isEqualToString:@""] ||
        [NSString isValueNSStringWith:text] == nil)
    {
        return true;
    }
    return false;
}

+(id)isValueNSStringWith:(NSString *)str{
    NSString *resultStr = nil;
    str =[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isEqual:[NSNull null]]
        ||[NSString stringWithFormat:@"%@",str]==nil
        ||[NSString stringWithFormat:@"%@",str].length==0
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"(null)"]
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"null"]
        ||[str stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0
        ) {
        resultStr = @"";
    }else{
        resultStr = [NSString stringWithFormat:@"%@",str];
    }
    return resultStr;
}
+(BOOL)getLNDataSuccessed:(NSDictionary *)dic
{
    if ([NSObject isNSDictionaryClass:dic]) {
        int successed = [dic intForKey:@"code"];
        if (successed == 1) {
            return YES;
        } else {
            return NO;
        }
    } else {
        //        (@"后台返回数据有错误：%s",dic.description.UTF8String);
        return NO;
    }
}
+(BOOL)getDataSuccessed:(NSDictionary *)dic
{
    if ([NSObject isNSDictionaryClass:dic]) {
        int successed = [dic intForKey:@"errcode"];
        if (successed == 1) {
            return YES;
        } else {
            return NO;
        }
    } else {
//        (@"后台返回数据有错误：%s",dic.description.UTF8String);
        return NO;
    }
}
+ (NSString *)transToHMSSeparatedByUnitFormatSecond:(NSInteger)second{
    NSString *time;
    if (second < 60) {
        time = [NSString stringWithFormat:@"%02ld秒",(long)second];
    }
    else {
        if (second < 3600) {
            time = [NSString stringWithFormat:@"%02ld分%02ld秒",second/60,second%60];
        }
        else {
            time = [NSString stringWithFormat:@"%02ld时%02ld分%02ld秒",second/3600,(second%3600)/60,(second%3600)%60];
        }
    }
    return time;
}

+ (NSString *)transToHMSSeparatedByColonFormatSecond:(NSInteger)second{
    NSString *time;
    if (second < 60) {
        time = [NSString stringWithFormat:@"00:00:%02ld",(long)second];
    }
    else {
        if (second < 3600) {
            time = [NSString stringWithFormat:@"00:%02ld:%02ld",second/60,second%60];
        }
        else {
            time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",second/3600,(second%3600)/60,(second%3600)%60];
        }
    }
    return time;
}

+ (NSString *)currentDateComparePastDate:(NSDate *)pDate{
    //NSTimeInterval
    NSInteger second = (NSInteger)[[NSDate date] timeIntervalSinceDate:pDate];
    
    NSString *time = [NSString transToHMSSeparatedByUnitFormatSecond:second];
    return time;
}

+ (NSString *)currentDateCompareFutureDate:(NSDate *)fDate{
    //NSTimeInterval
    NSInteger second = (NSInteger)[fDate timeIntervalSinceDate:[NSDate date]];
    
    NSString *time = [NSString transToHMSSeparatedByUnitFormatSecond:second];
    return time;
}


+ (NSString *)mdSeparatedByPointFormatString{
    return @"MM.dd";
}

+ (NSString *)mdSeparatedByHyphenFormatString{
    return @"MM-dd";
}

+ (NSString *)mdSeparatedBySlashFormatString{
     return @"MM/dd";
}

+ (NSString *)mdSeparatedByUnitFormatString{
    return @"MM月dd日";
}

+ (NSString *)ymSeparatedByPointFormatString{
    return @"yyyy.MM";
}

+ (NSString *)ymSeparatedByHyphenFormatString{
    return @"yyyy-MM";
}

+ (NSString *)ymSeparatedBySlashFormatString{
     return @"yyyy/MM";
}

+ (NSString *)ymSeparatedByUnitFormatString{
    return @"yyyy年MM月";
}

+ (NSString *)ymdSeparatedByPointFormatString{
    return @"yyyy.MM.dd";
}

+ (NSString *)ymdSeparatedByHyphenFormatString{
    return @"yyyy-MM-dd";
}

+ (NSString *)ymdSeparatedBySlashFormatString{
     return @"yyyy/MM/dd";
}

+ (NSString *)ymdSeparatedByUnitFormatString{
    return @"yyyy年MM月dd日";
}

+ (NSString *)currentDataStringWithFormatString:(NSString *)formatString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    
    NSString *retStr = [formatter stringFromDate:[NSDate date]];
    
    return retStr;
}

+ (NSString *)dataStringWithFormatString:(NSString *)formatString setDate:(NSDate *)setDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    
    NSString *retStr = [formatter stringFromDate:setDate];
    
    return retStr;
}

+ (NSString *)dateStrWithString:(NSString *)string formatString:(NSString *)formatString{
//    NSString *string0 = @"2016-7-16 ";
//
//    // 日期格式化类
//
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//
//    // 设置日期格式 为了转换成功
//
//    format.dateFormat = @"yyyy-MM-dd";
//
//    // NSString * -> NSDate *
//
//    NSDate *data = [format dateFromString:string0];
//
//    NSString *newString = [format stringFromDate:data];
    
//
    NSDateFormatter *format = [[NSDateFormatter alloc] init];

    format.dateFormat = formatString;


    NSDate *data = [format dateFromString:string];

    NSString *newString = [format stringFromDate:data];
    
    return newString;
}


#pragma mark -绘制AttributeString与NSTextAttachment不同大小颜色
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont
{
   NSMutableDictionary *txtDict = [NSMutableDictionary dictionary];
   NSMutableParagraphStyle *aParagraphStyle = [[NSMutableParagraphStyle alloc] init];
//       aParagraphStyle.lineSpacing = 10;// 字体的行间距
//       aParagraphStyle.firstLineHeadIndent = 30.0f;//首行缩进
   aParagraphStyle.paragraphSpacing = 5;
   aParagraphStyle.alignment = NSTextAlignmentCenter;
   [aParagraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
   [txtDict setObject:aParagraphStyle forKey:NSParagraphStyleAttributeName];
//     [attStr addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (a - b)) range:NSMakeRange(2, attStr.length - 2)]; //vertical
    
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [txtDict addEntriesFromDictionary:attributes];
    
    [attributedStr setAttributes:txtDict range:NSMakeRange(0,attributedStr.length)];
    
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];//)个
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:subString options:0 range:NSMakeRange(0, [subString length])];
    

    
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    
    [txtDict addEntriesFromDictionary:subAttributes];
    
    NSMutableAttributedString *subAttributedStr = [[NSMutableAttributedString alloc] initWithString:subString attributes:txtDict];
    
    for (int i = 0; i < ranges.count; i++) {
        [subAttributedStr setAttributes:@{NSForegroundColorAttributeName : numInSubColor,NSFontAttributeName:numInSubFont} range:ranges[i].range];
    }
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont paragraphStyle:(NSTextAlignment)alignment
{
    NSMutableDictionary *txtDict = [NSMutableDictionary dictionary];
   NSMutableParagraphStyle *aParagraphStyle = [[NSMutableParagraphStyle alloc] init];
//       aParagraphStyle.lineSpacing = 10;// 字体的行间距
//       aParagraphStyle.firstLineHeadIndent = 30.0f;//首行缩进
   aParagraphStyle.paragraphSpacing = .5;
   aParagraphStyle.alignment = alignment;
   [aParagraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
   [txtDict setObject:aParagraphStyle forKey:NSParagraphStyleAttributeName];
//     [attStr addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (a - b)) range:NSMakeRange(2, attStr.length - 2)]; //vertical
        
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [txtDict addEntriesFromDictionary:attributes];
    
    [attributedStr setAttributes:txtDict range:NSMakeRange(0,attributedStr.length)];
    
    
    NSMutableAttributedString *subAttributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", subString]];
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    [txtDict addEntriesFromDictionary:subAttributes];
    
    [subAttributedStr setAttributes:txtDict range:NSMakeRange(0,subAttributedStr.length)];
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont
{
    NSMutableDictionary *txtDict = [NSMutableDictionary dictionary];
   NSMutableParagraphStyle *aParagraphStyle = [[NSMutableParagraphStyle alloc] init];
//       aParagraphStyle.lineSpacing = 10;// 字体的行间距
//       aParagraphStyle.firstLineHeadIndent = 30.0f;//首行缩进
   aParagraphStyle.paragraphSpacing = 5;
   aParagraphStyle.alignment = NSTextAlignmentCenter;
   [aParagraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
   [txtDict setObject:aParagraphStyle forKey:NSParagraphStyleAttributeName];
//     [attStr addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (a - b)) range:NSMakeRange(2, attStr.length - 2)]; //vertical
        
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [txtDict addEntriesFromDictionary:attributes];
    
    [attributedStr setAttributes:txtDict range:NSMakeRange(0,attributedStr.length)];
    
    
    NSMutableAttributedString *subAttributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", subString]];
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
//    [txtDict addEntriesFromDictionary:subAttributes];
    
    [subAttributedStr setAttributes:subAttributes range:NSMakeRange(0,subAttributedStr.length)];
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image=image;
    attachment.bounds=CGRectMake(0,-8 , image.size.width, image.size.height);
    NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attachment];
    
    
    
    [attributedStr insertAttributedString:imageStr atIndex:0];
    
    
    return attributedStr;
}
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image isImgPositionOnlyLeft:(BOOL)isOnlyLeft
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@  ", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image=image;
    attachment.bounds=CGRectMake(0,-8 , image.size.width, image.size.height);
    NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attachment];
    
    NSTextAttachment *attachment0=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image0 = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];
    attachment0.image=isOnlyLeft?image:image0;
    attachment0.bounds=CGRectMake(0,isOnlyLeft?-2:3, image.size.width, image.size.height);
    NSAttributedString *imageStr0=[NSAttributedString attributedStringWithAttachment:attachment0];
    
    [attributedStr insertAttributedString:imageStr0 atIndex:0];
    
    if(!isOnlyLeft)[attributedStr insertAttributedString:imageStr atIndex:attributedStr.length];
    
    return attributedStr;
}
#pragma mark -限宽计算AttributeString与String的高度
+ (CGFloat)getAttributeContentHeightWithAttributeString:(NSAttributedString*)atributedString withFontSize:(float)fontSize boundingRectWithWidth:(CGFloat)width{
    float height = 0;
    CGSize lableSize = CGSizeZero;
//    if(IS_IOS7)
    if ([atributedString respondsToSelector:@selector(boundingRectWithSize:options:context:)]){
        CGSize sizeTemp = [atributedString boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           
                                                        context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    height = lableSize.height;
    return height;
}

+ (CGFloat)getContentHeightWithParagraphStyleLineSpacing:(CGFloat)lineSpacing fontWithString:(NSString*)fontWithString fontOfSize:(CGFloat)fontOfSize boundingRectWithWidth:(CGFloat)width {
    float height = 0;
    CGSize lableSize = CGSizeZero;
//    if(IS_IOS7)
    if([fontWithString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = lineSpacing;
        CGSize sizeTemp = [fontWithString boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                                       options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes: @{NSFontAttributeName:
                                                                      [UIFont systemFontOfSize:fontOfSize],
                                                                  NSParagraphStyleAttributeName:
                                                                      paragraphStyle}
                                                       context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    
    height = lableSize.height;
    return height;
}

#pragma mark -限高计算AttributeString与String的宽度
+(CGFloat)getTextWidth:(NSString *)string withFontSize:(UIFont *)font withHeight:(CGFloat)height
{
    float width = 0;
    CGSize lableSize = CGSizeZero;
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
        CGSize sizeTemp = [string boundingRectWithSize: CGSizeMake(MAXFLOAT, height)
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes: stringAttributes
                                               context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    width = lableSize.width;
    return width;
}

#pragma mark -限宽计算AttributeString与String的宽度
+(CGFloat)calculateTextWidth:(NSString *)string withFontSize:(float)fontSize withWidth:(float)width
{
    float resultWidth = 0;
    CGSize lableSize = CGSizeZero;
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey: NSFontAttributeName];
        CGSize sizeTemp = [string boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes: stringAttributes
                                               context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    resultWidth = lableSize.width;
    return resultWidth;
}

+(CGFloat)calculateAttributeTextWidth:(NSAttributedString *)atributedString withFontSize:(float)fontSize withWidth:(float)width
{
    float resultWidth = 0;
    CGSize lableSize = CGSizeZero;
    if([atributedString respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        
        //        [atributedString setAttributes:@{ NSFontAttributeName:kFontSize(fontSize)} range:NSMakeRange(0,atributedString.length)];
        
        CGSize sizeTemp = [atributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        context:nil].size;
        
        
        
        //                           boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
        //                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        //                                            attributes: stringAttributes
        //                                               context: nil].size;//string
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    resultWidth = lableSize.width;
    return resultWidth;
}
// 字典转json字符串方法//==[dic mj_JSONString]
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
