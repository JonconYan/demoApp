//
//  TranstionDemoViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/10/28.
//

#import "TranstionDemoViewController.h"
#import "TranstionBaseViewController.h"
#import "UIView+Plugin.h"

@interface TestTapGestureBaseView : UIView

@end

@implementation TestTapGestureBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapped)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)viewDidTapped {
    NSLog(@"tap base view");
}

@end

@interface TestTapGestureSonView : TestTapGestureBaseView

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TestTapGestureSonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sonViewDidTapped)];
        [self addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:self.btn];
    }
    return self;
}

- (void)sonViewDidTapped {
    NSLog(@"tap son view");
}

- (void)btnDidTapped {
    NSLog(@"tap btn view");
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width / 2, self.height / 2)];
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn addTarget:self action:@selector(btnDidTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end

@interface MySlider : UISlider

@end

@implementation MySlider

//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
//    CGFloat centerX = value / self.maximumValue * rect.size.width;
//    return CGRectMake(centerX ,rect.origin.y - bounds.size.height / 2, bounds.size.width, bounds.size.height);
//}

@end


@interface TranstionDemoViewController ()

@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) TestTapGestureSonView *testView;
@property (nonatomic, strong) MySlider *slider;

@end

@implementation TranstionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画demo";
    [self.view addSubview:self.clickBtn];
    [self.view addSubview:self.testView];
    [self.view addSubview:self.slider];
}

- (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize
{
    NSAssert(!CGSizeEqualToSize(imageSize, CGSizeZero), @"imageSize is zero for method imageWithColor: imageSize:");
    
    if (color == nil) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - getter

- (UIButton *)clickBtn {
    if (!_clickBtn) {
        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 50, 50)];
        _clickBtn.backgroundColor = [UIColor blueColor];
        [_clickBtn addTarget:self action:@selector(clickDidTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[MySlider alloc] initWithFrame:CGRectMake(40, 600, 50, 10)];
        _slider.maximumTrackTintColor = [UIColor redColor];
        _slider.minimumTrackTintColor = [UIColor greenColor];
        [_slider setThumbImage:[self imageWithColor:[UIColor greenColor] imageSize:CGSizeMake(0.1f, 1.f)] forState:UIControlStateNormal];
        _slider.value = 0.2f;
    }
    return _slider;
}

- (TestTapGestureSonView *)testView {
    if (!_testView) {
        _testView = [[TestTapGestureSonView alloc] initWithFrame:CGRectMake(40, 300, 50, 50)];
    }
    return _testView;
}

#pragma mark - event
- (void)clickDidTapped {
    TranstionBaseViewController *vc = [[TranstionBaseViewController alloc] initWithNavgationController:self.navigationController];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
