//
//  RMDItemStore.m
//  Homepwner
//
//  Created by Rachel Dorn on 5/26/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDItemStore.h"
#import "RMDItem.h"

@interface RMDItemStore ()

@property (nonatomic)NSMutableArray *privateItems;

@end

@implementation RMDItemStore

+ (instancetype)sharedStore {
    static RMDItemStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    [NSException raise:@"Singleton" format:@"Use +[RMDItemStore sharedStore"];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.privateItems = [[NSMutableArray alloc] init];
        self.expensiveItems = [[NSMutableArray alloc] init];
        self.cheapItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (RMDItem *)createItem {
    RMDItem *item = [RMDItem randomItem];
    [self.privateItems addObject:item];
    if (item.valueInDollars >= 50) {
        [self.expensiveItems addObject:item];
    } else {
        [self.cheapItems addObject:item];
    }
    return item;
}

@end
