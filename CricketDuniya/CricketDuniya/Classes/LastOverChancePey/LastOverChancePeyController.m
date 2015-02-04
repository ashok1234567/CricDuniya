//
//  LastOverChancePeyController.m
//  CricketDuniya
//
//  Created by ashok on 2/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "LastOverChancePeyController.h"

@interface LastOverChancePeyController ()

@end

@implementation LastOverChancePeyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    //setup view according to play
     _viewSecoundStep.alpha = 1.0;
     _viewSecoundStep.alpha = 0.0;
     _viewSecoundStep.alpha = 0.0;
    _viewsSartUp.hidden=NO;
    _viewSecoundStep.hidden=YES;
    _viewFinalPlay.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    self.frostedViewController.backgroundFadeAmount=0.5 ;
    self.frostedViewController.direction=REFrostedViewControllerDirectionRight;
    [self.frostedViewController presentMenuViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark GameSteps
-(void)stepOne{
        _viewsSartUp.hidden=YES;
        _viewSecoundStep.hidden=NO;
        _viewFinalPlay.hidden=YES;
        [UIView animateWithDuration:0.5 animations:^() {
            _viewSecoundStep.alpha = 1.0;
            _viewFinalPlay.alpha = 0.0;
             _viewsSartUp.alpha =0.0;
            
        }];
}
-(void)stepTwo{
    
    _viewsSartUp.hidden=YES;
    _viewSecoundStep.hidden=YES;
    _viewFinalPlay.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^() {
        _viewSecoundStep.alpha = 0.0;
        _viewFinalPlay.alpha = 1.0;
        _viewsSartUp.alpha =0.0;
        
    }];
}

- (IBAction)btnActionBat:(id)sender {

    [objSharedData bounce:sender];
    [self performSelector:@selector(stepOne) withObject:nil afterDelay:0.4];
    
}
- (IBAction)btnActionBowl:(id)sender {
    
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepOne) withObject:nil afterDelay:0.4];
}
- (IBAction)btnActionSecondStepBall:(id)sender {
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepTwo) withObject:nil afterDelay:0.4];
    
    
    
}
- (IBAction)btnActionAllPlay:(id)sender {
    
    [objSharedData bounce:sender];
    _lblBallbyBallCommentary.text=@"dummy text";
}


@end
