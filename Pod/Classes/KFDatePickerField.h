//
//  KFDatePickerField.h
//  Pods
//
//  Created by FanKhiyuan on 15/9/17.
//
//

#import <UIKit/UIKit.h>
#import "KFTextField.h"

typedef void(^KFDateChangedBlock) (NSDate *bDate, NSString *bDateString);
IB_DESIGNABLE
@interface KFDatePickerField : KFTextField
/**
 *  date format show in textfield
 */
@property (nonatomic, setter=setDateFormat:)IBInspectable NSString *kfDateFormat;
// mininum date of date picker
@property (nonatomic, setter=setStartDate:) NSDate *kfStartDate;
@property (nonatomic, setter=setEndDate:)   NSDate *kfEndDate;
// selected date of date picker
@property (nonatomic, setter=setSelectedDate:) NSDate *kfSelectedDate;
// setup method
- (void)kf_setupWithStartDate:(NSDate *)mStartDate
                 selectedDate:(NSDate *)mSelectedDate
                   dateFormat:(NSString *)mDateFormat
                     dateMode:(UIDatePickerMode)mDateMode
                  dateChanged:(KFDateChangedBlock)mChangedBlock;
@end
