//
//  UIImage+Additions.h
//  ScorePad
//
//  Created by Anca Julean on 9/13/12.
//  Copyright (c) 2012 Anca Julean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)defaultGamePicture;
+ (UIImage *)defaultPlayerPicture;

- (UIImage*)resizeToNewSize:(CGSize)newSize;
- (UIImage*)applyMask:(UIImage*)mask;

+ (UIImage *)roundedCornersStretchebleImage;

@end

