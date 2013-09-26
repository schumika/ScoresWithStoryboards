//
//  AJViewController.m
//  Scores
//
//  Created by Anca Calugar on 9/26/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJViewController.h"
#import "UIBarButtonItem+Additions.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@interface AJViewController ()
@property (nonatomic, strong) UILabel *titleView;
@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear-landscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)] forBarMetrics:UIBarMetricsLandscapePhone];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem clearBackButtonItemWithTarget:self action:@selector(backButtonClicked:)];
    
    self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    self.titleView.backgroundColor = [UIColor clearColor];
    self.titleView.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleView.textAlignment = NSTextAlignmentCenter;
    self.titleView.font = [UIFont faranvaleFontWithSize:40.0];
    self.titleView.textColor = [UIColor AJGreenColor];
    self.navigationItem.titleView = self.titleView;
}

#pragma mark - UI related

- (void)setTitleViewText:(NSString *)titleViewText {
    if (titleViewText != _titleViewText) {
        _titleViewText = titleViewText;
        
        self.titleView.text = _titleViewText;
    }
}

- (void)setTitleViewColor:(UIColor *)titleViewColor {
    if (titleViewColor != _titleViewColor) {
        _titleViewColor = titleViewColor;
        
        self.titleView.textColor = titleViewColor;
    }
}

#pragma mark - Actions

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
