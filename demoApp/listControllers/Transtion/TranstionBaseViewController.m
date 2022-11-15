//
//  TranstionBaseViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/10/28.
//

#import "TranstionBaseViewController.h"

@interface CustomAnimateTransitionPush : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation CustomAnimateTransitionPush

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 获取动画的源控制器和目标控制器
    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = [[UIScreen mainScreen] bounds];
    toVC.view.alpha = 0;
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:.3f animations:^{
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        NSLog(@"Transition complete");
        //不写这句话会导致导航栏控件失效
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end


@interface TranstionBaseViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id<UINavigationControllerDelegate> navOriginDelegate;

@end

@implementation TranstionBaseViewController

- (instancetype)initWithNavgationController:(UINavigationController *)navController {
    self = [super init];
    if (self) {
        self.navOriginDelegate = navController.delegate;
        navController.delegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.delegate = self.navOriginDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"base vc";
    self.view.backgroundColor = [UIColor grayColor];
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        //自定义的动画类
        CustomAnimateTransitionPush *animateTransitionPush = [CustomAnimateTransitionPush new];
        return animateTransitionPush;
    }
    return nil;
}

@end
