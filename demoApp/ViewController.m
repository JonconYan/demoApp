//
//  ViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/7/28.
//

#import "ViewController.h"
#import "UIView+Plugin.h"
#import "HorizontalCollectionViewController.h"
#import "PromiseViewController.h"
#import "demoApp-swift.h"
#import "TranstionDemoViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demoApp";
    [self.view addSubview:self.tableView];
}

- (CGFloat)getBarHeight {
    NSSet *set = [[UIApplication sharedApplication] connectedScenes];
    UIWindowScene *windowScene = [set anyObject];
    return windowScene.statusBarManager.statusBarFrame.size.height + self.navigationController.navigationBar.height;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self getBarHeight], self.view.width, self.view.height)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSDictionary *)dict {
    if (!_dict) {
        _dict = @{
            @"横向collectionView" : [HorizontalCollectionViewController class],
            @"Promise测试" : [PromiseViewController class],
            @"swift页面" : [SwiftVC class],
            @"转场demo" : [TranstionDemoViewController class]
        };
    }
    return _dict;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dict.allKeys[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.dict.allKeys[indexPath.row];
    Class cls = self.dict[key];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([cls isSubclassOfClass:[UIViewController class]]) {
        UIViewController *vc = [[cls alloc] init];
        vc.title = key;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
