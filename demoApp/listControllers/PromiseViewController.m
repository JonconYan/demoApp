//
//  PromiseViewController.m
//  demoApp
//
//  Created by xiaokangyan on 2022/8/25.
//

#import "PromiseViewController.h"
#import <PromisesObjC/FBLPromises.h>

@interface PromiseViewController ()

@property (nonatomic, strong) FBLPromise *promise;

@end

@implementation PromiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[[self test1] then:^id _Nullable(id  _Nullable value) {
        NSLog(@"test");
        return @1;
    }] then:^id _Nullable(id  _Nullable value) {
        NSLog(@"test1");
        return @1;
    }];
}

- (FBLPromise *)test1 {
    NSLog(@"test1");
    self.promise = [FBLPromise pendingPromise];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self test2];
    });
    return self.promise;
}

- (void)test2 {
    NSLog(@"test2");
    [self.promise fulfill:@(1)];
}

@end
