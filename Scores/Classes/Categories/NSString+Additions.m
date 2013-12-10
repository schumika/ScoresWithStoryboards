//
//  NSString+Additions.m
//  ScoreTracker
//
//  Created by Anca Julean on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Additions.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@implementation NSString (Additions)

+ (BOOL)isNilOrEmpty:(NSString *)string {
    BOOL nilOrEmpty = NO;
    
    if (!string || [string isEqualToString:@""]) {
        nilOrEmpty = YES;
    }
    
    return nilOrEmpty;
}

+ (NSString *)upArrow {
    return @"\u2191";
}

+ (NSString *)downArrow {
    return @"\u2193";
}

- (NSAttributedString *)attributtedStringWithFontSize:(CGFloat)fontSize andTextColor:(UIColor *)textColor {
    NSMutableAttributedString *attributtedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    [attributtedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0.0, attributtedString.string.length)];
    [attributtedString addAttribute:NSFontAttributeName value:[UIFont faranvaleFontWithSize:fontSize] range:NSMakeRange(0.0, attributtedString.string.length)];
    
    return attributtedString;
}

- (NSAttributedString *)attributtedStringWithSectionAttributes {
    return [self attributtedStringWithFontSize:20.0 andTextColor:[UIColor AJBrownColor]];
}

@end
