//
//  KFTextInputHelper.m
//  SocialHillHotel_iOS
//
//  Created by K6F on 15/3/19.
//  Copyright (c) 2015年 TLTech. All rights reserved.
//

#import "KFTextInputHelper.h"
#import "KFTextView.h"
#import "KFTextField.h"


// ================================================================================================================== //
#import <objc/runtime.h>

@implementation UIView (KFTextInputHelper)
@dynamic kfInputViewHelper;

static char mInputViewHelperKey;
#pragma mark - Setter & Getter

-(void)setKfInputViewHelper:(KFTextInputHelper *)kfInputViewHelper{
    @synchronized(self.kfInputViewHelper){
        objc_setAssociatedObject(self, &mInputViewHelperKey, kfInputViewHelper, OBJC_ASSOCIATION_RETAIN);
    }
}
- (KFTextInputHelper *)kfInputViewHelper{
    return objc_getAssociatedObject(self, &mInputViewHelperKey);
}
- (UIViewController *)kfParentViewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end

// ================================================================================================================== //

@class KFPickerTextField;
@class KFTextField;
@class KFTextView;

@interface KFTextInputHelper ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic)UIView *pContainerView;
@property (weak, nonatomic)UIView<UITextInput> *pCurrentInputView;
@property (nonatomic) NSInteger pInputViewsCount;
@property (nonatomic) NSArray *pInputViews;
@property (nonatomic) UITapGestureRecognizer *pTapGesture;

@property (nonatomic) BOOL pIsKeyboardShown;
@property (nonatomic) BOOL pIsDoneCommand;
@end

static NSString *kfKeyboardMoveAnimationKey       = @"kfViewMoveAtopKeyboard";
static NSString *kfCancelKeyboardMoveAnimationKey = @"kfViewCancelMoveAtopKeyboard";
static const CGFloat kfInputAccessoryViewHeight   = 36.f;
static const int kInputViewTagKey                 = 28475;
static const int kInputViewPreviousButtonTagKey   = 68925;
static const int kInputViewNextButtonTagKey       = 89235;
static const int kInputViewDoneButtonTagKey       = 92787;


@implementation KFTextInputHelper{
    CGFloat pMoveOffsetY;
    CGFloat pOriginalBorderWidth;
    CGColorRef pOriginalBorderColor;
    CGFloat pOriginalCornerRadius;
}
+ (void)setupHelperWithContainerView:(UIView *)mContainerView{
    UIViewController *mController = mContainerView.kfParentViewController;
    @synchronized(mController.view.kfInputViewHelper) {
        if (!mController.view.kfInputViewHelper)
            mController.view.kfInputViewHelper = [[KFTextInputHelper alloc] initWithContainerView:mController.view];
    }
}
+ (instancetype)helperWithContainerView:(UIView *)mContainerView{
    UIViewController *mController = mContainerView.kfParentViewController;
    return mController.view.kfInputViewHelper;
}
- (instancetype)initWithContainerView:(UIView *)mContainerView{
    self = [super init];
    if (self) {
        self.pContainerView = mContainerView;
        [self reloadInputs];
    }
    return self;
}
- (void)reloadInputs{
    [self p_markTagOfInputViewIn:self.pContainerView];
    [self p_setupInputViewIn:self.pContainerView];
}

#pragma mark - keyboard observer
-(void)p_addEditingObserver{
    NSNotificationCenter * noticeCenter = [NSNotificationCenter defaultCenter];
    [noticeCenter addObserver:self
                     selector:@selector(p_keyboardDidShow:)
                         name:UIKeyboardWillShowNotification
                       object:nil];
    [noticeCenter addObserver:self
                     selector:@selector(p_keyboardWillHide:)
                         name:UIKeyboardWillHideNotification
                       object:nil];
}

