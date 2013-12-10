//
//  AJSettingsViewController.h
//  Scores
//
//  Created by Anca Calugar on 12/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJTableViewController.h"


@protocol AJSettingsViewControllerDelegate;


@interface AJSettingsViewController : AJTableViewController <UIActionSheetDelegate>

@property (nonatomic, strong) NSDictionary *itemDictionary;
@property (nonatomic, weak) id<AJSettingsViewControllerDelegate> delegate;

@end


@protocol AJSettingsViewControllerDelegate <NSObject>

- (void)settingsViewController:(AJSettingsViewController *)settingsViewController didFinishEditingItemDictionary:(NSDictionary *)dictionary;
- (void)settingsViewControllerDidCancelEditing:(AJSettingsViewController *)settingsViewController;

@end
