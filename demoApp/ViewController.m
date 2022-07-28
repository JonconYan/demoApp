//
//  ViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/7/28.
//

#import "ViewController.h"
#import "UIView+plugin.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demoApp";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height + [self getStatusBarHeight], self.view.width, self.view.height)];
    [self.view addSubview:self.tableView];
}

- (CGFloat)getStatusBarHeight {
    NSSet *set = [[UIApplication sharedApplication] connectedScenes];
    UIWindowScene *windowScene = [set anyObject];
    return windowScene.statusBarManager.statusBarFrame.size.height;
}


@end
