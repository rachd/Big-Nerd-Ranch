//
//  RMDItem.h
//  Homepwner
//
//  Created by Rachel Dorn on 6/15/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RMDItem : NSManagedObject

- (void)setThumbnailFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

#import "RMDItem+CoreDataProperties.h"
