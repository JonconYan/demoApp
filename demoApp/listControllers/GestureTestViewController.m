//
//  GestureTestViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/11/15.
//

#import "GestureTestViewController.h"
#import "UIView+Plugin.h"

@interface OperationView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UIRotationGestureRecognizer *rotationGesture;
@property (nonatomic, assign) CGFloat currentScale;
@property (nonatomic, assign) CGFloat currentRotation;
@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation OperationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _currentScale = 1.f;
        _currentRotation = 0.f;
        [self addGestureRecognizer:self.panGesture];
        [self addGestureRecognizer:self.pinchGesture];
        [self addGestureRecognizer:self.rotationGesture];
    }
    return self;
}

- (CGAffineTransform)getUpdateTransform:(CGFloat)scale rotation:(CGFloat)rotation {
    CGAffineTransform pinchTransform = CGAffineTransformMakeScale(scale, scale);
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(rotation);
    return CGAffineTransformConcat(pinchTransform, rotationTransform);
}

#pragma mark - event

- (void)onPanGestureAction:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            _lastFrame = self.frame;
        } break;
        case UIGestureRecognizerStateChanged: {
            CGPoint currentTranslation = [gestureRecognizer translationInView:self.superview];
            self.center = CGPointMake(CGRectGetMidX(_lastFrame) + currentTranslation.x, CGRectGetMidY(_lastFrame) + currentTranslation.y);
            //大坑 注释代码不加上会引发奇怪的bug
//            CGAffineTransform transform = self.transform;
//            self.transform = CGAffineTransformIdentity;
            self.height = self.height;
//            self.transform = transform;
            NSLog(@"set height");
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
        } break;
        default:
            break;
    }
}

- (void)onPinchGestureAction:(UIPinchGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
        } break;
        case UIGestureRecognizerStateChanged: {
            CGFloat factor = .9f;
            _currentScale = (gestureRecognizer.scale - 1.0) * factor + 1.0;
            self.transform = [self getUpdateTransform:_currentScale rotation:_currentRotation];
            NSLog(@"set scale");
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
        }
        default:
            break;
    }
}

- (void)onRotationGestureAction:(UIRotationGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            _currentRotation = 0;
        } break;
        case UIGestureRecognizerStateChanged: {
            _currentRotation = gestureRecognizer.rotation * .2f;
            self.transform = [self getUpdateTransform:_currentScale rotation:_currentRotation];
            NSLog(@"set rotation");
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
        }
        default:
            break;
    }
}

#pragma mark - getter

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGestureAction:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (UIPinchGestureRecognizer *)pinchGesture {
    if (!_pinchGesture) {
        _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinchGestureAction:)];
        _pinchGesture.delegate = self;
    }
    return _pinchGesture;
}

- (UIRotationGestureRecognizer *)rotationGesture {
    if (!_rotationGesture) {
        _rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onRotationGestureAction:)];
        _rotationGesture.delegate = self;
    }
    return _rotationGesture;
}

@end

@interface GestureTestViewController ()

@property (nonatomic, strong) OperationView *demoView;

@end

@implementation GestureTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoView = [[OperationView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:self.demoView];
}

@end
