//
//  RMDHypnosisViewController.m
//  HypnoNerd
//
//  Created by Rachel Dorn on 5/22/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDHypnosisViewController.h"
#import "RMDHypnosisView.h"

@implementation RMDHypnosisViewController

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    RMDHypnosisView *backgroundView = [[RMDHypnosisView alloc] initWithFrame:frame];
    self.view = backgroundView;
}

@end
