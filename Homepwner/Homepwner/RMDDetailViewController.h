//
//  RMDDetailViewController.h
//  Homepwner
//
//  Created by Rachel Dorn on 5/30/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMDItem;

@interface RMDDetailViewController : UIViewController

@property (nonatomic, strong) RMDItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
