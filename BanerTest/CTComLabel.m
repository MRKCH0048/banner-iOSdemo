//
//  CTComLabel.m
//  BanerTest
//
//  Created by 亢春辉 on 15/12/25.
//  Copyright © 2015年 亢春辉. All rights reserved.
//

#import "CTComLabel.h"
#import <CoreText/CoreText.h>
@implementation CTComLabel


-(void)drawRect:(CGRect)rect
{
    if(!self.attributedString)return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.frame.size.height);
    CGContextConcatCTM(context, flipVertical);
    
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)self.attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, self.attributedString.length), path, NULL);
    CTFrameDraw(ctFrame, context);
    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    for (int i = 0; i < CFArrayGetCount(lines); i++)
    {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++)
        {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            NSString *imageName = [attributes objectForKey:@"imageName"];

            //图片渲染逻辑
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                UIFont *foun = [attributes objectForKey:NSFontAttributeName];
                UIFontDescriptor *dec = [foun fontDescriptor];
                NSLog(@"%@",NSStringFromCGRect(runRect));
                if (image) {
                    NSString *fontSzie = [dec.fontAttributes objectForKey:@"NSFontSizeAttribute"];
                    CGFloat tt = fontSzie.floatValue;
                    CGRect imageDrawRect;
                    imageDrawRect.size = CGSizeMake(tt, tt);
                    imageDrawRect.origin.x = runRect.origin.x+1;
                    imageDrawRect.origin.y = runRect.origin.y;
                    imageDrawRect.size.width = runRect.size.width-2;
                    imageDrawRect.size.height = runRect.size.height-2;
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }

        }
    }
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
}

+(CGSize)measureFrame:(CTFrameRef)frame forContext:(CGContextRef *)cgContext
{
    //frame为排版后的文本
    CGPathRef framePath   = CTFrameGetPath(frame);
    CGRect frameRect      = CGPathGetBoundingBox(framePath);
    CFArrayRef lines      = CTFrameGetLines(frame);
    CFIndex numLines      = CFArrayGetCount(lines);
    CGFloat maxWidth      = 0;
    CGFloat textHeight    = 0;
    CFIndex lastLineIndex = numLines -1;
    for(CFIndex index =0; index < numLines; index++)
    {
        CGFloat ascent, descent, leading, width;
        CTLineRef line = (CTLineRef)CFArrayGetValueAtIndex(lines, index);
        width =CTLineGetTypographicBounds(line, &ascent,  &descent, &leading);
        if(width > maxWidth)
        {
            maxWidth = width;
        }
        
        if(index == lastLineIndex)
        {
            CGPoint lastLineOrigin;
            CTFrameGetLineOrigins(frame,CFRangeMake(lastLineIndex,1), &lastLineOrigin);
            textHeight = CGRectGetMaxY(frameRect) - lastLineOrigin.y+ descent;
        }
    }
    return CGSizeMake(ceil(maxWidth),ceil(textHeight));
}
//计算高度
+(CGSize)columnHeight:(NSAttributedString *)attributedString widthValue:(CGFloat)width;
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    CGSize size=  [CTComLabel measureFrame:textFrame forContext:&context];
    
    NSLog(@"计算高度（777）%@",NSStringFromCGSize(size));
    return size;
}
//模拟一个带图文的字符串
+(NSMutableAttributedString*)attStringFarmat:(NSString*)textString
{
    
    CGFloat  fount = 20;
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:textString];
    
    //字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textString.length)];
    //字体大小
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, textString.length)];
    
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:paragraphStyle forKey:(id)kCTParagraphStyleAttributeName ];
    [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
    
    //加第1个图文
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(3, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(3, 1)];
    [attributedString addAttribute:@"imageName" value:@"1" range:NSMakeRange(3, 1)];
    
    //追加
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(4, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(4, 1)];
    [attributedString addAttribute:@"imageName" value:@"11" range:NSMakeRange(4, 1)];
    
    
    //追加
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(5, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(5, 1)];
    [attributedString addAttribute:@"imageName" value:@"12" range:NSMakeRange(5, 1)];
    
    //加第2个图文
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(6, 1)];
     [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(6, 1)];
    [attributedString addAttribute:@"imageName" value:@"2" range:NSMakeRange(6, 1)];
    
    //加第3个图文
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(9, 1)];
     [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(9, 1)];
     [attributedString addAttribute:@"imageName" value:@"3" range:NSMakeRange(9, 1)];
    
    //加第4个图文
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(12, 1)];
     [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(12, 1)];
    [attributedString addAttribute:@"imageName" value:@"4" range:NSMakeRange(12, 1)];
    
    //加第5个图文
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(15, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(15, 1)];
    [attributedString addAttribute:@"imageName" value:@"5" range:NSMakeRange(15, 1)];
    
    //加第6个图文
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(18, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(18, 1)];
    [attributedString addAttribute:@"imageName" value:@"6" range:NSMakeRange(18, 1)];
    
    return attributedString;
}
+(NSMutableAttributedString*)attStringFarmat:(NSString*)textString sizeFount:(NSInteger)fount
{
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:textString];
    //字体大小
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fount] range:NSMakeRange(0, textString.length)];
    //字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, textString.length)];
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:paragraphStyle forKey:(id)kCTParagraphStyleAttributeName ];
    [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}

@end
