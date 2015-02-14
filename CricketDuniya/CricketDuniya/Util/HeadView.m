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
@synthesize section,open,backBtn,lblMatchTitle,lblMatchTitle2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
        
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(-10,7, 145, 80.5);
        [btn setImage:[UIImage imageNamed:@"arrowQ"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(25, btn.frame.size.width-12, 0, 0)];
        
        
        [btn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
         btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        
        UILabel *lblMatchTitle1=[[UILabel alloc]init];
        lblMatchTitle1.frame=CGRectMake(70, 0, 158,20.5);
        [lblMatchTitle1 setFont:[UIFont fontWithName:@"Arial" size:11]];
        [lblMatchTitle1 setTextColor:[UIColor lightGrayColor]];
        [self addSubview:lblMatchTitle1];
        
        
        UILabel *lblMatchTitle22=[[UILabel alloc]init];
        lblMatchTitle22.frame=CGRectMake(5, 0, 70,20.5);
        [lblMatchTitle22 setFont:[UIFont fontWithName:@"Arial" size:13]];
        [lblMatchTitle22 setTextColor:[UIColor yellowColor]];
        [self addSubview:lblMatchTitle22];
        
        
        UILabel *lblLine=[[UILabel alloc]init];
        lblLine.frame=CGRectMake(0,0, 145, 1.0);
        [lblLine setBackgroundColor:[UIColor whiteColor]];
       // [self addSubview:lblLine];
        
        self.backBtn = btn;
        self.lblMatchTitle=lblMatchTitle1;
        self.lblMatchTitle2=lblMatchTitle22;
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
