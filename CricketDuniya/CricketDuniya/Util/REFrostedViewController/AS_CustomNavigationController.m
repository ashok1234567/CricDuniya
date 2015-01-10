//
//  AS_CustomNavigationController.m
//  AS_Slider_final
//
//  Created by gate6 on 07/04/14.
//  Copyright (c) 2014 com.apmocon. All rights reserved.
//

#import "AS_CustomNavigationController.h"

@interface AS_CustomNavigationController ()

@end

@implementation AS_CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
        // Dismiss keyboard (optional)
        //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];

        // Present the view controller
        //
    [self.frostedViewController panGestureRecognized:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
