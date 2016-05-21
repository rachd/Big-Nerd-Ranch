//
//  ViewController.m
//  Hypnosister
//
//  Created by Rachel Dorn on 5/20/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "ViewController.h"
#import "RMDHypnosisView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect firstFrame = self.view.bounds;
    RMDHypnosisView *firstView = [[RMDHypnosisView alloc] initWithFrame:firstFrame];
    [self.view addSubview:firstView];
    
//    RMDHypnosisView *secondView = [[RMDHypnosisView alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
//    secondView.backgroundColor = [UIColor blueColor];
//    [firstView addSubview:secondView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
