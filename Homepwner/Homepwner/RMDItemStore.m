//
//  RMDItemStore.m
//  Homepwner
//
//  Created by Rachel Dorn on 5/26/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDItemStore.h"
#import "RMDItem.h"
#import "RMDImageStore.h"

@interface RMDItemStore ()

@property (nonatomic)NSMutableArray *privateItems;

@end

@implementation RMDItemStore

+ (instancetype)sharedStore {
    static RMDItemStore *sharedStore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
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

- (void)removeItem:(RMDItem *)item {
    [[RMDImageStore sharedStore] deleteImageForKey:item.itemKey];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    RMDItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
