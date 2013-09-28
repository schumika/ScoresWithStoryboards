//
//  AJPlayersViewController.m
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPlayersViewController.h"

#import "AJTextFieldTableViewCell.h"
#import "AJPlayerTableViewCell.h"
#import "AJScoresManager.h"
#import "AJGame+Additions.h"
#import "AJPlayer+Additions.h"

#import "UIColor+Additions.h"
#import "NSString+Additions.h"
#import "UIBarButtonItem+Additions.h"

@interface AJPlayersViewController ()
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, assign) BOOL showsAddNewPlayerCell;
@end

@implementation AJPlayersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem clearBarButtonItemWithTitle:@"+" target:self action:@selector(addButtonClicked:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
    static NSString *NewGameCellIdentifier = @"NewPlayerCell";
    
    if (indexPath.section == 0) {
        AJTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewGameCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        AJPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setPlayerDictionary:[(AJPlayer *)self.players[indexPath.row] toDictionary]];
        
        return cell;
    }
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
    [[(AJTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] textField] becomeFirstResponder];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
