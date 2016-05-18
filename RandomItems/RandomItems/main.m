//
//  main.m
//  RandomItems
//
//  Created by Rachel Dorn on 5/17/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMDItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
//        for (int i = 0; i < 10; i++) {
//            RMDItem *randomItem = [RMDItem randomItem];
//            [items addObject:randomItem];
//            NSLog(@"%@", randomItem);
//        }
        
        RMDItem *backpack = [[RMDItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        
        RMDItem *calculator = [[RMDItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        backpack = nil;
        calculator = nil;
        
        for (RMDItem *item in items) {
            NSLog(@"%@", item);
        }
        
        NSLog(@"Setting items to nil...");
        items = nil;
    }
    return 0;
}
