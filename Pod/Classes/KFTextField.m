//
//  KFTextField.m
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#import "KFTextField.h"
#import "KFTextInputHelper.h"

@implementation KFTextField{
    UILabel * paddingView;
    CGColorRef originalBorderColor;
    float originalBorderWidth;
    KFTextInputHelper * _kfInputHelper;
    BOOL pIsInit;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        pIsInit = YES;
        self.enabled = NO;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (pIsInit) {
        pIsInit = NO;
        self.enabled = YES;
    }
    if (!self.superview.kfInputViewHelper)
        self.superview.kfInputViewHelper = [KFTextInputHelper helperWithContainerView:self.superview];
}
#pragma mark - LeftView
-(void)setLeftViewText:(NSString *)text{
    if (!text) return;
    if ([text isEqualToString:@""]) return;
    _leftViewText = text;
    
    paddingView = [[UILabel alloc] init];
    paddingView.textColor = [UIColor darkGrayColor];
    paddingView.backgroundColor = [UIColor clearColor];
    if (_leftViewBackgroundcolor) {
        paddingView.backgroundColor = _leftViewBackgroundcolor;
    }
    // config border width
    float borderWidth = 1.f;
    if (self.leftViewBorderWidth) {
        borderWidth = [self.leftViewBorderWidth floatValue];
    }
    paddingView.layer.borderWidth = borderWidth;
    // config border color
    CGColorRef borderColor = [UIColor brownColor].CGColor;
    if (self.leftViewBorderColor) {
        borderColor = self.leftViewBorderColor.CGColor;
    }
    paddingView.layer.borderColor = [[UIColor brownColor] CGColor];
    
    paddingView.layer.cornerRadius = 4.f;
    paddingView.textAlignment = NSTextAlignmentRight;
    paddingView.text = _leftViewText;
    CGFloat viewWidth;
    if (_leftViewWidth) {
        viewWidth = [_leftViewWidth floatValue];
    }else{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:paddingView.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    viewWidth = [_leftViewText
                   boundingRectWithSize:CGSizeMake(999, 999)
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:attributes
                   context:nil
                   ].size.width;
    }
    paddingView.frame = CGRectMake(0, 0, viewWidth, self.bounds.size.height);
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
-(void)setLeftViewWidth:(NSNumber *)leftViewWidth{
    if (!leftViewWidth) return;
    if (0.01 > leftViewWidth.floatValue) return;
    _leftViewWidth = leftViewWidth;
    CGRect frm = self.leftView.frame;
    frm.size.width = [leftViewWidth floatValue];
    self.leftView.frame = frm;
}
-(void)setLeftViewBackgroundcolor:(UIColor *)leftViewBackgroundcolor{
    if (!leftViewBackgroundcolor) return;
    _leftViewBackgroundcolor = leftViewBackgroundcolor;
    self.leftView.backgroundColor = _leftViewBackgroundcolor;
}
/**
 *  @author Khiyuan.Fan, 2015-12[3]
 *
 *  left view border width
 *
 *  @param leftViewBorderWidth NSNumber @...
 */
-(void)setLeftViewBorderWidth:(NSNumber *)leftViewBorderWidth{
    if (!leftViewBorderWidth) return;
    _leftViewBorderWidth = leftViewBorderWidth;
    paddingView.layer.borderWidth = leftViewBorderWidth.floatValue;
}

-(void)setLeftViewBorderColor:(UIColor *)leftViewBorderColor{
    if (!leftViewBorderColor) return;
    _leftViewBorderColor = leftViewBorderColor;
    paddingView.layer.borderColor = leftViewBorderColor.CGColor;
}

@end
