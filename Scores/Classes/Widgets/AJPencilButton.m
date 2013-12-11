//
//  AJPencilButton.m
//  Scores
//
//  Created by Anca Calugar on 09/12/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPencilButton.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"

@implementation AJPencilButton

- (void)setColor:(UIColor *)color {
    _color = color;
    
    NSString *pencilColorName = @"purple";
    if ([color isEqual:[UIColor blackColor]]) pencilColorName = @"black";
    else if ([color isEqual:[UIColor AJBlueColor]]) pencilColorName = @"blue";
    else if ([color isEqual:[UIColor AJBrownColor]]) pencilColorName = @"brown";
    else if ([color isEqual:[UIColor AJGreenColor]]) pencilColorName = @"green";
    else if ([color isEqual:[UIColor AJOrangeColor]]) pencilColorName = @"orange";
    else if ([color isEqual:[UIColor AJPinkColor]]) pencilColorName = @"pink";
    else if ([color isEqual:[UIColor AJPurpleColor]]) pencilColorName = @"purple";
    else if ([color isEqual:[UIColor AJRedColor]]) pencilColorName = @"red";
    else if ([color isEqual:[UIColor whiteColor]]) pencilColorName = @"white";
    else if ([color isEqual:[UIColor AJYellowColor]]) pencilColorName = @"yellow";
    
    UIImage *pencilImage = [UIImage imageNamed:[NSString stringWithFormat:@"pencil_%@.png", pencilColorName]];
    [self setImage:pencilImage forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        [self setBackgroundImage:[UIImage roundedCornersStretchebleImage] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

@end
