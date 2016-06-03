//
//  RMDImageStore.m
//  Homepwner
//
//  Created by Rachel Dorn on 6/3/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDImageStore.h"

@interface RMDImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation RMDImageStore

+ (instancetype)sharedStore {
    static RMDImageStore *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    [NSException raise:@"Singleton" format:@"Use +[RMDImageStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key {
    [self.dictionary removeObjectForKey:key];
}

@end
