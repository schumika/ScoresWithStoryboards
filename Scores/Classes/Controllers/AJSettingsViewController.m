//
//  AJSettingsViewController.m
//  Scores
//
//  Created by Anca Calugar on 12/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSettingsViewController.h"
#import "AJPencilButton.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"
#import "UIButton+Additions.h"
#import "NSString+Additions.h"
#import "AJSettingsTopTableViewCell.h"

#import "AJDefines.h"

@interface AJSettingsViewController ()

@property (nonatomic, strong) NSMutableDictionary *mutableItemDictionary;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AJSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleViewText = @"Settings";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton clearButtonItemWithTitle:@"Done" target:self action:@selector(doneButtonClicked:)]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton clearButtonItemWithTitle:@"Cancel" target:self action:@selector(cancelButtonClicked:)]];
    
    self.mutableItemDictionary = [NSMutableDictionary dictionaryWithDictionary:self.itemDictionary];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    AJSettingsTopTableViewCell *topCell = (AJSettingsTopTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    topCell.itemName = textField.text;
    
    return YES;
}

#pragma mark - Button Actions

- (IBAction)doneButtonClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
    AJSettingsTopTableViewCell *topCell = (AJSettingsTopTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [topCell resignNameFieldFirstResponder];
    
    self.mutableItemDictionary[kAJNameKey] = topCell.itemName;
    self.mutableItemDictionary[kAJColorStringKey] = [topCell.itemColor toHexString:YES];
    
    if ([self.delegate respondsToSelector:@selector(settingsViewController:didFinishEditingItemDictionary:)]) {
        [self.delegate settingsViewController:self didFinishEditingItemDictionary:self.mutableItemDictionary];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.delegate respondsToSelector:@selector(settingsViewControllerDidCancelEditing:)]) {
        [self.delegate settingsViewControllerDidCancelEditing:self];
    }
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TopCellIdentifier = @"SettingsTopCellIdentifier";
    
    UITableViewCell *aCell = nil;
    if (indexPath.section == 0) {
        AJSettingsTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopCellIdentifier forIndexPath:indexPath];
        cell.itemName = self.itemDictionary[kAJNameKey];
        cell.itemImage = [UIImage imageWithData:self.itemDictionary[kAJPictureDataKey]];
        cell.itemColor = [UIColor colorWithHexString:self.itemDictionary[kAJColorStringKey]];
        
        aCell = cell;
    }
    return aCell;
}

@end
