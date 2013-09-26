//
//  UIBarButtonItem+Additions.h
//  ScoreTracker
//
//  Created by Anca Julean on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface UIBarButtonItem (Additions)

@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) UIColor *buttonTitleColor;

+ (UIBarButtonItem *)clearBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)clearBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)clearBackButtonItemWithTarget:(id)target action:(SEL)action;

@end
