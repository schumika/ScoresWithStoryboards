//
//  AJTextField.m
//  Scores
//
//  Created by Anca Calugar on 15/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJTextField.h"

#import "UIImage+Additions.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@implementation AJTextField

- (void)awakeFromNib {
    self.background = [UIImage roundedCornersStretchebleImage];
    
    self.textColor = [UIColor AJBrownColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setTextFontSize:(CGFloat)textFontSize {
    _textFontSize = textFontSize;
    self.font = [UIFont faranvaleFontWithSize:textFontSize];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10.0, 0.0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds; {
    return CGRectInset(bounds, 10.0, 0.0);
}

@end
