//
//  ViewController.m
//  BanerTest
//
//  Created by 亢春辉 on 15/10/23.
//  Copyright © 2015年 亢春辉. All rights reserved.
//

#import "ViewController.h"
#import "BanerView.h"
#import "CTComLabel.h"
#import "Student.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *myTab;
@property(nonatomic,strong)NSMutableArray *nam3s;
@end

@implementation ViewController
{
    NSMutableArray *items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 480-64) style:UITableViewStyleGrouped];
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    [self.view addSubview:self.myTab];
    self.nam3s = [[NSMutableArray alloc]initWithCapacity:0];
//    BanerView *banner = [[BanerView alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
//    banner.backgroundColor = [UIColor blackColor];
//    [banner setResultFeeds:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"]];
//    [self.view addSubview:banner];
    
//    NSMutableAttributedString *att = [CTComLabel attStringFarmat:@"黑胡椒服时挥看到世纪福克斯开裆裤司芬克斯的加夫里什打开"];
//    
//    CGSize  dd = [CTComLabel columnHeight:att widthValue:200];
//    CTComLabel *com = [[CTComLabel alloc]initWithFrame:CGRectMake(20, 50, 200, dd.height)];
//    com.backgroundColor = [UIColor cyanColor];
//    com.attributedString = att;
//    
//    [self.view addSubview:com];
//    items = [[NSMutableArray alloc]init];
//    Student *stu = [[Student alloc]init];
//    stu.name = @"1";
//    stu.age  = 1;
//    
//    Student *stu2 = [[Student alloc]init];
//    stu2.name = @"2";
//    stu2.age  = 2;
//    
//    Student *stu3 = [[Student alloc]init];
//    stu3.name = @"3";
//    stu3.age  = 3;
//    
//    Student *stu4 = [[Student alloc]init];
//    stu4.name = @"4";
//    stu4.age  = 4;
//    
//    
//     [items addObject:stu];
//     [items addObject:stu2];
//     [items addObject:stu3];
//     [items addObject:stu4];
//    
//    
//    Student *stu5 = [[Student alloc]init];
//    stu5.name = @"4";
//    stu5.age  = 4;
//    Student *stu6 = [[Student alloc]init];
//    stu6.name = @"5";
//    stu6.age  = 5;
//    Student *stu7 = [[Student alloc]init];
//    stu7.name = @"1";
//    stu7.age  = 1;
//    
//    NSArray *sort = @[stu5,stu6,stu7];
//    
//    [items addObjectsFromArray:sort];
//    
//    for(Student *ss in items)
//    {
//        NSLog(@"[111]   %@",ss.name);
//    }
//    
//    NSSet *set = [NSSet setWithArray:items];
//    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"age" ascending:NO]];
//    NSArray *sortSetArray = [set sortedArrayUsingDescriptors:sortDesc];
//
//    NSLog(@"888888888");
//    for(Student *ss in sortSetArray)
//    {
//        NSLog(@"[2222]   %@",ss.name);
//    }
    
    
//    UIView *viewA = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
//    viewA.backgroundColor =[UIColor redColor];
//    [self.view addSubview:viewA];
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sss:)];
//    [viewA addGestureRecognizer:tap];
//    
//    UIView *viewV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    viewV.backgroundColor =[UIColor blueColor];
//    viewV.userInteractionEnabled = NO;
//    [viewA addSubview:viewV];
//    UIPanGestureRecognizer *tap2 =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(sss2:)];
//    [viewV addGestureRecognizer:tap2];
//    UITapGestureRecognizer *tap3 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sss3:)];
//    [viewV addGestureRecognizer:tap3];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.myTab.frame = CGRectMake(0, 64, 320, 480-64);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 34)];
        view.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *uu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ggggg:)];
        [view addGestureRecognizer:uu];
        return view;
    }
    else{
    
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 34)];
        view.backgroundColor = [UIColor yellowColor];
        return view;

    }
    return nil;
}
-(void)ggggg:(UITapGestureRecognizer*)gest
{
    
    if(self.nam3s.count==0){
        [self.nam3s addObject:@""];
        [self.nam3s addObject:@""];
        [self.nam3s addObject:@""];
        [self.nam3s addObject:@""];
        [self.myTab insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }else{
    
        [self.nam3s removeAllObjects];
        [self.myTab deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
    return self.nam3s.count;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 34;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *name = @"ww";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%td",indexPath.row];
    return cell;
}
-(void)sss:(UITapGestureRecognizer*)tap
{
    NSLog(@"1");
}
-(void)sss2:(UITapGestureRecognizer*)tap
{
      NSLog(@"2");
}
-(void)sss3:(UITapGestureRecognizer*)tap
{
    NSLog(@"3");
}
@end
