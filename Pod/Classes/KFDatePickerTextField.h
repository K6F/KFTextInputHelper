//
//  KFDatePickerTextField.h
//  Pods
//
//  Created by FanKhiyuan on 15/9/17.
//
//

#import <UIKit/UIKit.h>

typedef void(^KFDateChangedBlock) (NSDate *bDate, NSString *bDateString);

@interface KFDatePickerTextField : UITextField
// mininum date of date picker
@property (nonatomic, setter=setStartDate:) NSDate *kfStartDate;
// selected date of date picker
@property (nonatomic, setter=setSelectedDate:) NSDate *kfSelectedDate;
// setup method
- (void)kf_setupWithStartDate:(NSDate *)mStartDate
                 selectedDate:(NSDate *)mSelectedDate
                  dateFormate:(NSString *)mDateFormate
                     dateMode:(UIDatePickerMode)mDateMode
                  dateChanged:(KFDateChangedBlock)mChangedBlock;
@end