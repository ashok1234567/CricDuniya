//
//  CODialog.h
//  CODialog
//
//  Created by Erik Aigner on 10.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    AlertDialogButtonStyleDefault,
    AlertDialogButtonStyleWhite,
    AlertDialogButtonStylePurple
    
}AlertDialogButtonStyle;

enum {
    UFDialogStyleDefault = 0,
    UFDialogStyleIndeterminate,
    UFDialogStyleDeterminate,
    UFDialogStyleSuccess,
    UFDialogStyleError,
    UFDialogStyleCustomView
};
typedef NSInteger UFDialogStyle;

@protocol AlertDialogViewDelegate <NSObject>

-(void) alertDialogTextFieldShouldReturn:(UITextField *)textField;

@end


@interface AlertDialogView : UIView

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, assign) UFDialogStyle dialogStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *otherMsgtitle;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSTimeInterval batchDelay;
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, assign) id <AlertDialogViewDelegate> delegate;

+ (instancetype)dialogWithView:(UIView *)hostView;

- (id)initWithView:(UIView *)hostView;

/** @name Configuration */

- (void)resetLayout;
- (void)removeAllControls;
- (void)removeAllTextFields;
- (void)removeAllButtons;

- (void)addTextFieldWithPlaceholder:(NSString *)placeholder secure:(BOOL)secure textStr:(NSString *)textStr;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel highlighted:(BOOL)flag withNormatStateImage:(UIImage *)normalImg withhighLightedStateImage:(UIImage *)highlightedImg;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel highlighted:(BOOL)flag;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel highlighted:(BOOL)flag buttonType:(AlertDialogButtonStyle) alertDialogButtonStyle;
/** @name Getting Values */

- (NSString *)textForTextFieldAtIndex:(NSUInteger)index;

/** @name Showing, Updating and Hiding */

- (void)showOrUpdateAnimated:(BOOL)flag;
- (void)hideAnimated:(BOOL)flag;
- (void)hideAnimated:(BOOL)flag afterDelay:(NSTimeInterval)delay;

/** @name Methods to Override */

- (void)drawRect:(CGRect)rect;
- (void)drawDialogBackgroundInRect:(CGRect)rect;
- (void)drawButtonInRect:(CGRect)rect title:(NSString *)title highlighted:(BOOL)highlighted down:(BOOL)down;
- (void)drawSymbolInRect:(CGRect)rect;
- (void)drawTextFieldInRect:(CGRect)rect;
- (void)drawDimmedBackgroundInRect:(CGRect)rect;

@end

@interface UFDialogTextField : UITextField
@property (nonatomic, strong) AlertDialogView *dialog;
@end
