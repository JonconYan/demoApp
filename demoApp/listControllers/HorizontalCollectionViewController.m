//
//  HorizontalCollectionViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/7/29.
//

#import "HorizontalCollectionViewController.h"
#import "HorizontalCollectionViewLayout.h"
#import <UIKit/UIKit.h>

#define CELL_INSERT 10
//左右露出的距离
#define CELL_EDGE_INSERT 5

@interface HorizontalCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HorizontalCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.collectionView];
}

#pragma mark - getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _backgroundView.center = CGPointMake(self.view.width/2, self.view.height/2);
        _backgroundView.backgroundColor = [UIColor redColor];
    }
    return _backgroundView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat marginTop = 20;
        HorizontalCollectionViewLayout *layout = [[HorizontalCollectionViewLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = CELL_INSERT;
        layout.maxItemCount = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, CELL_INSERT + CELL_EDGE_INSERT, 0, CELL_INSERT + CELL_EDGE_INSERT);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, marginTop, self.backgroundView.width, self.backgroundView.height - marginTop * 2) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delaysContentTouches = NO;
        _collectionView.clipsToBounds = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        layout.itemWidth = _collectionView.width - CELL_INSERT * 2 - CELL_EDGE_INSERT * 2;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.cornerRadius = 10;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width - CELL_INSERT * 2 - CELL_EDGE_INSERT * 2, collectionView.height);
}

@end
