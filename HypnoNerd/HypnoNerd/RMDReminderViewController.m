//
//  RMDReminderViewController.m
//  HypnoNerd
//
//  Created by Rachel Dorn on 5/22/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDReminderViewController.h"

@interface RMDReminderViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *reminderButton;

@end

@implementation RMDReminderViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Reminder";
        UIImage *image = [UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 8, self.view.frame.size.width, self.view.frame.size.height / 2)];
    [self.view addSubview:self.datePicker];
    
    self.reminderButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height * 3 / 4, self.view.frame.size.width - 20, 30)];
    self.reminderButton.backgroundColor = [UIColor greenColor];
    [self.reminderButton setTitle:@"Remind Me!" forState:UIControlStateNormal];
    [self.reminderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.reminderButton.layer.cornerRadius = 6;
    [self.reminderButton addTarget:self
                            action:@selector(addReminder:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reminderButton];
}

- (void)addReminder:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

@end
