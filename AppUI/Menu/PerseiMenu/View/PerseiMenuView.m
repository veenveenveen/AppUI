//
//  PerseiMenuView.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PerseiMenuView.h"
#import "PerseiMenuCell.h"

static NSString *cellID = @"PerseiMenuCell_ID";

@interface PerseiMenuView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<PerseiMenuItem *> *dataArr;

@end

@implementation PerseiMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self dataSetting];
        [self setupViews];
    }
    return self;
}

- (void)dataSetting {
    self.dataArr = [PerseiMenuItem createMenuItems];
}

- (void)setupViews {
    [self addSubview:self.collectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PerseiMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell applyMenuItem:self.dataArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    DataModel *model = self.dataArr[indexPath.section];
//    Item *item = model.items[indexPath.row];
    
    DLog(@"section = %zd, row = %zd",indexPath.section,indexPath.row);
//    [self didSelectItem:item];
}

#pragma mark -

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(self.bounds.size.width-8, 80);
        layout.minimumLineSpacing = 2;
//        layout.minimumInteritemSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.cyanColor;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[PerseiMenuCell class] forCellWithReuseIdentifier:cellID];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


@end
