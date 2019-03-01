//
//  TAViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/9.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "TAViewController.h"
#import "LEMTransitionAnimation.h"
#import "LEMTransitionModel.h"
#import "LEMTransitionCell.h"

static NSString *cellID = @"animation_cell";
static NSInteger indexImg = 1;

@interface TAViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy)   NSArray<LEMTransitionModel *> *dataModels;
@property (nonatomic, strong) UIView *aniView;
@property (nonatomic, strong) UIImageView *imgV;

@end

@implementation TAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.dataModels = [LEMTransitionModel createDataModels];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.aniView];
    [self.aniView addSubview:self.imgV];
    
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LEMTransitionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.data = self.dataModels[indexPath.row];
    [cell loadContent];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LEMTransitionModel *model = self.dataModels[indexPath.row];
    [LEMTransitionAnimation transitionWithType:model.transitionType subType:LEMTransitionSubTypeLeft onView:self.aniView];
    
    NSString *str = [NSString stringWithFormat:@"IMG_0%zd.JPG",indexImg];
    self.imgV.image = [UIImage imageNamed:str];
    
    indexImg++;
    if (indexImg > 6) {
        indexImg = 1;
    }
    DLog(@"indexImg = %zd",indexImg);
}

#pragma mark -

- (UIView *)aniView {
    if (!_aniView) {
        _aniView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight, self.view.bounds.size.width, 220)];
        _aniView.clipsToBounds = YES;
    }
    return _aniView;
}

- (UIImageView *)imgV {
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:self.aniView.bounds];
        _imgV.image = [UIImage imageNamed:@"IMG_06.JPG"];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgV;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width-8)/3, self.view.bounds.size.width/3);
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 2;
        
        CGRect rect = CGRectMake(0, kNavAndStatusBarHeight+self.aniView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-kNavAndStatusBarHeight-self.aniView.bounds.size.height);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[LEMTransitionCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

@end
