//
//  YBAppLoader.m
//  YeahBuddy
//
//  Created by Vivek Soni on 30/10/13.
//  Copyright (c) 2013 vInfotech. All rights reserved.
//

#import "AppLoader.h"
#import <QuartzCore/QuartzCore.h>
#import "MCSpriteLayer.h"

@implementation AppLoader



+(AppLoader *) initLoaderView {
    static AppLoader *objAppLoader;
    @synchronized([AppLoader class]) {
        if (!objAppLoader) {
            objAppLoader = [[AppLoader alloc] init];
        }
        return objAppLoader;
    }
	return nil;
}

- (void) startActivityLoader : (UIView *) view : (NSString *) text {
    if (_viewBgLoader) {
        [_viewBgLoader removeFromSuperview];
    }
    //For
    _viewBgLoader = [[UIView alloc] init];
    [_viewBgLoader setFrame:CGRectMake(0, 0, appDelegate.window.frame.size.width, appDelegate.window.frame.size.height)];
    [_viewBgLoader setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.60f]];
    [appDelegate.window addSubview:_viewBgLoader];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"images.jpg" ofType:nil];
    CGImageRef richterImg = [UIImage imageWithContentsOfFile:path].CGImage;
    CGSize fixedSize = CGSizeMake(60, 67 );
    MCSpriteLayer* richter = [MCSpriteLayer layerWithImage:richterImg sampleSize:fixedSize];
    [richter setMasksToBounds:YES];
    [richter setCornerRadius:7.0f];
    [richter setPosition:CGPointMake(_viewBgLoader.center.x, _viewBgLoader.center.y)];
    
    // Both samples use the same animation
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"sampleIndex"];//sampleIndex
    anim.fromValue = [NSNumber numberWithInt:1];
    anim.toValue = [NSNumber numberWithInt:10];
    anim.duration = 2
    ;
    // test for app
    anim.repeatCount = HUGE_VALF;
    
    [richter addAnimation:anim forKey:nil];
    
    [_viewBgLoader.layer addSublayer:richter];
}

//#pragma mark - Bottom Label
//- (void) animateBottomlabel {
//    // BOOL viewUp = YES;
//    NSValue * from = [NSNumber numberWithFloat:_loaderBGImageView.layer.position.y];
//    int YAxis = 0;
//       YAxis = 60;
//    NSValue * to =  [NSNumber numberWithFloat:_loaderBGImageView.layer.position.y-YAxis];
//    NSString * keypath = @"position.y";
//    [_loaderBGImageView.layer addAnimation:[self bounceAnimationFrom:from to:to forKeyPath:keypath withDuration:.6] forKey:@"bounce"];
//    [_loaderBGImageView.layer setValue:to forKeyPath:keypath];
//}
//
//#pragma mark - CAAnimations
//-(CABasicAnimation *)bounceAnimationFrom:(NSValue *)from
//                                      to:(NSValue *)to
//                              forKeyPath:(NSString *)keypath
//                            withDuration:(CFTimeInterval)duration
//{
//    CABasicAnimation * result = [CABasicAnimation animationWithKeyPath:keypath];
//    [result setFromValue:from];
//    [result setToValue:to];
//    [result setDuration:duration];
//    [result setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.5 :1.8 :.8 :0.8]];
//    return  result;
//}

- (void) stopActivityLoader {
    [_loaderImageView removeFromSuperview];
    [_viewBgLoader removeFromSuperview];
}

- (void) changeTextLoader : (NSString *) strText {
    _lblText.text = strText;
}

- (void) showTextOnly : (NSString *) strText {
    [_lblText setTextAlignment:NSTextAlignmentCenter];
    [_lblText setFrame:CGRectMake(10, 20,  300, 20)];
     _lblText.text = strText;
    [_loaderImageView setHidden:YES];
}

- (void) removeOverlay {
    [_viewBgLoader removeFromSuperview];
}

@end