-(void)p_removeEditingObserver{
    NSNotificationCenter * noticeCenter = [NSNotificationCenter defaultCenter];
    [noticeCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [noticeCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/** add tap gesture to active window */
-(void)p_addTapGesture{
    self.pTapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(p_windowTapped:)];
    [self.pContainerView addGestureRecognizer:self.pTapGesture];
}

/** remove tap gesture from active window */
-(void)p_removeTapGesture{
    [self.pContainerView.window removeGestureRecognizer:self.pTapGesture];
}

- (void)p_keyboardDidShow:(NSNotification *) notification{
    if (self.pIsKeyboardShown) return;
    [self p_addTapGesture];
    NSDictionary* info = [notification userInfo];
    NSTimeInterval mDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect mFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self p_moveInputView:self.pCurrentInputView
        atopKeyboardFrame:mFrame
             withDuration:mDuration];
}

- (void)p_keyboardWillHide:(NSNotification *) notification{
    self.pIsKeyboardShown    = NO;
    [self p_removeTapGesture];
    NSDictionary *mInfo      = [notification userInfo];
    NSTimeInterval mDuration = [mInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self pCancelMoveAtopKeyboard:mDuration];
}

/** check the tap, hide keyboard automatically */
- (void)p_windowTapped:(UITapGestureRecognizer*)recognizer {
    [self.pCurrentInputView resignFirstResponder];
}


#pragma mark - Editing Notification
/** add notification to text input view */
-(void)p_addNotification:(id<UITextInput>)mInputView{
    NSNotificationCenter * noticeCenter = [NSNotificationCenter defaultCenter];
    if ([mInputView isKindOfClass:[UITextField class]]) {
        [noticeCenter addObserver:self
                         selector:@selector(p_textDidBeginEditing:)
                             name:UITextFieldTextDidBeginEditingNotification
                           object:mInputView];
        [noticeCenter addObserver:self
                         selector:@selector(p_textDidEndEditing:)
                             name:UITextFieldTextDidEndEditingNotification
                           object:mInputView];
    }else if ([mInputView isKindOfClass:[UITextView class]]){
        [noticeCenter addObserver:self
                         selector:@selector(p_textDidBeginEditing:)
                             name:UITextViewTextDidBeginEditingNotification
                           object:mInputView];
        [noticeCenter addObserver:self
                         selector:@selector(p_textDidEndEditing:)
                             name:UITextViewTextDidEndEditingNotification
                           object:mInputView];
    }
}

-(void)p_textDidBeginEditing:(NSNotification *) notification{
    [self p_MarkBorderFirstResponder:notification.object];
    [self p_addEditingObserver];
    self.pIsDoneCommand = NO;
    self.pCurrentInputView = notification.object;
    self.kfCurrentFirstResponder = notification.object;
    [notification.object becomeFirstResponder];
}

-(void)p_textDidEndEditing:(NSNotification *) notification{
    [self pCancelMarkBorderFirstResponder:notification.object];
    self.kfCurrentFirstResponder = nil;
    [self p_removeEditingObserver];
    
    NSDictionary* info = [notification userInfo];
    NSValue *durationValue = info[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration;
    [durationValue getValue:&duration];
    [self pCancelMoveAtopKeyboard:duration];
}

#pragma mark - InputAccessoryView
/** Find UITextInput in containerView*/
-(void)p_markTagOfInputViewIn:(UIView*)mView{
    [mView.subviews enumerateObjectsUsingBlock:^(UIView * subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[UIWebView class]]) return;
        if (![subView conformsToProtocol:@protocol(UITextInput)]){
            [self p_markTagOfInputViewIn:subView];
            return;
        };
        id<UITextInput> inputView = (id<UITextInput>)subView;
        [self p_addNotification:inputView];
        subView.tag = self.pInputViewsCount + kInputViewTagKey;
        self.pInputViewsCount++;
    }];
}
-(void)p_setupInputViewIn:(UIView *)mView{
    for (int idx = 0; idx < self.pInputViewsCount; idx++) {
        id mInputView = [mView viewWithTag:(idx + kInputViewTagKey)];
        [self p_createInputAccessoryViewInView:mInputView];
    }
}

