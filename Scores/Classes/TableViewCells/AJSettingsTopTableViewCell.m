//
//  AJSettingsTopTableViewCell.m
//  Scores
//
//  Created by Anca Calugar on 10/12/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSettingsTopTableViewCell.h"
#import "AJTextField.h"
#import "AJPencilButton.h"

#import "NSString+Additions.h"
#import "UIColor+Additions.h"


@interface AJSettingsTopTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet AJTextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *pictureLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *outlineImageView;

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

@property (nonatomic, strong) NSArray *pencilsArray;
@property (nonatomic, assign) int indexOfSelectedPencil;

@end

@implementation AJSettingsTopTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.nameLabel.attributedText = [self.nameLabel.text attributtedStringWithSectionAttributes];
    self.pictureLabel.attributedText = [self.pictureLabel.text attributtedStringWithSectionAttributes];
    self.colorLabel.attributedText = [self.colorLabel.text attributtedStringWithSectionAttributes];
    [self.nameTextField setTextFontSize:20.0];
    [self.pictureButton setBackgroundColor:[UIColor clearColor]];
    
    self.outlineImageView.image = [[UIImage imageNamed:@"round.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(12.0, 15.0, 12.0, 15.0)
                                                                                    resizingMode:UIImageResizingModeStretch];

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
    
    self.pencilsArray = @[self.pencilButton1, self.pencilButton2, self.pencilButton3, self.pencilButton4, self.pencilButton5,
                          self.pencilButton6, self.pencilButton7, self.pencilButton8, self.pencilButton9, self.pencilButton10];
}

- (void)setItemName:(NSString *)itemName {
    _itemName = itemName;
    self.nameTextField.text = itemName;
}

- (void)setItemImage:(UIImage *)itemImage {
    _itemImage = itemImage;
    [self.pictureButton setBackgroundImage:itemImage forState:UIControlStateNormal];
}

- (void)setItemColor:(UIColor *)itemColor {
    _itemColor = itemColor;
    
    __block BOOL hasFoundColor = NO;
    NSString *colorString = [self.itemColor toHexString:YES];
    [self.pencilsArray enumerateObjectsUsingBlock:^(AJPencilButton *pencilButton, NSUInteger idx, BOOL *stop) {
        if ([[pencilButton.color toHexString:YES] isEqualToString:colorString]) {
            self.indexOfSelectedPencil = idx;
            [pencilButton setSelected:YES];
            hasFoundColor = YES;
        } else {
            [pencilButton setSelected:NO];
        }
    }];
    
    if (!hasFoundColor) {
        [(AJPencilButton *)self.pencilsArray[2] setSelected:YES];
    }
    
    self.nameTextField.textColor = itemColor;
}

#pragma mark - Public methods

- (void)resignNameFieldFirstResponder {
    self.itemName = self.nameTextField.text;
    [self.nameTextField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)pencilButtonClicked:(AJPencilButton *)sender {
    [self setItemColor:sender.color];
}

@end
