//
//  HorizontalCollectionViewLayout.m
//  demoApp
//
//  Created by xiaokangyan on 2022/8/1.
//

#import "HorizontalCollectionViewLayout.h"
#import "UIView+plugin.h"

@interface HorizontalCollectionViewLayout ()

@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation HorizontalCollectionViewLayout


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    if (proposedContentOffset.x - _lastContentOffset.x > 0 && _currentIndex < self.maxItemCount - 1) {
        _currentIndex++;
    } else if (proposedContentOffset.x - _lastContentOffset.x < 0 && _currentIndex) {
        _currentIndex--;
    }
    _lastContentOffset = CGPointMake((self.itemWidth + self.minimumLineSpacing) * _currentIndex, proposedContentOffset.y);
    return _lastContentOffset;
}

@end
