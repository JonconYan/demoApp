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
    if (!_haveScrollHalfWidth) {
        return _lastContentOffset;
    }
    _haveScrollHalfWidth = NO;
    CGFloat deltaOffset = fabs(proposedContentOffset.x - _lastContentOffset.x);
    if (velocity.x > 0 && _currentIndex < self.maxItemCount - 1 && deltaOffset > self.itemWidth / 2) {
        _currentIndex++;
    } else if (velocity.x < 0 && _currentIndex && deltaOffset > self.itemWidth / 2) {
        _currentIndex--;
    }
    _lastContentOffset = CGPointMake((self.itemWidth + self.minimumLineSpacing) * _currentIndex, proposedContentOffset.y);
    return _lastContentOffset;
}

@end
