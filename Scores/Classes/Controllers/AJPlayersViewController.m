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
    
    [self.settingsBarButtonItem setCustomView:[UIButton clearButtonItemWithTitle:@"Settings" target:self.settingsBarButtonItem.target action:self.settingsBarButtonItem.action]];
    
    [self loadDataAndUpdateUI:YES];
}

#pragma mark - Private methods

- (void)loadDataAndUpdateUI:(BOOL)updateUI {
    self.players = self.game.orderedPlayersArray;
    self.titleViewText = self.game.name;
    self.titleViewColor = [UIColor colorWithHexString:self.game.color];
    
    if (updateUI) {
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
    self.showsAddNewPlayerCell = NO;
    
    NSString *text = textField.text;
    if (![NSString isNilOrEmpty:text]) {
        [[AJScoresManager sharedInstance] createPlayerWithName:text forGame:self.game];
        [textField setText:nil];
        
        [self loadDataAndUpdateUI:YES];
    } else {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    textField.text = @"";
    
    return YES;
}

#pragma mark - Actions

- (IBAction)addButtonClicked:(id)sender {
    self.showsAddNewPlayerCell = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    AJTextFieldTableViewCell *cell = (AJTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textField] becomeFirstResponder];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


#pragma mark - Overridden from base class

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayerScores"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setPlayer:)]) {
            int rowIndex = [self.tableView indexPathForCell:(AJPlayerTableViewCell *)sender].row;
            [(AJScoresViewController *)segue.destinationViewController setPlayer:self.players[rowIndex]];
        }
    } else if ([segue.identifier isEqualToString:@"GameSettings"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setItemDictionary:)]) {
            [(AJSettingsViewController *)segue.destinationViewController setItemDictionary:self.game.toDictionary];
            [(AJSettingsViewController *)segue.destinationViewController setDelegate:self];
        }
    }
}

#pragma mark - Private methods

- (void)deletePlayerFromCellWithIndexPath:(NSIndexPath*)indexPath {
    [self.tableView beginUpdates];
    [[AJScoresManager sharedInstance] deletePlayer:self.players[indexPath.row]];
    [self loadDataAndUpdateUI:NO];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark - AJSettingsViewControllerDelegate methods

- (void)settingsViewControllerDidCancelEditing:(AJSettingsViewController *)settingsViewController {
    
}

- (void)settingsViewController:(AJSettingsViewController *)settingsViewController didFinishEditingItemDictionary:(NSDictionary *)dictionary {
    [self.game saveGamePropertiesFromDictionary:dictionary];
}

@end
