//
//  AJGameTableViewCell.m
//  Scores
//
//  Created by Anca Calugar on 9/18/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGameTableViewCell.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"
#import "UIFont+Additions.h"

@interface AJGameTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *disclosureIndicatorImageView;

@end

@implementation AJGameTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    for(NSLayoutConstraint *cellConstraint in self.constraints){
        [self removeConstraint:cellConstraint];
        id firstItem = cellConstraint.firstItem == self ? self.contentView : cellConstraint.firstItem;
        id seccondItem = cellConstraint.secondItem == self ? self.contentView : cellConstraint.secondItem;
        NSLayoutConstraint* contentViewConstraint =
        [NSLayoutConstraint constraintWithItem:firstItem
                                     attribute:cellConstraint.firstAttribute
                                     relatedBy:cellConstraint.relation
                                        toItem:seccondItem
                                     attribute:cellConstraint.secondAttribute
                                    multiplier:cellConstraint.multiplier
                                      constant:cellConstraint.constant];
        [self.contentView addConstraint:contentViewConstraint];
    }
    
    if (CGRectGetHeight(self.contentView.frame) == 90.0) {
        self.gameLabel.font = [UIFont faranvaleFontWithSize:40.0];
    } else {
        self.gameLabel.font = [UIFont faranvaleFontWithSize:30.0];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    self.disclosureIndicatorImageView.hidden = editing;
}

- (void)setGameDictionary:(NSDictionary *)gameDictionary {
    self.gameLabel.text = gameDictionary[kAJNameKey];
    self.gameLabel.textColor = [UIColor colorWithHexString:gameDictionary[kAJColorStringKey]];
    self.playersLabel.text = [NSString stringWithFormat:@"players: %d", ((NSNumber *)gameDictionary[kAJGameNumberOfPlayersKey]).intValue];
    
    UIImage *gameImage = [UIImage imageWithData:gameDictionary[kAJPictureDataKey]];
    [self.gameImageView setImage:[[gameImage resizeToNewSize:CGSizeMake(50.0, 50.0)]
                                  applyMask:[UIImage imageNamed:@"mask.png"]]];
}

@end
