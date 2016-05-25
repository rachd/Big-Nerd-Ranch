//
//  ViewController.m
//  Hypnosister
//
//  Created by Rachel Dorn on 5/20/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    self.scrollView.delegate = self;
    [self.scrollView setPagingEnabled:NO];
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 2.0;
    
    [self.view addSubview:self.scrollView];
    
    self.hypnosisView = [[RMDHypnosisView alloc] initWithFrame:screenRect];
    [self.scrollView addSubview:self.hypnosisView];
    
//    screenRect.origin.x += screenRect.size.width;
//    RMDHypnosisView *anotherView = [[RMDHypnosisView alloc] initWithFrame:screenRect];
//    [self.scrollView addSubview:anotherView];
    
    self.scrollView.contentSize = screenRect.size;

//    RMDHypnosisView *secondView = [[RMDHypnosisView alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
//    secondView.backgroundColor = [UIColor blueColor];
//    [firstView addSubview:secondView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.hypnosisView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"%f", scale);

}

@end
