//
//  AJPlayersViewController.h
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJTableViewController.h"
#import "AJSettingsViewController.h"

@class AJGame;

@interface AJPlayersViewController : AJTableViewController <AJSettingsViewControllerDelegate>

@property (nonatomic, strong) AJGame *game;

@end
