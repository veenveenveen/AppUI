//
//  LEMDatePickerController.m
//  AppUI
//
//  Created by Himin on 2019/1/26.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMDatePickerController.h"

@interface LEMDatePickerController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *timeTextField;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation LEMDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
    [self setupDateKeyPan];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.timeTextField endEditing:YES];
}

//禁止用户输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

- (void)setupViews {
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.datePicker.center = self.view.center;
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePicker.datePickerMode = UIDatePickerModeDate;//UIDatePickerModeTime, UIDatePickerModeDate      UIDatePickerModeDateAndTime UIDatePickerModeCountDownTimer
    
    //监听DataPicker的滚动
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.datePicker];
}

- (void)setupDateKeyPan {
    
    self.timeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, kNavAndStatusBarHeight+30, kScreenWidth-40, 40)];
    self.timeTextField.font = [UIFont YRDZSTWithFontSize:18];
    self.timeTextField.placeholder = @"请选择日期";
    self.timeTextField.layer.backgroundColor = [UIColor colorWithHexString:@"efefef"].CGColor;
    self.timeTextField.layer.cornerRadius = 5;
    self.timeTextField.textAlignment = NSTextAlignmentCenter;
    self.timeTextField.textColor = [UIColor colorWithHexString:@"294A5A"];
    self.timeTextField.tintColor = UIColor.clearColor;//可以隐藏光标
    self.timeTextField.delegate = self;
    [self.view addSubview:self.timeTextField];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = [UIColor colorWithHexString:@"eeffee"];
    
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
//    [datePicker setMaximumDate:[NSDate date]];
    
    //设置时间格式
    
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    //设置时间输入框的键盘框样式为时间选择器
    self.timeTextField.inputView = datePicker;
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter stringFromDate:datePicker.date];
    
    self.timeTextField.text = dateStr;
}

@end
