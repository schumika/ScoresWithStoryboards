//
//  AJScoreTableViewCell.m
//  Scores
//
//  Created by Anca Calugar on 10/3/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJScoreTableViewCell.h"
#import "AJTextField.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@interface AJScoreTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermediateLabel;
@property (weak, nonatomic) IBOutlet AJTextField *editScoreTextField;
@property (weak, nonatomic) IBOutlet UIView *mainPannel;
@property (nonatomic, assign) BOOL displaysBackPanel;

@end

@implementation AJScoreTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    if (CGRectGetHeight(self.contentView.frame) == 90.0) {
        self.roundLabel.font = [UIFont faranvaleFontWithSize:40.0];
        self.scoreLabel.font = [UIFont faranvaleFontWithSize:45.0];
        self.intermediateLabel.font = [UIFont faranvaleFontWithSize:45.0];
    } else {
        self.roundLabel.font = [UIFont faranvaleFontWithSize:30.0];
        self.scoreLabel.font = [UIFont faranvaleFontWithSize:35.0];
        self.intermediateLabel.font = [UIFont faranvaleFontWithSize:30.0];
    }
    self.roundLabel.textColor = [UIColor AJBrownColor];
    self.scoreLabel.textColor = [UIColor AJBrownColor];
    self.intermediateLabel.textColor = [UIColor AJBrownColor];
    [self.editScoreTextField setTextFontSize:20.0];
}

- (void)setScoreDictionary:(NSDictionary *)scoreDictionary {
    self.roundLabel.text = [NSString stringWithFormat:@"   %d", ((NSNumber *)scoreDictionary[kAJScoreRoundKey]).intValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%g",  ((NSNumber *)scoreDictionary[kAJScoreValueKey]).doubleValue];
    self.intermediateLabel.text = [NSString stringWithFormat:@"%g   ",  ((NSNumber *)scoreDictionary[kAJScoreIntermediateTotal]).doubleValue];
}

- (void)flipTotalViewAnimated:(BOOL)animated {
    [UIView transitionWithView:self.mainPannel
                      duration:0.5
                       options:(self.displaysBackPanel ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft)
                    animations:^{
                        if (self.displaysBackPanel) {
                            self.editScoreTextField.hidden = YES;
                            self.scoreLabel.hidden = NO;
                        } else {
                            self.editScoreTextField.hidden = NO;
                            [self.editScoreTextField becomeFirstResponder];
                            self.editScoreTextField.text = self.scoreLabel.text;
                            self.scoreLabel.hidden = YES;
                        }
                    }
                    completion:^(BOOL finished){
                        self.displaysBackPanel = !self.displaysBackPanel;
                    }];
}

- (NSString *)textInAddScoreTextfield {
    return self.editScoreTextField.text;
}

@end
