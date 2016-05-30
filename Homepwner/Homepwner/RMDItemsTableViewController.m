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

@interface RMDItemsTableViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation RMDItemsTableViewController

- (UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

- (IBAction)addNewItem:(id)sender {
    RMDItem *newItem = [[RMDItemStore sharedStore] createItem];
    NSInteger lastRow = [[[RMDItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender {
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[RMDItemStore sharedStore] allItems] count] + 1;
    //    switch (section) {
//        case 0:
//            return [[[RMDItemStore sharedStore] expensiveItems] count] + 1;
//            break;
//        case 1:
//            return [[[RMDItemStore sharedStore] cheapItems] count] + 1;
//            break;
//        default:
//            return 0;
//            break;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == [[[RMDItemStore sharedStore] expensiveItems] count]) {
//        return 44;
//    }
//    
//    else if (indexPath.section == 1 && indexPath.row == [[[RMDItemStore sharedStore] cheapItems] count]) {
//        return 44;
//    }
//                                                         
    if (indexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        return 44;
    }
    else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
     NSArray *items = [[NSArray alloc] init];
//    if (indexPath.section == 0) {
//        if (indexPath.row == [[[RMDItemStore sharedStore] expensiveItems] count]) {
//            cell.textLabel.text = @"No more items!";
//            return cell;
//        } else {
//            items = [[RMDItemStore sharedStore] expensiveItems];
//        }
//    }
//    else if (indexPath.section == 1) {
//        if (indexPath.row == [[[RMDItemStore sharedStore] cheapItems] count]) {
//            cell.textLabel.text = @"No more items!";
//            return cell;
//        } else {
//            items = [[RMDItemStore sharedStore] cheapItems];
//        }
//    }
    if (indexPath.row == [[[RMDItemStore sharedStore] allItems] count]) {
        cell.textLabel.text = @"No more items!";
        return cell;
    } else {
        items = [[RMDItemStore sharedStore] allItems];
    }
    RMDItem *item = items[indexPath.row];
        
    cell.textLabel.text = [item description];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [[[RMDItemStore sharedStore] allItems] count]) {
        RMDDetailViewController *detailViewController = [[RMDDetailViewController alloc] init];
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
