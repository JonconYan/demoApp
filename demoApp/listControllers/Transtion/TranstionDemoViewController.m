//
//  TranstionDemoViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/10/28.
//

#import "TranstionDemoViewController.h"
#import "TranstionBaseViewController.h"

@interface TranstionDemoViewController ()

@property (nonatomic, strong) UIButton *clickBtn;

@end

@implementation TranstionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画demo";
    [self.view addSubview:self.clickBtn];
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

#pragma mark - event
- (void)clickDidTapped {
    TranstionBaseViewController *vc = [[TranstionBaseViewController alloc] initWithNavgationController:self.navigationController];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
