//
//  RMDDrawView.m
//  TouchTracker
//
//  Created by Rachel Dorn on 6/7/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDDrawView.h"
#import "RMDLine.h"

@interface RMDDrawView ()

@property (nonatomic, strong) RMDLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation RMDDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)strokeLine:(RMDLine *)line {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 10;
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    [bezierPath moveToPoint:line.begin];
    [bezierPath addLineToPoint:line.end];
    [bezierPath stroke];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (RMDLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    if (self.currentLine) {
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}

@end
