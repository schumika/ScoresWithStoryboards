//
//  UIBarButtonItem+Additions.m
//  ScoreTracker
//
//  Created by Anca Julean on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

#import "UIButton+Additions.h"

@implementation UIBarButtonItem (Additions)

@dynamic buttonTitle, buttonTitleColor;

#pragma mark - Dynamic properties

- (NSString *)buttonTitle {
    return [(UIButton *)self.customView titleForState:UIControlStateNormal];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    UIButton *button = (UIButton *)self.customView;
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    
    CGSize buttonSize = [buttonTitle sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, MAX(30.0, buttonSize.width), 30);
}

- (UIColor *)buttonTitleColor {
    return [(UIButton *)self.customView titleColorForState:UIControlStateNormal];
}

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    [(UIButton *)self.customView setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

#pragma mark - Public methods

+ (UIBarButtonItem *)clearBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithCustomView:[UIButton clearButtonItemWithTitle:title target:target action:action]];
}

+ (UIBarButtonItem *)clearBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    
    UIBarButtonItem *barButtonItem = nil;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){CGPointZero, image.size};
    
    barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)clearBackButtonItemWithTarget:(id)target action:(SEL)action {
    
    UIBarButtonItem *barButtonItem = nil;
    
    UIImage *backImage = [UIImage imageNamed:@"back"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGSize buttonSize = backImage.size;
    button.frame = (CGRect){CGPointZero, buttonSize};
    
    barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

@end
