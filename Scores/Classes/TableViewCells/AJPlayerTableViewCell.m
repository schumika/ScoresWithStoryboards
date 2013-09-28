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

@interface AJPlayerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@end

@implementation AJPlayerTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    if (CGRectGetHeight(self.contentView.frame) == 90.0) {
        self.playerLabel.font = [UIFont faranvaleFontWithSize:40.0];
    } else {
        self.playerLabel.font = [UIFont faranvaleFontWithSize:30.0];
    }
}

- (void)setPlayerDictionary:(NSDictionary *)playerDictionary {
    self.playerLabel.text = playerDictionary[kAJNameKey];
    self.playerLabel.textColor = [UIColor colorWithHexString:playerDictionary[kAJColorStringKey]];
}
@end
