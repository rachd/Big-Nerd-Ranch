//
//  RMDDatePickerViewController.m
//  Homepwner
//
//  Created by Rachel Dorn on 6/6/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDDatePickerViewController.h"

@interface RMDDatePickerViewController ()

@property (nonatomic, strong) RMDItem *item;

@end

@implementation RMDDatePickerViewController

- (instancetype)initWithItem:(RMDItem *)item {
    self = [super init];
    if (self) {
        _item = item;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:[self.view bounds]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateItem:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
}

- (void)updateItem:(UIDatePicker *)datePicker {
    self.item.dateCreated = datePicker.date;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
