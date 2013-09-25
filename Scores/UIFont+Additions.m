//
//  UIFont+Additions.m
//  FontTrial
//
//  Created by Anca Calugar on 1/24/13.
//  Copyright (c) 2013 Anca Julean. All rights reserved.
//

#import "UIFont+Additions.h"

static NSString *LDBrushFontFamilyName = @"LD Brush Stroke";
static NSString *FaranvaleFontFamilyName = @"Faranvale";


@implementation UIFont (Additions)


+ (NSArray *)fontNamesForLDBrushFamilyName {
    static NSArray *fontNames;
    
    if (fontNames == nil) {
        fontNames = [UIFont fontNamesForFamilyName:LDBrushFontFamilyName];
    }
    
    return fontNames;
}

+ (UIFont *)LDBrushFontWithSize:(CGFloat)size {
    UIFont *font = nil;
    
    if (font == nil) {
        if ([[self fontNamesForLDBrushFamilyName] lastObject] != nil) {
            font = [UIFont fontWithName:[self fontNamesForLDBrushFamilyName][0] size:size];
        }
        
        if (font == nil) {
            font = [UIFont fontWithName:@"Thonburi-Bold" size:size];
        }
    }
    
    return font;
}

+ (NSArray *)fontNamesForFaranvaleFamilyName {
    static NSArray *fontNames;
    
    if (fontNames == nil) {
        fontNames = [UIFont fontNamesForFamilyName:FaranvaleFontFamilyName];
    }
    
    return fontNames;
}

+ (UIFont *)faranvaleFontWithSize:(CGFloat)size {
    UIFont *font = nil;
    
    if (font == nil) {
        if ([[self fontNamesForFaranvaleFamilyName] lastObject] != nil) {
            font = [UIFont fontWithName:[self fontNamesForFaranvaleFamilyName][0] size:size];
        }
        
        if (font == nil) {
            font = [UIFont fontWithName:@"Thonburi-Bold" size:size];
        }
    }
    
    return font;
}

@end
