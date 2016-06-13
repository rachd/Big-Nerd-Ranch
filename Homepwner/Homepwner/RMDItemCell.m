//
//  RMDItemCell.m
//  Homepwner
//
//  Created by Rachel Dorn on 6/12/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDItemCell.h"

@implementation RMDItemCell

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
