//
//  LEMCityPickerController.m
//  AppUI
//
//  Created by Himin on 2019/1/26.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMCityPickerController.h"
#import "CustomPickerView.h"

#import "PickerCityDataManager.h"
#import "NSData+JSONData.h"
#import "PickerViewDataAdapter.h"

#import "PickerProvinceView.h"
#import "PickerCityView.h"
#import "PickerAreaView.h"

@interface LEMCityPickerController () <CustomPickerViewDelegate>

@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic, strong) NSArray<PickerProvinceModel *> *provinces;

@property (nonatomic, strong) CustomPickerView      *pickerView;
@property (nonatomic, strong) PickerViewDataAdapter *pickerViewDataAdapter;

@end

@implementation LEMCityPickerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupData];
    [self setupViews];
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kNavAndStatusBarHeight + 40, self.view.bounds.size.width-40, 40)];
    self.showLabel.text = @"";
    self.showLabel.layer.backgroundColor = [UIColor colorWithHexString:@"efefef"].CGColor;
    self.showLabel.layer.cornerRadius = 5;
    self.showLabel.font = [UIFont YRDZSTWithFontSize:18];
    self.showLabel.textColor = [UIColor colorWithHexString:@"294A5A"];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.showLabel];
}

- (void)setupData {
    // 从json文件中获取数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSArray *provinces = [data toListProperty];
    self.provinces     = [PickerCityDataManager provinceModelsWithArray:provinces];
    
    // Create CustomPickerView's dataAdapter.
    self.pickerViewDataAdapter = [PickerViewDataAdapter pickerViewDataAdapterWithComponentsBlock:^(NSMutableArray<PickerViewComponent *> *components) {
        
        // Province component.
        PickerViewComponent *provinceComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.provinces enumerateObjectsUsingBlock:^(PickerProvinceModel *provinceModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerProvinceView class] data:provinceModel]];
            }];
            
        } componentWidth:kScreenWidth / 3.f - 5.f];
        
        // City component.
        PickerViewComponent *cityComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.provinces.firstObject.cities enumerateObjectsUsingBlock:^(PickerCityModel *cityModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerCityView class] data:cityModel]];
            }];
            
        } componentWidth:kScreenWidth / 3.f - 5.f];
        
        // Area component.
        PickerViewComponent *areaComponent = [PickerViewComponent pickerViewComponentWithRowsBlock:^(NSMutableArray<PickerViewRow *> *rows) {
            
            [self.provinces.firstObject.cities.firstObject.areas enumerateObjectsUsingBlock:^(PickerAreaModel *areaModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerAreaView class] data:areaModel]];
            }];
            
        } componentWidth:kScreenWidth / 3.f - 5.f];
        
        [components addObject:provinceComponent];
        [components addObject:cityComponent];
        [components addObject:areaComponent];
        
    } rowHeight:40.f];
}

- (void)setupViews {
    // Create CustomPickerView.
    self.pickerView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)
                                                     delegate:self
                                         pickerViewHeightType:kCustomPickerViewHeightTypeMid
                                                  dataAdapter:self.pickerViewDataAdapter];
    self.pickerView.center = self.view.center;
    self.pickerView.showPickerCustomViewFrame = NO;
    [self.view addSubview:self.pickerView];
}

#pragma mark - CustomPickerViewDelegate

- (void)customPickerView:(CustomPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        NSMutableArray *citys = [NSMutableArray array];
        [self.provinces[row].cities enumerateObjectsUsingBlock:^(PickerCityModel *cityModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [citys addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerCityView class] data:cityModel]];
        }];
        
        NSMutableArray *areas = [NSMutableArray array];
        [self.provinces[row].cities.firstObject.areas enumerateObjectsUsingBlock:^(PickerAreaModel *areaModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [areas addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerAreaView class] data:areaModel]];
        }];
        
        pickerView.pickerViewDataAdapter.components[1].rows = citys;
        pickerView.pickerViewDataAdapter.components[2].rows = areas;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    } else if (component == 1) {
        
        NSInteger       provinceIndex = [self.pickerView selectedRowInComponent:0];
        NSMutableArray *areas         = [NSMutableArray array];
        
        // Protect crash.
        if (self.provinces[provinceIndex].cities.count <= row) {

            row = self.provinces[provinceIndex].cities.count - 1;
        }
        
        [self.provinces[provinceIndex].cities[row].areas enumerateObjectsUsingBlock:^(PickerAreaModel *areaModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [areas addObject:[PickerViewRow pickerViewRowWithViewClass:[PickerAreaView class] data:areaModel]];
        }];
        
        pickerView.pickerViewDataAdapter.components[2].rows = areas;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

- (void)customPickerView:(CustomPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {
    
    PickerProvinceModel *provinceModel;
    PickerCityModel *cityModel;
    PickerAreaModel *areaModel;
    for (int i = 0; i < datas.count; i++) {
        if ([datas[i] isKindOfClass:[PickerProvinceModel class]]) {
            provinceModel = (PickerProvinceModel *)datas[i];
        }
        if ([datas[i] isKindOfClass:[PickerCityModel class]]) {
            cityModel = (PickerCityModel *)datas[i];
        }
        if ([datas[i] isKindOfClass:[PickerAreaModel class]]) {
            areaModel = (PickerAreaModel *)datas[i];
        }
    }
    
    DLog(@"%@", rows);
    DLog(@"%@", datas);
    DLog(@"选择的城市为 %@. %@. %@", provinceModel.province, cityModel.city, areaModel.area);
    
    self.showLabel.text = [NSString stringWithFormat:@"%@. %@. %@", provinceModel.province, cityModel.city, areaModel.area];
}


@end
