//
//  HorizontalCollectionViewLayout.m
//  demoApp
//
//  Created by xiaokangyan on 2022/8/1.
//

#import "HorizontalCollectionViewLayout.h"
#import "UIView+Plugin.h"

@interface HorizontalCollectionViewLayout ()

@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation HorizontalCollectionViewLayout


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat deltaOffset = self.collectionView.contentOffset.x - _lastContentOffset.x;
    //平滑滑动不到一半则直接返回 velocity的x为0时表示平滑滑动
    if (fabs(deltaOffset) < self.itemWidth / 2 && !velocity.x) {
        return _lastContentOffset;
    }
    if ((deltaOffset > 0 || velocity.x > 0) && _currentIndex < self.maxItemCount - 1) {
        _currentIndex++;
    } else if ((deltaOffset < 0 || velocity.x < 0) && _currentIndex) {
        _currentIndex--;
    }
    _lastContentOffset = CGPointMake((self.itemWidth + self.minimumLineSpacing) * _currentIndex, proposedContentOffset.y);
    return _lastContentOffset;
}

@end
