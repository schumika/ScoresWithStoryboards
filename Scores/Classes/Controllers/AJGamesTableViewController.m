//
//  AJGamesTableViewController.m
//  Scores
//
//  Created by Anca Calugar on 9/18/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGamesTableViewController.h"
#import "AJGameTableViewCell.h"
#import "AJGame+Additions.h"
#import "AJScoresManager.h"

@interface AJGamesTableViewController () <UITextFieldDelegate>

@property (nonatomic, assign) BOOL showsAddGameSection;
@property (weak, nonatomic) IBOutlet UITextField *addNewGameTextField;

@end

@implementation AJGamesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.games = [[AJScoresManager sharedInstance] getGamesArray];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameCell";

    AJGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setGameDictionary:[(AJGame *)self.games[indexPath.row] toDictionary]];
    
    return cell;

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Actions

- (IBAction)editButtonClicked:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Edit"]) {
        [self.tableView setEditing:YES animated:YES];
        [sender setTitle:@"Done"];
    } else {
        [self.tableView setEditing:NO animated:YES];
        [sender setTitle:@"Edit"];
    }

}

- (IBAction)addButtonClicked:(id)sender {
    if (!self.showsAddGameSection) {
        self.showsAddGameSection = YES;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self.addNewGameTextField becomeFirstResponder];
    }
}

#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.addNewGameTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.showsAddGameSection = NO;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    textField.text = @"";
    
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
