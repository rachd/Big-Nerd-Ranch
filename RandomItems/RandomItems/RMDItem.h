//
//  RMDItem.h
//  RandomItems
//
//  Created by Rachel Dorn on 5/17/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RMDItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;
@property (nonatomic, strong) UIImage *thumbnail;


+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber date:(NSDate *)dateCreated;

- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *) sNumber;

- (instancetype)initWithItemName:(NSString *)name;

- (void)setThumbnailFromImage:(UIImage *)image;

@end
