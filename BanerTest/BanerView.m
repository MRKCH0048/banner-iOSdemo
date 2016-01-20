//
//  BanerView.m
//  BanerTest
//
//  Created by 亢春辉 on 15/10/23.
//  Copyright © 2015年 亢春辉. All rights reserved.
//

#import "BanerView.h"

@implementation BanerImageView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-100)/2, 0, 100, 100)];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-24, self.frame.size.width, 24)];
        self.nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self addSubview:self.nameLabel];
    }
    return self;
}
@end


@implementation BanerView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.images = [[NSMutableArray alloc]initWithCapacity:0];
        self.count = -1;
        [self didInit];
    }
    return self;
}
-(void)didInit
{
    self.contaiView = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.contaiView.pagingEnabled = YES;
    self.contaiView.delegate = self;
    self.contaiView.showsHorizontalScrollIndicator = NO;
    self.contaiView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.contaiView];
    
    CGFloat left = 0;
    CGFloat x = self.frame.size.width;
    for(int i = 0 ;i<3; i++){
        BanerImageView *baner = [[BanerImageView alloc]initWithFrame:CGRectMake(left, 0, self.contaiView.frame.size.width, self.contaiView.frame.size.height)];
        left+=self.contaiView.frame.size.width;
        baner.nameLabel.text = [NSString stringWithFormat:@"page==%d",i];
        [self.contaiView addSubview:baner];
        [self.images addObject:baner];
    }
    [self.contaiView setContentSize:CGSizeMake(left, self.contaiView.frame.size.height)];
    [self.contaiView setContentOffset:CGPointMake(x, 0) animated:YES];
}
-(void)setResultFeeds:(NSArray*)feeds
{
    self.dataFeeds = feeds;
    if(feeds.count>1){
        if(self.timer){
            [self.timer invalidate];
            [self.timer fire];
            self.timer = nil;
        }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(refreshBanner:) userInfo:nil repeats:YES];
        [self.timer fire];
    }else{
        [self refreshBanner:nil];
    }
}

-(void)refreshBanner:(NSTimer*)timer
{
    CGFloat x = self.frame.size.width;
    [self.contaiView setContentOffset:CGPointMake(2*x, 0) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = self.frame.size.width;
    if(self.contaiView.contentOffset.x>=2*x){
        self.count++;
        if(self.count>self.dataFeeds.count-1){
           self.count=0;
        }
        [self.contaiView setContentOffset:CGPointMake(x, 0) animated:NO];
        [self makeImages:self.count];
        
    }else if (self.contaiView.contentOffset.x<=0){
        self.count--;
        if(self.count<0){
           self.count=self.dataFeeds.count-1;
        }
        [self.contaiView setContentOffset:CGPointMake(x, 0) animated:NO];
        [self makeImages:self.count];
       
    }
   
}
-(NSInteger)page:(NSInteger)index
{
    if(index<0){
        return self.dataFeeds.count-1;
    }
    else if (index>self.dataFeeds.count-1){
        return 0;
    }
    return index;
}
-(void)makeImages:(NSInteger)index
{
    //显示上一张图片
    BanerImageView *b0 = self.images[0];
    NSString *imageName = self.dataFeeds[[self page:index-1]];
    b0.imageView.image = [UIImage imageNamed:imageName];
    b0.nameLabel.text = [NSString stringWithFormat:@"%d",([self page:index-1])];
    //显示当前图片
    BanerImageView *b1 = self.images[1];
    NSString *imageName1 = self.dataFeeds[[self page:index]];
    b1.imageView.image = [UIImage imageNamed:imageName1];
    b1.nameLabel.text = [NSString stringWithFormat:@"%d",([self page:index])];
    //显示下一张图片
    BanerImageView *b2 = self.images[2];
    NSString *imageName2 = self.dataFeeds[[self page:index+1]];
    b2.imageView.image = [UIImage imageNamed:imageName2];
    b2.nameLabel.text = [NSString stringWithFormat:@"%d",([self page:index+1])];
    //只有一张图默认不滑动
    self.contaiView.scrollEnabled = (self.dataFeeds.count>1);
}
@end
