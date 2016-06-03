//
//  RMDImageStore.h
//  Homepwner
//
//  Created by Rachel Dorn on 6/3/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RMDImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
