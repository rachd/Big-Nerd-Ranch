//
//  RMDContainer.h
//  RandomItems
//
//  Created by Rachel Dorn on 5/17/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDItem.h"

@interface RMDContainer : RMDItem

@property NSArray* items;

- (instancetype)initWithItems:(NSArray *)items name:(NSString *)name valueInDollars:(int)value;

@end
