//
//  AJGamesTableViewController.m
//  Scores
//
//  Created by Anca Calugar on 9/18/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGamesTableViewController.h"
#import "AJPlayersViewController.h"

#import "AJTextFieldTableViewCell.h"
#import "AJGameTableViewCell.h"
#import "AJGame+Additions.h"
#import "AJScoresManager.h"

#import "UIBarButtonItem+Additions.h"
#import "NSString+Additions.h"
#import "UIFont+Additions.h"

@interface AJGamesTableViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *games;

@property (nonatomic, strong) UIBarButtonItem *editBarButtonItem;

@property (nonatomic, assign) BOOL showsAddNewGameCell;

@end


@implementation AJGamesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.editBarButtonItem = [UIBarButtonItem clearBarButtonItemWithTitle:@"Edit" target:self action:@selector(editButtonClicked:)];
    self.navigationItem.leftBarButtonItem = self.editBarButtonItem;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem clearBarButtonItemWithTitle:@"+" target:self action:@selector(addButtonClicked:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    [self updateUIAndLoadTableData:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.games count] > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    self.titleViewText = @"Scores";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? self.showsAddNewGameCell : [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GameCell";
    static NSString *NewGameCellIdentifier = @"NewGameCell";
    
    if (indexPath.section == 0) {
        AJTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewGameCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        AJGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setGameDictionary:[(AJGame *)self.games[indexPath.row] toDictionary]];
        
        return cell;
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 1);
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing == UITableViewCellEditingStyleDelete) {
        [self deleteGameFromCellWithIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:self.games];
    AJGame *gameToMove = mutableArray[fromIndexPath.row];
    [mutableArray removeObjectAtIndex:fromIndexPath.row];
    [mutableArray insertObject:gameToMove atIndex:toIndexPath.row];
    [self setGames:mutableArray];
    
    [self updateRowIdsForGames];
    [self updateUIAndLoadTableData:YES];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 1);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Actions

- (IBAction)editButtonClicked:(UIBarButtonItem *)sender {
    if ([[self.editBarButtonItem buttonTitle] isEqualToString:@"Edit"]) {
        [self.tableView setEditing:YES animated:YES];
        self.showsAddNewGameCell = NO;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [self.editBarButtonItem setButtonTitle:@"Done"];
    } else {
        [self.tableView setEditing:NO animated:YES];
        [self.editBarButtonItem setButtonTitle:@"Edit"];
    }

}

- (IBAction)addButtonClicked:(id)sender {
    self.showsAddNewGameCell = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [[(AJTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] textField] becomeFirstResponder];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.showsAddNewGameCell = NO;
    
    NSString *text = textField.text;
    if (![NSString isNilOrEmpty:text]) {
        int maxNo = [self.tableView numberOfRowsInSection:1];
        [[AJScoresManager sharedInstance] addGameWithName:text andRowId:maxNo+1];
        [textField setText:nil];
        
        [self updateUIAndLoadTableData:YES];
    } else {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    textField.text = @"";
    
    return YES;
}

#pragma mark - Overridden from base class

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GamePlayers"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setGame:)]) {
            int rowIndex = [self.tableView indexPathForCell:(AJGameTableViewCell *)sender].row;
            [(AJPlayersViewController *)segue.destinationViewController setGame:self.games[rowIndex]];
        }
    }
}

#pragma mark - Private methods

- (void)updateUIAndLoadTableData:(BOOL)loadData {
    self.games = [[AJScoresManager sharedInstance] getGamesArray];
    if (loadData) {
        [self.tableView reloadData];
    }
}

- (void)updateRowIdsForGames {
    int numberOfGames = [self.games count];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (AJGame *game in self.games) {
        game.rowId = numberOfGames - [self.games indexOfObject:game];
        [mutableArray addObject:game];
    }
    [self setGames:mutableArray];
    
    [[AJScoresManager sharedInstance] saveContext];
}

- (void)deleteGameFromCellWithIndexPath:(NSIndexPath*)indexPath {
    [self.tableView beginUpdates];
    [[AJScoresManager sharedInstance] deleteGame:self.games[indexPath.row]];
    [self updateUIAndLoadTableData:NO];
    [self updateRowIdsForGames];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

@end
