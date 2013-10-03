//
//  AJScore+Additions.h
//  Scores
//
//  Created by Anca Calugar on 10/3/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJScore.h"

@class AJPlayer;

@interface AJScore (Additions)
+ (AJScore *)createScoreWithValue:(double)value inRound:(int)round forPlayer:(AJPlayer *)player;
- (NSDictionary *)toDictionary;

@end
