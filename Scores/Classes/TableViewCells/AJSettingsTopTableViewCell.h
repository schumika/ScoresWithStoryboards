//
//  AJSettingsTopTableViewCell.h
//  Scores
//
//  Created by Anca Calugar on 10/12/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSeparatorTableViewCell.h"

@interface AJSettingsTopTableViewCell : AJSeparatorTableViewCell
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, strong) UIColor *itemColor;

- (void)resignNameFieldFirstResponder;

@end
