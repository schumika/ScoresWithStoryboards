//
//  AJScore+Additions.m
//  Scores
//
//  Created by Anca Calugar on 10/3/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJScore+Additions.h"
#import "AJPlayer+Additions.h"

@implementation AJScore (Additions)

+ (AJScore *)createScoreWithValue:(double)value inRound:(int)round forPlayer:(AJPlayer *)player {
    AJScore *score = nil;
    
    score = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:player.managedObjectContext];
    score.value = value;
    score.round = round;
    score.player = player;
    
    return score;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    dictionary[kAJScoreValueKey] = @(self.value);
    dictionary[kAJScoreRoundKey] = @(self.round);
    //dictionary[kAJScoreIntermediateTotal] = @([self.player intermediateTotalAtRound:self.round.intValue]);
    
    return dictionary;
}


@end
