//
//  main.m
//  RandomItems
//
//  Created by Rachel Dorn on 5/17/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMDItem.h"
#import "RMDContainer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 3; i++) {
            RMDItem *randomItem = [RMDItem randomItem];
            [items addObject:randomItem];
            //NSLog(@"%@", randomItem);
        }
        
        RMDItem *backpack = [[RMDItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        
        RMDItem *calculator = [[RMDItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        RMDContainer *container = [[RMDContainer alloc] initWithItems:items name:@"Container" valueInDollars:50];
        
        RMDContainer *biggerContainer = [[RMDContainer alloc] initWithItems:@[backpack, container] name:@"Big" valueInDollars:10];
        
        NSLog(@"%@", biggerContainer);
        
//        NSLog(@"Setting items to nil...");
//        items = nil;
    }
    return 0;
}
