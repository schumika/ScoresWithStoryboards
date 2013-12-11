//
//  AJPlayerTableView.m
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPlayerTableViewCell.h"
#import "AJTextField.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"
#import "UIButton+Additions.h"

@interface AJPlayerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundsPlayedLabel;
@property (weak, nonatomic) IBOutlet AJTextField *addScoreTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@end

@implementation AJPlayerTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    if (CGRectGetHeight(self.contentView.frame) == 90.0) {
        self.playerLabel.font = [UIFont faranvaleFontWithSize:40.0];
        self.totalLabel.font = [UIFont faranvaleFontWithSize:45.0];
    } else {
        self.playerLabel.font = [UIFont faranvaleFontWithSize:33.0];
        self.totalLabel.font = [UIFont faranvaleFontWithSize:35.0];
    }
    self.totalLabel.textColor = [UIColor AJBrownColor];
    self.roundsPlayedLabel.textColor = [UIColor lightGrayColor];
    [self.addScoreTextField setTextFontSize:20.0];
    [self.doneButton setRoundedBackgroundStyle];
}

- (void)setPlayerDictionary:(NSDictionary *)playerDictionary {
    self.playerLabel.text = playerDictionary[kAJNameKey];
    self.playerLabel.textColor = [UIColor colorWithHexString:playerDictionary[kAJColorStringKey]];
    
    UIImage *playerImage = [UIImage imageWithData:playerDictionary[kAJPictureDataKey]];
    [self.playerImageView setImage:[[playerImage resizeToNewSize:CGSizeMake(65.0, 65.0)]
                                  applyMask:[UIImage imageNamed:@"core_inbox_contact_photo_mask.png.png"]]];
    
    self.totalLabel.text = [NSString stringWithFormat:@"%g", [(NSNumber *)playerDictionary[kAJPlayerTotalScoresKey] doubleValue]];
    int nrOfRounds = [(NSNumber *)playerDictionary[kAJPlayerNumberOfRoundsKey] intValue];
    self.roundsPlayedLabel.text = [NSString stringWithFormat:@"%d %@ played", nrOfRounds, (nrOfRounds == 1) ? @"round" : @"rounds"];
}

- (void)flipTotalViewAnimated:(BOOL)animated {
    if (self.totalLabel.hidden) {
        self.totalLabel.hidden = NO;
        self.addScoreTextField.hidden = YES;
        self.doneButton.hidden = YES;
    } else {
        self.totalLabel.hidden = YES;
        self.addScoreTextField.hidden = NO;
        self.doneButton.hidden = NO;
    }
}

@end
