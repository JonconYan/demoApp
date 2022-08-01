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
/// 是否已经滑动完半屏，外部传入，为yes时内部layout在回调时才会计算最终的滑动位置，计算完内部会将此属性置为NO
@property (nonatomic, assign) BOOL haveScrollHalfWidth;

@end
