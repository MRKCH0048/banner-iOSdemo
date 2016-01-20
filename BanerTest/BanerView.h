//
//  BanerView.h
//  BanerTest
//
//  Created by 亢春辉 on 15/10/23.
//  Copyright © 2015年 亢春辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BanerImageView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *nameLabel;
@end

@interface BanerView : UIView<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,strong)NSArray *dataFeeds;
@property(nonatomic,strong)UIScrollView *contaiView;
@property(nonatomic,strong)NSTimer  *timer;
@property(nonatomic,assign)NSInteger count;
-(void)setResultFeeds:(NSArray*)feeds;
@end
