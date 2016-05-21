//
//  RMDHypnosisView.m
//  Hypnosister
//
//  Created by Rachel Dorn on 5/20/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDHypnosisView.h"

@implementation RMDHypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path addArcWithCenter:center
//                    radius:radius
//                startAngle:0.0
//                  endAngle:M_PI * 2.0
//                 clockwise:YES];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -=20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    path.lineWidth = 10;
    [[UIColor lightGrayColor] setStroke];
    [path stroke];
    
    CGRect logoBounds = CGRectMake(self.frame.size.width / 4, self.frame.size.height / 4, self.frame.size.width / 2, self.frame.size.height / 2);
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    [logoImage drawInRect:logoBounds];
}

@end
