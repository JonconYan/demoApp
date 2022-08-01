//
//  HorizontalCollectionViewLayout.h
//  demoApp
//
//  Created by xiaokangyan on 2022/8/1.
//

#import <UIKit/UIKit.h>

///横向滑动collectionView布局
@interface HorizontalCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) NSInteger maxItemCount;

@end
