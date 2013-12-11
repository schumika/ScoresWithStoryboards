//
//  UIButton+Additions.h
//  Scores
//
//  Created by Anca Calugar on 13/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Additions)

+ (UIButton *)clearButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)setRoundedBackgroundStyle;

@end
