//
//  HeadView.m
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView
@synthesize delegate = _delegate;
@synthesize section,open,backBtn,lblMatchTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
        
        
        UILabel *lblMatchTitle1=[[UILabel alloc]init];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,5, 158, 60.5);
        lblMatchTitle1.frame=CGRectMake(5, 0, 158,20.5);
        [lblMatchTitle1 setFont:[UIFont fontWithName:@"Arial" size:12]];
        [btn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];

//        [btn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"btn_on"] forState:UIControlStateHighlighted];
         [btn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12]];
        [btn.titleLabel setTextColor:[UIColor blackColor]];
        
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self addSubview:btn];
        [self addSubview:lblMatchTitle1];
        self.backBtn = btn;
        self.lblMatchTitle=lblMatchTitle1;

    }
    return self;
}

-(void)doSelected{
    //    [self setImage];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:)]){
     	[_delegate selectedWith:self];
    }
}
@end