/** create an input accessory view for keyboard */
-(void)p_createInputAccessoryViewInView:(id)mInputView{
    NSInteger mIdx = [mInputView tag] - kInputViewTagKey;
    // item on toolbar
    UIBarButtonItem *mBarButtonPrevious, *mBarButtonNext, *mBarButtonHide, *mFlexBarItem, *mSeparateLine;
    mBarButtonPrevious = [[UIBarButtonItem alloc] initWithTitle:@"上一个"
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(p_previousButtonTapped:)];
    mBarButtonNext     = [[UIBarButtonItem alloc] initWithTitle:@"下一个"
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(p_nextButtonTapped:)];
    mBarButtonHide     = [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"KF_KeyboardDown@3x"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(p_hideButtonTapped:)];
    //    mBarButtonHide     = [[UIBarButtonItem alloc] initWithTitle:@"完成"
    //                                                          style:UIBarButtonItemStylePlain
    //                                                         target:self
    //                                                         action:@selector(p_hideButtonTapped:)];
    mFlexBarItem       = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                       target:nil
                                                                       action:nil];
    mSeparateLine      = [[UIBarButtonItem alloc] initWithImage:[self imageNamed:@"KF_KeyboardSeparateLine@3x"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:nil
                                                         action:nil];
    // setTintColor
    mBarButtonPrevious.tintColor = [UIColor darkGrayColor];
    mBarButtonNext.tintColor     = [UIColor darkGrayColor];
    mBarButtonHide.tintColor     = [UIColor darkGrayColor];
    mSeparateLine.tintColor      = [UIColor lightGrayColor];
    
    // setImageOffset
    mBarButtonHide.imageInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    // set tag
    mBarButtonPrevious.tag = mIdx + kInputViewPreviousButtonTagKey;
    mBarButtonNext.tag = mIdx + kInputViewNextButtonTagKey;
    mBarButtonHide.tag = mIdx + kInputViewDoneButtonTagKey;
    // Toolbar
    CGRect viewFrame = CGRectMake(0, 0, self.pContainerView.window.bounds.size.width, kfInputAccessoryViewHeight);
    UIToolbar *mInputAccessoryView = [[UIToolbar alloc] initWithFrame:viewFrame];
    [mInputAccessoryView setBarStyle:UIBarStyleDefault];
    
    // items shown
    NSMutableArray *mItems = [@[mBarButtonPrevious,
                                mFlexBarItem,
                                mBarButtonNext,
                                mSeparateLine,
                                mBarButtonHide] mutableCopy];
    BOOL mHasPreviousTextInput = (mIdx > 0)?YES:NO;
    BOOL mHasNextTextInput = (mIdx < (self.pInputViewsCount -1))?YES:NO;
    mBarButtonNext.enabled = mHasNextTextInput;
    mBarButtonPrevious.enabled = mHasPreviousTextInput;
    
    // add items to toolbar
    mInputAccessoryView.items = [mItems copy];
    
    // set input accessory view
    [mInputView setInputAccessoryView:mInputAccessoryView];
}

#pragma mark -- action On InputAccessoryView
- (void)p_previousButtonTapped:(UIBarButtonItem *)mButton{
    NSInteger tagIndex = mButton.tag - kInputViewPreviousButtonTagKey;
    UIView *aimInputView;
    do {
        tagIndex--;
        if (0 > tagIndex) return;
        aimInputView = [self.pContainerView viewWithTag:(tagIndex + kInputViewTagKey)];
    } while (![aimInputView conformsToProtocol:@protocol(UITextInput)]);
    id inputView = [self.pContainerView viewWithTag:(tagIndex + kInputViewTagKey)];
    [inputView  resignFirstResponder];
    [aimInputView becomeFirstResponder];
}

