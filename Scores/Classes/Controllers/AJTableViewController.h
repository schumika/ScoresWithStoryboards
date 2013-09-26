//
//  AJTableViewViewController.h
//  Scores
//
//  Created by Anca Calugar on 9/25/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJTableViewController : UITableViewController

@property (nonatomic, strong) NSString      *titleViewText;
@property (nonatomic, strong) UIColor       *titleViewColor;

- (IBAction)backButtonClicked:(id)sender;

@end
