//
//  RMDItem+CoreDataProperties.m
//  Homepwner
//
//  Created by Rachel Dorn on 6/15/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RMDItem+CoreDataProperties.h"

@implementation RMDItem (CoreDataProperties)

@dynamic itemName;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic dateCreated;
@dynamic itemKey;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;

@end
