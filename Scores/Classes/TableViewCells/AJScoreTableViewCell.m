//
//  AJScoreTableViewCell.m
//  Scores
//
//  Created by Anca Calugar on 10/3/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJScoreTableViewCell.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@interface AJScoreTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermediateLabel;

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
}

- (void)setScoreDictionary:(NSDictionary *)scoreDictionary {
//    self.playerLabel.text = playerDictionary[kAJNameKey];
//    self.playerLabel.textColor = [UIColor colorWithHexString:playerDictionary[kAJColorStringKey]];
//    
//    UIImage *playerImage = [UIImage imageWithData:playerDictionary[kAJPictureDataKey]];
//    [self.playerImageView setImage:[[playerImage resizeToNewSize:CGSizeMake(65.0, 65.0)]
//                                    applyMask:[UIImage imageNamed:@"core_inbox_contact_photo_mask.png.png"]]];
}

@end
