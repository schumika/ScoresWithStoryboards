//
//  AJTableViewViewController.m
//  Scores
//
//  Created by Anca Calugar on 9/25/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJTableViewController.h"

@interface AJTableViewController ()

@end

@implementation AJTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"nav-bar-clear-landscape.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 40.0, 0.0, 40.0)] forBarMetrics:UIBarMetricsLandscapePhone];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}
@end
