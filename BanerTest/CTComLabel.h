//
//  CTComLabel.h
//  BanerTest
//
//  Created by 亢春辉 on 15/12/25.
//  Copyright © 2015年 亢春辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTComLabel : UIView
@property(nonatomic,strong)NSMutableAttributedString *attributedString;
//MARK:计算高度
+(CGSize)columnHeight:(NSAttributedString *)attributedString widthValue:(CGFloat)width;
//MARK:初始化字符串
+(NSMutableAttributedString*)attStringFarmat:(NSString*)textString;
+(NSMutableAttributedString*)attStringFarmat:(NSString*)textString sizeFount:(NSInteger)fount;
@end
