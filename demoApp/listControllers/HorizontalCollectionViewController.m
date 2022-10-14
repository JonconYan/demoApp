//
//  HorizontalCollectionViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/7/29.
//

#import "HorizontalCollectionViewController.h"
#import "HorizontalCollectionViewLayout.h"
#import "UIColor+Plugin.h"
#import <UIKit/UIKit.h>

#define CELL_INSERT 8
//左右露出的距离
#define CELL_EDGE_INSERT 12
#define START_INDEX 4

@interface DisplayCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;

@end

@implementation DisplayCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = [UIFont boldSystemFontOfSize:50];
        _label.textColor = [UIColor blackColor];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label sizeToFit];
    self.label.center = CGPointMake(self.contentView.width / 2, self.contentView.height / 2);
}

- (void)setText:(NSString *)text {
    _label.text = text;
    [self setNeedsLayout];
}

@end

@interface HorizontalCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

//view
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HorizontalCollectionViewLayout *layout;
@property (nonatomic, strong) UIButton *pickerBtn;

//model
@property (nonatomic, copy) NSArray<NSString *> *modelArray;

@end

@implementation HorizontalCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //model
    NSMutableArray<NSString *> *tempArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld", i];
        [tempArr addObject:str];
    }
    self.modelArray = [tempArr copy];
    
    //view
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.pickerBtn];
    [self.backgroundView addSubview:self.collectionView];
    
    
}

#pragma mark - event

- (void)pickerBtnDidTapped {
    UIPickerView* pickerView = [[UIPickerView alloc] initWithFrame:self.view.frame];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
}

#pragma mark - getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _backgroundView.center = CGPointMake(self.view.width/2, self.view.height/2);
        _backgroundView.backgroundColor = [UIColor systemPinkColor];
    }
    return _backgroundView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat marginTop = 20;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, marginTop, self.backgroundView.width, self.backgroundView.height - marginTop * 2) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delaysContentTouches = NO;
        _collectionView.clipsToBounds = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        [_collectionView registerClass:[DisplayCell class] forCellWithReuseIdentifier:@"DisplayCell"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.contentOffset = CGPointMake([self getOffsetWithIndex:START_INDEX], 0);
    }
    return _collectionView;
}

- (UIButton *)pickerBtn {
    if (!_pickerBtn) {
        _pickerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [_pickerBtn setTitle:@"选择器" forState:UIControlStateNormal];
        _pickerBtn.backgroundColor = [UIColor redColor];
        [_pickerBtn addTarget:self action:@selector(pickerBtnDidTapped) forControlEvents:UIControlEventTouchUpInside];
        _pickerBtn.center = CGPointMake(self.view.center.x, self.backgroundView.top - 100);
    }
    return _pickerBtn;
}

- (HorizontalCollectionViewLayout *)layout {
    if (!_layout) {
        _layout = [[HorizontalCollectionViewLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = CELL_INSERT;
        _layout.maxItemCount = self.modelArray.count;
        _layout.sectionInset = UIEdgeInsetsMake(0, CELL_INSERT + CELL_EDGE_INSERT, 0, CELL_INSERT + CELL_EDGE_INSERT);
        _layout.currentIndex = START_INDEX;
        _layout.itemWidth = [self cellItemWidth];
    }
    return _layout;
}

#pragma mark - UI相关

- (CGFloat)cellItemWidth {
    return self.collectionView.width - CELL_INSERT * 2 - CELL_EDGE_INSERT * 2;
}

- (CGFloat)getOffsetWithIndex:(NSInteger)index {
    return ([self cellItemWidth] + self.layout.minimumLineSpacing) * index;
}

#pragma mark - collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DisplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DisplayCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRGBHex:0xf5f6fa];
    cell.layer.cornerRadius = 10;
    [cell setText:self.modelArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self cellItemWidth], collectionView.height);
}

#pragma mark - pickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 46;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"test";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"");
}

@end
