//
//  RMDHypnosisViewController.m
//  HypnoNerd
//
//  Created by Rachel Dorn on 5/22/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDHypnosisViewController.h"
#import "RMDHypnosisView.h"

@interface RMDHypnosisViewController () <UITextFieldDelegate>

@end

@implementation RMDHypnosisViewController

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
    }
    return self;
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    RMDHypnosisView *backgroundView = [[RMDHypnosisView alloc] initWithFrame:frame];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 70, 240, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [backgroundView addSubview:textField];
    
    self.view = backgroundView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message {
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];
        
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
    }
}

@end
