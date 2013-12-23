//
//  AJPlayersViewController.m
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPlayersViewController.h"

#import "AJScoresViewController.h"
#import "AJTextFieldTableViewCell.h"
#import "AJSettingsViewController.h"
#import "AJPlayerTableViewCell.h"
#import "AJScoresManager.h"
#import "AJGame+Additions.h"
#import "AJPlayer+Additions.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"
#import "UIButton+Additions.h"
#import "NSString+Additions.h"
#import "UIBarButtonItem+Additions.h"

@interface AJPlayersViewController ()
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, assign) BOOL showsAddNewPlayerCell;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (nonatomic, strong) NSIndexPath *indexPathOfSelectedCell;

- (void)deletePlayerFromCellWithIndexPath:(NSIndexPath*)indexPath;
@end

@implementation AJPlayersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem clearBarButtonItemWithTitle:@"+" target:self action:@selector(addButtonClicked:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = NO;
    
    [self.settingsBarButtonItem setCustomView:[UIButton clearButtonWithTitle:@"Settings" target:self.settingsBarButtonItem.target action:self.settingsBarButtonItem.action]];
    
    [self updateUIAndLoadTableData:YES];
}

#pragma mark - Private methods

- (void)updateUIAndLoadTableData:(BOOL)loadData {
    self.players = self.game.orderedPlayersArray;
    self.titleViewText = self.game.name;
    self.titleViewColor = [UIColor colorWithHexString:self.game.color];
    
    if (loadData) {
        if (self.tableView.hidden == NO) {
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? self.showsAddNewPlayerCell : [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PlayerCell";
    static NSString *NewPlayerCellIdentifier = @"NewPlayerCell";
    
    if (indexPath.section == 0) {
        AJTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewPlayerCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        AJPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setPlayerDictionary:[(AJPlayer *)self.players[indexPath.row] toDictionary]];
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 1);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing == UITableViewCellEditingStyleDelete) {
        [self deletePlayerFromCellWithIndexPath:indexPath];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [self doneAddingScoreButtonClicked:nil];
        self.indexPathOfSelectedCell = nil;
        [textField resignFirstResponder];
        
        return YES;
    } else {
        self.showsAddNewPlayerCell = NO;
        
        NSString *text = textField.text;
        if (![NSString isNilOrEmpty:text]) {
            [[AJScoresManager sharedInstance] createPlayerWithName:text forGame:self.game];
            [textField setText:nil];
            
            [self updateUIAndLoadTableData:YES];
        } else {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        textField.text = @"";
        
        return YES;
        }
}

#pragma mark - Actions

- (IBAction)addButtonClicked:(id)sender {
    self.showsAddNewPlayerCell = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    AJTextFieldTableViewCell *cell = (AJTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textField] becomeFirstResponder];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (IBAction)doneAddingScoreButtonClicked:(UIButton *)sender {
    AJPlayerTableViewCell *selectedCell = (AJPlayerTableViewCell *)[self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedCell];
    
    NSString *text = [selectedCell textInAddScoreTextfield];
    if (![NSString isNilOrEmpty:text]) {
        AJPlayer *selectedPlayer = self.players[self.indexPathOfSelectedCell.row];
        [[AJScoresManager sharedInstance] createScoreWithValue:text.doubleValue inRound:([selectedPlayer.scores count]+1) forPlayer:selectedPlayer];
        [self updateUIAndLoadTableData:YES];
    } else {
        [self.tableView reloadRowsAtIndexPaths:@[self.indexPathOfSelectedCell] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [selectedCell flipTotalViewAnimated:YES];
    [selectedCell endEditing:YES];
    self.indexPathOfSelectedCell = nil;
}

#pragma mark - Overridden from base class

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayerScores"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setPlayer:)]) {
            int rowIndex = [self.tableView indexPathForCell:(AJPlayerTableViewCell *)sender].row;
            [(AJScoresViewController *)segue.destinationViewController setPlayer:self.players[rowIndex]];
        }
    } else if ([segue.identifier isEqualToString:@"GameSettings"]) {
        UIViewController *topViewController = [(UINavigationController *)segue.destinationViewController topViewController];
        if ([topViewController respondsToSelector:@selector(setItemDictionary:)]) {
            [(AJSettingsViewController *)topViewController setItemDictionary:self.game.toDictionary];
            [(AJSettingsViewController *)topViewController setDelegate:self];
        }
    }
}

#pragma mark - Private methods

- (void)deletePlayerFromCellWithIndexPath:(NSIndexPath*)indexPath {
    [self.tableView beginUpdates];
    [[AJScoresManager sharedInstance] deletePlayer:self.players[indexPath.row]];
    [self updateUIAndLoadTableData:NO];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark - AJSettingsViewControllerDelegate methods

- (void)settingsViewControllerDidCancelEditing:(AJSettingsViewController *)settingsViewController {
    
}

- (void)settingsViewController:(AJSettingsViewController *)settingsViewController didFinishEditingItemDictionary:(NSDictionary *)dictionary {
    [self.game setGamePropertiesFromDictionary:dictionary];
    [self updateUIAndLoadTableData:NO];
    [[AJScoresManager sharedInstance] saveContext];
}

#pragma mark - UITapGestureRecognizer methods

- (IBAction)tapGestureHandler:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint p = [sender locationInView:self.tableView];
        
        if (self.indexPathOfSelectedCell != nil) {
            [(AJPlayerTableViewCell *)[self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedCell] flipTotalViewAnimated:YES];
        }
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            NSLog(@"double tap on table view but not on a row");
        } else {
            NSLog(@"double tap on table view at row %d", indexPath.row);
            
            AJPlayerTableViewCell *playerCell = (AJPlayerTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [playerCell flipTotalViewAnimated:YES];
        }
        
        self.indexPathOfSelectedCell = indexPath;
        
    }
}

@end
