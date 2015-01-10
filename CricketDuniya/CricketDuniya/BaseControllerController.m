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
    [self.view addSubview:view];

    
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
