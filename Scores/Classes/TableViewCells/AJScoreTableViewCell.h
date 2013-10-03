//
//  AJScoreTableViewCell.h
//  Scores
//
//  Created by Anca Calugar on 10/3/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJSeparatorTableViewCell.h"

@interface AJScoreTableViewCell : AJSeparatorTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermediateLabel;

@end
