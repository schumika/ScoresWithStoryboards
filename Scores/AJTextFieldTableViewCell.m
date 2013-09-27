//
//  AJTextFieldCell.m
//  Scores
//
//  Created by Anca Calugar on 9/21/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJTextFieldTableViewCell.h"
#import "UIFont+Additions.h"


@implementation AJTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (CGRectGetHeight(self.contentView.frame) == 90.0) {
        self.textField.font = [UIFont faranvaleFontWithSize:35.0];
    } else {
        self.textField.font = [UIFont faranvaleFontWithSize:25.0];
    }
}

@end
