//
//  AJPlayerTableView.m
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPlayerTableViewCell.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"

@interface AJPlayerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@end

@implementation AJPlayerTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    if (CGRectGetHeight(self.contentView.frame) == 90.0) {
        self.playerLabel.font = [UIFont faranvaleFontWithSize:40.0];
        self.totalLabel.font = [UIFont faranvaleFontWithSize:45.0];
    } else {
        self.playerLabel.font = [UIFont faranvaleFontWithSize:30.0];
        self.totalLabel.font = [UIFont faranvaleFontWithSize:35.0];
    }
    self.totalLabel.textColor = [UIColor AJBrownColor];
}

- (void)setPlayerDictionary:(NSDictionary *)playerDictionary {
    self.playerLabel.text = playerDictionary[kAJNameKey];
    self.playerLabel.textColor = [UIColor colorWithHexString:playerDictionary[kAJColorStringKey]];
    
    UIImage *playerImage = [UIImage imageWithData:playerDictionary[kAJPictureDataKey]];
    [self.playerImageView setImage:[[playerImage resizeToNewSize:CGSizeMake(65.0, 65.0)]
                                  applyMask:[UIImage imageNamed:@"core_inbox_contact_photo_mask.png.png"]]];
}

@end
