//
//  KFTextField.h
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KFTextFieldType) {
    KFTextFieldTypeNone =0,
    KFTextFieldTypeNickname
};


@interface KFTextField : UITextField <UITextFieldDelegate>
{
@protected NSMutableArray *inputViews;
@protected UITextField *_textField;
    
@protected BOOL _keyboardIsShown;
@protected CGSize _keyboardSize;
    
@protected UIToolbar *inputToolbar;
@protected UIBarButtonItem *previousBarButton;
@protected UIBarButtonItem *nextBarButton;
@protected UIBarButtonItem *doneBarButton;
@protected int _move_offset;
}
@property (nonatomic,setter=setDoneCommand:) BOOL isDoneCommand;
@property (nonatomic) NSNumber* leftViewWidth;
@property (nonatomic) NSString* leftViewText;
@property (nonatomic) UIColor*  leftViewBackgroundcolor;
/**
 *  @author Khiyuan.Fan, 2015-12[3]
 *
 *  Add border config for left view
 */
@property (nonatomic) NSNumber* leftViewBorderWidth;
@property (nonatomic) UIColor * leftViewBorderColor;

@property (nonatomic) KFTextFieldType verifyType;

-(void)setDoneCommand:(BOOL) bol;
-(void)setMoveOffset:(int) offset;
@end

