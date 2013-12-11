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

- (void)flipTotalViewAnimated:(BOOL)animated;

@end
