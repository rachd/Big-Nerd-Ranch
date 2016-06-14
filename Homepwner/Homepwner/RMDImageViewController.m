//
//  RMDImageViewController.m
//  Homepwner
//
//  Created by Rachel Dorn on 6/14/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDImageViewController.h"

@interface RMDImageViewController ()

@end

@implementation RMDImageViewController

- (void)loadView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
