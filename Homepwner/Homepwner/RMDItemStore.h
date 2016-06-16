//
//  RMDItemStore.h
//  Homepwner
//
//  Created by Rachel Dorn on 5/26/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMDItem;

@interface RMDItemStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;
@property (nonatomic, strong) NSMutableArray *expensiveItems;
@property (nonatomic, strong) NSMutableArray *cheapItems;

+ (instancetype)sharedStore;
- (RMDItem *)createItem;
- (void)removeItem:(RMDItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
- (NSArray *)allAssetTypes;

@end
