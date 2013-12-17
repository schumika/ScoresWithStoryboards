//
//  AJPlayerTableView.h
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSeparatorTableViewCell.h"

@interface AJPlayerTableViewCell : AJSeparatorTableViewCell

@property (nonatomic, strong) NSDictionary *playerDictionary;
@property (nonatomic, assign) BOOL displaysBackPanel;

- (void)flipTotalViewAnimated:(BOOL)animated;
- (NSString *)textInAddScoreTextfield;

@end
