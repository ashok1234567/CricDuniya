//
//  BaseControllerController.m
//  CricketDuniya
//
//  Created by ashok on 1/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "BaseControllerController.h"

@interface BaseControllerController ()

@end

@implementation BaseControllerController
- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, appDelegate.window.frame.size.height-4,appDelegate.window.frame.size.width,4)];
    view.backgroundColor=[UIColor redColor];
    
    UIButton *btnKheloLive=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnKheloLive setTitle:@"KHELO LIVE" forState:UIControlStateNormal];
    [btnKheloLive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnKheloLive.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    [btnKheloLive setBackgroundImage:[UIImage imageNamed:@"1_0001_live-button"] forState:UIControlStateNormal];
    [btnKheloLive setFrame:CGRectMake((appDelegate.window.frame.size.width/2)-35, appDelegate.window.frame.size.height-30,70,30)];
    btnKheloLive.tag=1;
    
    [btnKheloLive addTarget:self action:@selector(clickOnKheloLive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnKheloLive];
    [self.view addSubview:view];

    
}
-(void)clickOnKheloLive:(id)sender{
    
    
   // [self callServiceForWhatNext];
    [objCustomPop ShowWhatNextSmallWindow];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
