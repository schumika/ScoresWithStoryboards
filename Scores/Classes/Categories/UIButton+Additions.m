//
//  UIButton+Additions.m
//  Scores
//
//  Created by Anca Calugar on 13/11/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "UIButton+Additions.h"

#import "UIColor+Additions.h"
#import "UIFont+Additions.h"

@implementation UIButton (Additions)

+ (UIButton *)clearButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor AJGreenColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont faranvaleFontWithSize:20.0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGSize buttonSize = [title sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, MAX(30.0, buttonSize.width), 30);
    
    return button;
}

@end
