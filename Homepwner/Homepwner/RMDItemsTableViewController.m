//
//  RMDItemsTableViewController.m
//  Homepwner
//
//  Created by Rachel Dorn on 5/24/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "RMDItemsTableViewController.h"
#import "RMDDetailViewController.h"
#import "RMDItemStore.h"
#import "RMDItem.h"
#import "RMDItemCell.h"

@interface RMDItemsTableViewController ()

@end

@implementation RMDItemsTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = addButton;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (IBAction)addNewItem:(id)sender {
    RMDItem *newItem = [[RMDItemStore sharedStore] createItem];
    RMDDetailViewController *detailViewController = [[RMDDetailViewController alloc] initForNewItem:YES];
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"RMDItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RMDItemCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[RMDItemStore sharedStore] allItems] count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        return 44;
    }
    else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMDItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMDItemCell" forIndexPath:indexPath];
     NSArray *items = [[NSArray alloc] init];
    if (indexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        cell.nameLabel.text = @"No more items!";
        return cell;
    } else {
        items = [[RMDItemStore sharedStore] allItems];
    }
    RMDItem *item = items[indexPath.row];
        
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    cell.thumbnailView.image = item.thumbnail;
    [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
    cell.actionBlock = ^{
        NSLog(@"Going to show image");
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [[[RMDItemStore sharedStore] allItems] count]) {
        RMDDetailViewController *detailViewController = [[RMDDetailViewController alloc] initForNewItem:NO];
        NSArray *items = [[RMDItemStore sharedStore] allItems];
        RMDItem *selectedItem = items[indexPath.row];
        detailViewController.item = selectedItem;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[RMDItemStore sharedStore] allItems];
        RMDItem *item = items[indexPath.row];
        [[RMDItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    [[RMDItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"You sure?";
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (proposedDestinationIndexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        return [NSIndexPath indexPathForRow:[[[RMDItemStore sharedStore] allItems] count] - 1 inSection:0];
    } else {
        return proposedDestinationIndexPath;
    }
}

@end
