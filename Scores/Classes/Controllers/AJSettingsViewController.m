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

#import "AJDefines.h"

@interface AJSettingsViewController ()

@property (nonatomic, strong) NSMutableDictionary *mutableItemDictionary;
@property (nonatomic, strong) NSArray *pencilsArray;
@property (nonatomic, assign) int indexOfSelectedPencil;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton1;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton2;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton3;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton4;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton5;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton6;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton7;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton8;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton9;
@property (weak, nonatomic) IBOutlet AJPencilButton *pencilButton10;

@end

@implementation AJSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleViewText = @"Settings";
    //self.navigationItem.leftBarButtonItem = nil;
    
    self.pencilsArray = @[self.pencilButton1, self.pencilButton2, self.pencilButton3, self.pencilButton4, self.pencilButton5,
                          self.pencilButton6, self.pencilButton7, self.pencilButton8, self.pencilButton9, self.pencilButton10];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    
    self.nameLabel.attributedText = [self.nameLabel.text attributtedStringWithSectionAttributes];
    self.colorLabel.attributedText = [self.colorLabel.text attributtedStringWithSectionAttributes];
    
    self.pencilButton1.color = [UIColor blackColor];
    self.pencilButton2.color = [UIColor blueColor];
    self.pencilButton3.color = [UIColor AJBrownColor];
    self.pencilButton4.color = [UIColor AJGreenColor];
    self.pencilButton5.color = [UIColor AJOrangeColor];
    self.pencilButton6.color = [UIColor AJPinkColor];
    self.pencilButton7.color = [UIColor AJPurpleColor];
    self.pencilButton8.color = [UIColor AJRedColor];
    self.pencilButton9.color = [UIColor AJYellowColor];
    self.pencilButton10.color = [UIColor whiteColor];

    
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
    
    __block BOOL hasFoundColor = NO;
    NSString *colorString = self.itemDictionary[kAJColorStringKey];
    [self.pencilsArray enumerateObjectsUsingBlock:^(AJPencilButton *pencilButton, NSUInteger idx, BOOL *stop) {
        if ([[pencilButton.color toHexString:YES] isEqualToString:colorString]) {
            self.indexOfSelectedPencil = idx;
            *stop = YES;
            hasFoundColor = YES;
        }
    }];
    
    if (hasFoundColor) {
        [(AJPencilButton *)self.pencilsArray[self.indexOfSelectedPencil] setSelected:YES];
    } else {
        [(AJPencilButton *)self.pencilsArray[2] setSelected:YES];
    }
    
    
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
    UIColor *color = [(AJPencilButton *)self.pencilsArray[self.indexOfSelectedPencil] color];
    self.mutableItemDictionary[kAJColorStringKey] = [color toHexString:YES];
    
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

- (IBAction)pencilButtonClicked:(UIButton *)sender {
    [self.pencilsArray enumerateObjectsUsingBlock:^(UIButton *pencilButton, NSUInteger idx, BOOL *stop) {
        if ([pencilButton isEqual:sender]) {
            [pencilButton setSelected:YES];
            self.indexOfSelectedPencil = idx;
        } else {
            [pencilButton setSelected:NO];
        }
    }];
}

@end
