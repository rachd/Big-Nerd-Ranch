//
//  RMDLine.m
//  TouchTracker
//
//  Created by Rachel Dorn on 6/7/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDLine.h"

@implementation RMDLine

- (CGFloat)calculateAngleFromStart:(CGPoint)start andEnd:(CGPoint)end {
    CGFloat xDifference = end.x - start.x;
    CGFloat yDifference = end.y - start.y;
    
    CGFloat slope = yDifference / xDifference;
    CGFloat angle = atanf(slope);
    
    return angle;
}

@end
