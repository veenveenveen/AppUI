//
//  DataModel.m
//  AppUI
//
//  Created by Himin on 2019/1/10.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "DataModel.h"
#import "Controllers.h"

@implementation DataModel

+ (instancetype)dataModelWithTitle:(NSString *)title items:(NSArray *)items {
    DataModel *model = [[DataModel alloc] init];
    model.title = title;
    model.items = items;
    return model;
}

+ (NSArray<DataModel *> *)createDataModels {
    DataModel *m1 = [DataModel dataModelWithTitle:@"Label" items:@[
                                                            [Item itemWithObject:[LabelsViewController class] withName:@"labels"],
                                                                   ]];
    DataModel *m2 = [DataModel dataModelWithTitle:@"Button" items:@[
                                                            [Item itemWithObject:[ButtonsViewController class] withName:@"buttons"],
                                                                    ]];
    DataModel *m3 = [DataModel dataModelWithTitle:@"Navbar" items:@[
                                                            [Item itemWithObject:[ViewController2 class] withName:@"vc2"]
                                                                    ]];
    DataModel *m4 = [DataModel dataModelWithTitle:@"TabBar" items:@[
                                                            [Item itemWithObject:[ExampleTabsViewController class] withName:@"ColorMatchTabs"],
                                                            [Item itemWithObject:[ExamplePopTabsController class] withName:@"PopTabs"],
                                                            [Item itemWithObject:[ScrollTabViewController class] withName:@"ScrollTabs"],
                                                            [Item itemWithObject:[YALFoldingTabBarController class] withName:@"YALFoldingTabBar"]
                                                                    ]];
    DataModel *m5 = [DataModel dataModelWithTitle:@"Carousel" items:@[
                                                            [Item itemWithObject:[LEMColorCarouselController class] withName:@"ColorCarousel"],
                                                            [Item itemWithObject:[LEMScaleScrollController class] withName:@"ScaleScroll"],
                                                            [Item itemWithObject:[CarouselViewController2 class] withName:@"CWCarousel"]
                                                                    ]];
    DataModel *m6 = [DataModel dataModelWithTitle:@"Menu" items:@[
                                                            [Item itemWithObject:[ExampleSideBarViewController class] withName:@"SideBar"],
                                                            [Item itemWithObject:[PerseiMenuController class] withName:@"PerseiMenu"],
                                                            [Item itemWithObject:[ViewController2 class] withName:@"vc2"]
                                                                  ]];
    DataModel *m7 = [DataModel dataModelWithTitle:@"List" items:@[
                                                            [Item itemWithObject:[TreeStructureTableViewController class] withName:@"树形结构cell"],
                                                            [Item itemWithObject:[TapCellAnimationController class] withName:@"cell点击动画"]
                                                                  ]];
    DataModel *m8 = [DataModel dataModelWithTitle:@"Toast" items:@[
                                                            [Item itemWithObject:[ExampleToastShowController class] withName:@"toast show"],
                                                                   ]];
    DataModel *m9 = [DataModel dataModelWithTitle:@"Loading" items:@[
                                                            [Item itemWithObject:[LoadingViewController class] withName:@"加载动画"],
                                                            [Item itemWithObject:[ViewController2 class] withName:@"vc2"]
                                                                     ]];
    DataModel *m10 = [DataModel dataModelWithTitle:@"SpecialEffect" items:@[
                                                            [Item itemWithObject:[LEMShiChaViewController class] withName:@"视差效果"],
                                                            [Item itemWithObject:[TAViewController class] withName:@"转场动画"],
                                                            [Item itemWithObject:[NormalTitleTableViewController class] withName:@"UITableView状态切换效果"],
                                                            [Item itemWithObject:[ExampleScaleImageController class] withName:@"下拉放大视图"],
                                                            [Item itemWithObject:[BezierPathViewController class] withName:@"BezierPath"],
                                                            [Item itemWithObject:[LEMBezierViewController class] withName:@"Bezier曲线绘制"]
                                                                           ]];
    DataModel *m11 = [DataModel dataModelWithTitle:@"ParticleAnimation" items:@[
                                                            [Item itemWithObject:[ViewController1 class] withName:@"vc1"]
                                                                               ]];
    DataModel *m12 = [DataModel dataModelWithTitle:@"PageControl" items:@[
                                                            [Item itemWithObject:[PageControlStyleController class] withName:@"pageControlStyle"]
                                                                        ]];
    DataModel *m13 = [DataModel dataModelWithTitle:@"Shape" items:@[
                                                            [Item itemWithObject:[ViewController1 class] withName:@"vc1"]
                                                                    ]];
    DataModel *m14 = [DataModel dataModelWithTitle:@"Pickerview" items:@[
                                                            [Item itemWithObject:[ExamplePickerViewController class] withName:@"PickerViewShow"],
                                                            [Item itemWithObject:[LEMCityPickerController class] withName:@"城市选择器"],
                                                            [Item itemWithObject:[LEMDatePickerController class] withName:@"日期选择器"]
                                                                        ]];
    return @[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14];
}

@end
