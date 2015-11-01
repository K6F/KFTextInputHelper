//
//  KFViewController.m
//  KFTextInputHelper
//
//  Created by K6F on 07/20/2015.
//  Copyright (c) 2015 K6F. All rights reserved.
//

#import "KFViewController.h"
#import "KFPickerField.h"

@interface KFViewController ()
@property (weak, nonatomic) IBOutlet KFPickerField *pPickerTextField;

@end

@implementation KFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pPickerTextField setPickerItems:@[
                                           @"1",
                                           @"2",
                                           @"3",
                                           @"4",
                                           @"5",
                                           @"6",
                                           @"7"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
