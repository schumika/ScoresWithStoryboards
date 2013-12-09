//
//  AJTextField.m
//  Scores
//
//  Created by Anca Calugar on 15/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJTextField.h"

#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@implementation AJTextField

- (void)awakeFromNib {
    self.background = [[UIImage imageNamed:@"round.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(12.0, 15.0, 12.0, 15.0)
                                                                        resizingMode:UIImageResizingModeStretch];
    
    self.font = [UIFont faranvaleFontWithSize:25.0];
    self.textColor = [UIColor AJBrownColor];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10.0, 0.0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds; {
    return CGRectInset(bounds, 10.0, 0.0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
