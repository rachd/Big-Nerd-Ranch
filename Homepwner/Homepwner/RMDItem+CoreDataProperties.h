//
//  RMDItem+CoreDataProperties.h
//  Homepwner
//
//  Created by Rachel Dorn on 6/15/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RMDItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RMDItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *itemName;
@property (nullable, nonatomic, retain) NSString *serialNumber;
@property (nullable, nonatomic, retain) int *valueInDollars;
@property (nullable, nonatomic, retain) NSDate *dateCreated;
@property (nullable, nonatomic, retain) NSString *itemKey;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nullable, nonatomic, retain) double *orderingValue;
@property (nullable, nonatomic, retain) NSManagedObject *assetType;

@end

NS_ASSUME_NONNULL_END
