//
//  CustomPickerView.h
//  UIPickerView
//
//  Created by YouXianMing on 2017/9/1.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewDataAdapter.h"


@class CustomPickerView;

/*
 * CustomPickerViewDelegate
 */
@protocol CustomPickerViewDelegate <NSObject>

@optional

- (void)customPickerView:(CustomPickerView *)pickerView
            didSelectRow:(NSInteger)row
             inComponent:(NSInteger)component;

- (void)customPickerView:(CustomPickerView *)pickerView
         didSelectedRows:(NSArray<NSNumber *> *)rows
           selectedDatas:(NSArray<id> *)datas;

@end

typedef NS_ENUM(NSUInteger, ECustomPickerViewHeightType) {
    kCustomPickerViewHeightTypeMin, // 162.0
    kCustomPickerViewHeightTypeMid, // 180.0
    kCustomPickerViewHeightTypeMax, // 216.0
};

/*
 * CustomPickerView
 */
@interface CustomPickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id <CustomPickerViewDelegate>)delegate
         pickerViewHeightType:(ECustomPickerViewHeightType)pickerViewHeightType;

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id <CustomPickerViewDelegate>)delegate
         pickerViewHeightType:(ECustomPickerViewHeightType)pickerViewHeightType
                  dataAdapter:(PickerViewDataAdapter *)dataAdapter;

@property (nonatomic, weak)             id <CustomPickerViewDelegate>  delegate;
@property (nonatomic, readonly, assign) ECustomPickerViewHeightType    pickerViewHeightType;
@property (nonatomic, readonly, strong) UIPickerView                  *pickView;
@property (nonatomic, strong)           PickerViewDataAdapter         *pickerViewDataAdapter;

- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (NSInteger)selectedRowInComponent:(NSInteger)component;

#pragma mark - Debug

@property (nonatomic) BOOL showPickerCustomViewFrame;

@end
