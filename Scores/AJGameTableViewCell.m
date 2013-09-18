//
//  AJGameTableViewCell.m
//  Scores
//
//  Created by Anca Calugar on 9/18/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGameTableViewCell.h"

@interface AJGameTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playersLabel;

@end

@implementation AJGameTableViewCell

- (void)setGameDictionary:(NSDictionary *)gameDictionary {
    self.gameLabel.text = gameDictionary[@"gameName"];
    self.playersLabel.text = gameDictionary[@"gamePlayers"];
}

@end
