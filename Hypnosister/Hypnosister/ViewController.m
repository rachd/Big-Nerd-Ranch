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
    
//    CGRect firstFrame = self.view.bounds;
//    RMDHypnosisView *firstView = [[RMDHypnosisView alloc] initWithFrame:firstFrame];
//    [self.view addSubview:firstView];
    
    CGRect screenRect = self.view.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [scrollView setPagingEnabled:YES];
    [self.view addSubview:scrollView];
    
    RMDHypnosisView *hypnosisView = [[RMDHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView];
    
    screenRect.origin.x += screenRect.size.width;
    RMDHypnosisView *anotherView = [[RMDHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:anotherView];
    
    scrollView.contentSize = bigRect.size;

//    RMDHypnosisView *secondView = [[RMDHypnosisView alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
//    secondView.backgroundColor = [UIColor blueColor];
//    [firstView addSubview:secondView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