- (void)p_nextButtonTapped:(UIBarButtonItem *)mButton{
    NSInteger tagIndex = mButton.tag - kInputViewNextButtonTagKey;
    UIView *aimInputView;
    do {
        tagIndex++;
        if (self.pInputViewsCount <= tagIndex) return;
        aimInputView = [self.pContainerView viewWithTag:(tagIndex + kInputViewTagKey)];
    } while (![aimInputView conformsToProtocol:@protocol(UITextInput)]);
    NSLog(@"nexttag:%ld",(long)tagIndex);
    id inputView = [self.pContainerView viewWithTag:(tagIndex + kInputViewTagKey)];
    [inputView  resignFirstResponder];
    [aimInputView becomeFirstResponder];
}
- (void)p_hideButtonTapped:(UIBarButtonItem *)mButton{
    self.pIsDoneCommand = YES;
    NSInteger tagIndex = mButton.tag - kInputViewDoneButtonTagKey;
    id inputView = [self.pContainerView viewWithTag:(tagIndex + kInputViewTagKey)];
    [inputView  resignFirstResponder];
}


#pragma mark - keyboard
-(void)p_moveInputView:(UIView *)mInputView
     atopKeyboardFrame:(CGRect)mKeyboardFrame
          withDuration:(NSTimeInterval)mDuration{
    CGRect windowFrame = self.pContainerView.window.frame;
    CGRect viewFrame = [self.pCurrentInputView convertRect:self.pCurrentInputView.bounds toView:nil];
    pMoveOffsetY = (windowFrame.size.height - mKeyboardFrame.size.height) - (viewFrame.origin.y + viewFrame.size.height) ;
    if (pMoveOffsetY > 0)return;
    CGRect aimFrame = CGRectMake(0.f
                                 , pMoveOffsetY
                                 , windowFrame.size.width
                                 , windowFrame.size.height);
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:kfKeyboardMoveAnimationKey context:nil];
        [UIView setAnimationDuration:mDuration];
        self.pContainerView.window.frame = aimFrame;
        [UIView commitAnimations];
    });
}
-(void)pCancelMoveAtopKeyboard:(NSTimeInterval)mDuration{
    if (pMoveOffsetY > 0)return;
    CGRect originFrame = CGRectMake(0.f,0.f, self.pContainerView.window.frame.size.width, self.pContainerView.window.frame.size.height);
    if (self.pIsDoneCommand) {
        [UIView beginAnimations:kfCancelKeyboardMoveAnimationKey context:nil];
        [UIView setAnimationDuration:mDuration];
        self.pContainerView.window.frame = originFrame;
        [UIView commitAnimations];
    }else{
        self.pContainerView.window.frame = originFrame;
    }
    pMoveOffsetY = 0.f;
}

#pragma mark - border
-(void)p_MarkBorderFirstResponder:(UIView *)mInputView{
    pOriginalBorderColor          = mInputView.layer.borderColor;
    pOriginalBorderWidth          = mInputView.layer.borderWidth;
    pOriginalCornerRadius         = mInputView.layer.cornerRadius;
    mInputView.layer.borderWidth  = 1.0f;
    mInputView.layer.borderColor  = [[UIColor greenColor] CGColor];
    mInputView.layer.cornerRadius = 4.f;
}
-(void)pCancelMarkBorderFirstResponder:(UIView *)mInputView{
    mInputView.layer.borderWidth  = pOriginalBorderWidth;
    mInputView.layer.borderColor  = pOriginalBorderColor;
    mInputView.layer.cornerRadius = pOriginalCornerRadius;
}
#pragma mark - Resource

- (UIImage *)imageNamed:(NSString *)mName{
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"KFTextInputHelper"
                                                                            ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [bundle pathForResource:mName ofType:@"png"];
    return[[UIImage alloc] initWithContentsOfFile:imagePath];
}
@end
