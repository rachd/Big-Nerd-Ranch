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
        
        for (int i = 0; i < 10; i++) {
            RMDItem *randomItem = [RMDItem randomItem];
            [items addObject:randomItem];
            NSLog(@"%@", randomItem);
        }
        
        items = nil;
    }
    return 0;
}
