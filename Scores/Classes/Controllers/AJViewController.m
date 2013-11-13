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
#import "UIDevice+Additions.h"

@interface AJViewController ()
@property (nonatomic, strong) UILabel *titleView;
@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([UIDevice isOS70OrGreater]) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear_ios7.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)]
                                                      forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear-landscape_ios7.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)]
                                                      forBarMetrics:UIBarMetricsLandscapePhone];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)]
                                                      forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear-landscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)]
                                                      forBarMetrics:UIBarMetricsLandscapePhone];
    }
    
    [self.navigationController.toolbar setBackgroundImage:[[UIImage imageNamed:@"toolbar-clear.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)]
                                       forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.toolbar setBackgroundImage:[[UIImage imageNamed:@"toolbar-clear-landscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)]
                                       forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsLandscapePhone];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    
    if ([self.navigationController.toolbar respondsToSelector:@selector(setShadowImage:forToolbarPosition:)]) {
        [self.navigationController.toolbar setShadowImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem clearBackButtonItemWithTarget:self action:@selector(backButtonClicked:)];
    
    self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    self.titleView.backgroundColor = [UIColor clearColor];
    self.titleView.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleView.textAlignment = NSTextAlignmentCenter;
    self.titleView.font = [UIFont faranvaleFontWithSize:30.0];
    self.titleView.textColor = [UIColor AJGreenColor];
    self.navigationItem.titleView = self.titleView;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.titleView.font = [UIFont faranvaleFontWithSize:20.0];
    } else {
        self.titleView.font = [UIFont faranvaleFontWithSize:30.0];
    }
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
