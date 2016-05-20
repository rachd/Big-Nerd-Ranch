//
//  RMDContainer.m
//  RandomItems
//
//  Created by Rachel Dorn on 5/17/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDContainer.h"

@implementation RMDContainer

- (instancetype)initWithItems:(NSArray *)items name:(NSString *)name valueInDollars:(int)value {
    self = [super init];
    if (self) {
        self.items = items;
        self.itemName = name;
        self.valueInDollars = value;
        for (RMDItem *item in items) {
            self.valueInDollars += item.valueInDollars;
        }
    }
    return self;
}

- (NSString *)description {
    int cost = 0;
    cost += self.valueInDollars;
    NSMutableString *containedItems = [[NSMutableString alloc] init];
    for (RMDItem *item in self.items) {
        //cost += item.valueInDollars;
        [containedItems appendString:[NSString stringWithFormat:@"%@\n", item]];
    }
    NSString *descriptionString = [[NSMutableString alloc] initWithFormat:@"%@: Worth $%d, contains:\n%@", self.itemName, cost, containedItems];
    return descriptionString;
}
@end
