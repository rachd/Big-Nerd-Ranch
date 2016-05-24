//
//  RMDHypnosisView.m
//  Hypnosister
//
//  Created by Rachel Dorn on 5/20/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDHypnosisView.h"

@interface RMDHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property float red;
@property float green;
@property float blue;

@end

@implementation RMDHypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.red = 0.0;
        self.green = 0.0;
        self.blue = 0.0;
        self.circleColor = [UIColor lightGrayColor];
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
    [self.circleColor setStroke];
    [path stroke];
    
    //set triangle clipping path
    CGContextRef newContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(newContext);
    
    CGPoint startPoint = CGPointMake(bounds.size.width / 2, bounds.size.height / 5);
    CGPoint secondPoint = CGPointMake(bounds.size.width - bounds.size.width / 5, bounds.size.height - bounds.size.height / 5);
    CGPoint endPoint = CGPointMake(bounds.size.width / 5, bounds.size.height - bounds.size.height / 5);
    
    UIBezierPath *triangle = [[UIBezierPath alloc] init];
    [triangle moveToPoint:startPoint];
    [triangle addLineToPoint:secondPoint];
    [triangle addLineToPoint:endPoint];
    [triangle addLineToPoint:startPoint];
    triangle.lineWidth = 10;
    [[UIColor yellowColor] setStroke];
    [triangle addClip];
    
    //add gradient
    CGFloat components[8] = { 0.0, 1.0, 0.0, 1.0,
                              1.0, 1.0, 0.0, 1.0 };
    CGFloat locations[2] = { 0.0, 1.0 };
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGContextDrawLinearGradient(newContext, gradient, startPoint, CGPointMake(bounds.size.width / 2, bounds.size.height - bounds.size.height / 5), 0);
    
    CGContextRestoreGState(newContext);
    
    //drop shadow
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    
    //add logo
    CGRect logoBounds = CGRectMake(self.frame.size.width / 4, self.frame.size.height / 4, self.frame.size.width / 2, self.frame.size.height / 2);
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    [logoImage drawInRect:logoBounds];
    
    CGContextRestoreGState(currentContext);
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Red", @"Green", @"Blue"]];
    self.segmentedControl.tintColor = [UIColor blackColor];
    self.segmentedControl.frame = CGRectMake(0, self.frame.size.height - self.frame.size.height / 5 + 30, self.frame.size.width, 50);
    self.segmentedControl.momentary = YES;
    self.segmentedControl.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.segmentedControl addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentedControl];

}

- (void)changeColor:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.red = (arc4random() % 100) / 100.0;
            break;
        case 1:
            self.green = (arc4random() % 100) / 100.0;
            break;
        case 2:
            self.blue = (arc4random() % 100) / 100.0;
            break;
        default:
            break;
    }
    UIColor *newColor = [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:1.0];
    self.circleColor = newColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
