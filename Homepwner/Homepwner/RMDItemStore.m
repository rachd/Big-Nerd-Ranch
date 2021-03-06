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
@import CoreData;

@interface RMDItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

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
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open Failure" format:[error localizedDescription]];
        }
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        [self loadAllItems];
    }
    return self;
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (RMDItem *)createItem {
    double order;
    if ([self.allItems count] == 0) {
        order = 1.0;
    } else {
        order = [[self.privateItems lastObject] orderingValue] + 1.0;
    }
    RMDItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"RMDItem" inManagedObjectContext:self.context];
    item.orderingValue = order;
    [self.privateItems addObject:item];
    return item;

}

- (void)removeItem:(RMDItem *)item {
    [[RMDImageStore sharedStore] deleteImageForKey:item.itemKey];
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    RMDItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
    double lowerBound = 0.0;
    if (toIndex > 0) {
        lowerBound = [self.privateItems[(toIndex - 1)] orderingValue];
    } else {
        lowerBound = [self.privateItems[1] orderingValue] - 2.0;
    }
    double upperBound = 0.0;
    if (toIndex < [self.privateItems count] - 1) {
        upperBound = [self.privateItems[(toIndex + 1)] orderingValue];
    } else {
        upperBound = [self.privateItems[(toIndex - 1)] orderingValue] + 2.0;
    }
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    item.orderingValue = newOrderValue;
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges {
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (void)loadAllItems {
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"RMDItem"
                                             inManagedObjectContext:self.context];
        request.entity = e;
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request
                                                      error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSArray *)allAssetTypes {
    if (!_allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"RMDAssetType" inManagedObjectContext:self.context];
        request.entity = e;
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        _allAssetTypes = [result mutableCopy];
        if ([_allAssetTypes count] == 0) {
            NSManagedObject *type;
            type = [NSEntityDescription insertNewObjectForEntityForName:@"RMDAssetType" inManagedObjectContext:self.context];
            [type setValue:@"Furniture" forKey:@"label"];
            [_allAssetTypes addObject:type];
            
            type = [NSEntityDescription insertNewObjectForEntityForName:@"RMDAssetType" inManagedObjectContext:self.context];
            [type setValue:@"Jewelry" forKey:@"label"];
            [_allAssetTypes addObject:type];
            
            type = [NSEntityDescription insertNewObjectForEntityForName:@"RMDAssetType" inManagedObjectContext:self.context];
            [type setValue:@"Electronics" forKey:@"label"];
            [_allAssetTypes addObject:type];
        }
        return _allAssetTypes;
    }
}

@end
