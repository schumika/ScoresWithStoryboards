//
//  AJScoresViewController.m
//  Scores
//
//  Created by Anca Calugar on 10/3/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJScoresViewController.h"

#import "AJPlayer+Additions.h"
#import "AJScore+Additions.h"

#import "AJScoresManager.h"
#import "AJTextFieldTableViewCell.h"
#import "AJScoreTableViewCell.h"
#import "AJSettingsViewController.h"

#import "UIColor+Additions.h"
#import "UIBarButtonItem+Additions.h"
#import "NSString+Additions.h"
#import "UIButton+Additions.h"

@interface AJScoresViewController () <UITextFieldDelegate, AJSettingsViewControllerDelegate>
@property (nonatomic, strong) NSArray *scores;
@property (nonatomic, assign) BOOL showsAddNewScoreCell;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (nonatomic, strong) NSIndexPath *indexPathOfSelectedCell;
@end

@implementation AJScoresViewController 

- (void)viewDidLoad {
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
    self.scores = [self.player orderedScoresArray];
    self.titleViewText = self.player.name;
    self.titleViewColor = [UIColor colorWithHexString:self.player.color];
    
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
    return (section == 0) ? self.showsAddNewScoreCell: [self.scores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ScoreCell";
    static NSString *NewScoreCellIdentifier = @"NewScoreCell";
    
    if (indexPath.section == 0) {
        AJTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewScoreCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        AJScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setScoreDictionary:[(AJScore *)self.scores[indexPath.row] toDictionary]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.indexPathOfSelectedCell != nil) {
        [(AJScoreTableViewCell *)[self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedCell] flipTotalViewAnimated:YES];
    }
    
    [(AJScoreTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] flipTotalViewAnimated:YES];
    self.indexPathOfSelectedCell = indexPath;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 1);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing == UITableViewCellEditingStyleDelete) {
        [self deleteScoreFromCellWithIndexPath:indexPath];
    }
}

#pragma mark - Actions

- (IBAction)addButtonClicked:(id)sender {
    self.showsAddNewScoreCell = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    AJTextFieldTableViewCell *cell = (AJTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textField] becomeFirstResponder];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        double enteredValue = [textField.text doubleValue];
        AJScore *currentScore = self.scores[self.indexPathOfSelectedCell.row];
        if (enteredValue != currentScore.value) {
            currentScore.value = enteredValue;
            [[AJScoresManager sharedInstance] saveContext];
            [self updateUIAndLoadTableData:YES];
        }
        
        [(AJScoreTableViewCell *)[self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedCell] flipTotalViewAnimated:YES];
        self.indexPathOfSelectedCell = nil;
        [textField resignFirstResponder];
        
        return YES;
    } else {
        self.showsAddNewScoreCell = NO;
        
        NSString *text = textField.text;
        if (![NSString isNilOrEmpty:text]) {
            [[AJScoresManager sharedInstance] createScoreWithValue:textField.text.doubleValue inRound:([self.tableView numberOfRowsInSection:1]+1) forPlayer:self.player];
            [textField setText:nil];
            
            [self updateUIAndLoadTableData:YES];
        } else {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        textField.text = @"";
        
        return YES;
    }
}

#pragma mark - Overridden from base class

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayerSettings"]) {
        UIViewController *topViewController = [(UINavigationController *)segue.destinationViewController topViewController];
        if ([topViewController respondsToSelector:@selector(setItemDictionary:)]) {
            [(AJSettingsViewController *)topViewController setItemDictionary:self.player.toDictionary];
            [(AJSettingsViewController *)topViewController setDelegate:self];
        }
    }
}

#pragma mark - AJSettingsViewControllerDelegate methods

- (void)settingsViewControllerDidCancelEditing:(AJSettingsViewController *)settingsViewController {
    
}

- (void)settingsViewController:(AJSettingsViewController *)settingsViewController didFinishEditingItemDictionary:(NSDictionary *)dictionary {
    [self.player setPlayerPropertiesFromDictionary:dictionary];
    [self updateUIAndLoadTableData:NO];
    [[AJScoresManager sharedInstance] saveContext];
}

#pragma mark - Private methods

- (void)deleteScoreFromCellWithIndexPath:(NSIndexPath*)indexPath {
    [self.tableView beginUpdates];
    [[AJScoresManager sharedInstance] deleteScore:self.scores[indexPath.row]];
    [self updateUIAndLoadTableData:NO];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    
    [self.player updateRoundsForScores];
    
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}


@end
