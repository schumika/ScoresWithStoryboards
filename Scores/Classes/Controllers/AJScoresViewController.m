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

#import "UIColor+Additions.h"

@interface AJScoresViewController ()
@property (nonatomic, strong) NSArray *scores;
@property (nonatomic, assign) BOOL showsAddNewScoreCell;
@end

@implementation AJScoresViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = NO;
    [self loadDataAndUpdateUI:YES];
}

#pragma mark - Private methods

- (void)loadDataAndUpdateUI:(BOOL)updateUI {
    self.scores = [[AJScoresManager sharedInstance] getAllScoresForPlayer:self.player];
    self.titleViewText = self.player.name;
    self.titleViewColor = [UIColor colorWithHexString:self.player.color];
    
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
    return (section == 0) ? self.showsAddNewScoreCell: [self.scores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PlayerCell";
    static NSString *NewGameCellIdentifier = @"NewPlayerCell";
    
    if (indexPath.section == 0) {
        AJTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewGameCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        AJScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        //[cell setScoreDictionary:[(AJPlayer *)self.scores[indexPath.row] toDictionary]];
        
        return cell;
    }
}


@end
