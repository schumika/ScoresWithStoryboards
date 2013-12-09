//
//  AJSettingsViewController.m
//  Scores
//
//  Created by Anca Calugar on 12/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSettingsViewController.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"
#import "UIButton+Additions.h"

#import "AJDefines.h"

@interface AJSettingsViewController ()

@property (nonatomic, strong) NSMutableDictionary *mutableItemDictionary;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

@end

@implementation AJSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleViewText = @"Settings";
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    
    self.nameLabel.font = [UIFont faranvaleFontWithSize:30.0];
    self.nameLabel.textColor = [UIColor AJBrownColor];
    
    
    self.cancelBarButtonItem.customView = [UIButton clearButtonItemWithTitle:@"Cancel" target:self.cancelBarButtonItem.target action:self.cancelBarButtonItem.action];
    self.doneBarButtonItem.customView = [UIButton clearButtonItemWithTitle:@"Done" target:self.doneBarButtonItem.target action:self.doneBarButtonItem.action];
    
    self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
    
    self.mutableItemDictionary = [NSMutableDictionary dictionaryWithDictionary:self.itemDictionary];
    
    [self loadDataAndUpdateUI:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Private methods

- (void)loadDataAndUpdateUI:(BOOL)updateUI {
    self.nameTextField.text = self.itemDictionary[kAJNameKey];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Button Actions

- (IBAction)doneButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    self.mutableItemDictionary[kAJNameKey] = self.nameTextField.text;
    
    if ([self.delegate respondsToSelector:@selector(settingsViewController:didFinishEditingItemDictionary:)]) {
        [self.delegate settingsViewController:self didFinishEditingItemDictionary:self.mutableItemDictionary];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(settingsViewControllerDidCancelEditing:)]) {
        [self.delegate settingsViewControllerDidCancelEditing:self];
    }
}

@end
