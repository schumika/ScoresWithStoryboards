//
//  AJScoresManager.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AJGame;
@class AJPlayer;
@class AJScore;

@interface AJScoresManager : NSObject

+ (AJScoresManager *)sharedInstance;

// games methods
- (NSArray *)getGamesArray;
- (AJGame *)getGameWithRowId:(int)rowId;
- (void)addGameWithName:(NSString *)name andRowId:(int)rowId;
- (void)deleteGame:(AJGame *)game;

// players methods
- (NSArray *)getAllPlayersForGame:(AJGame *)game;
- (AJPlayer *)createPlayerWithName:(NSString *)playerName forGame:(AJGame *)game;
- (void)deletePlayer:(AJPlayer *)player;
- (void)deleteAllPlayersForGame:(AJGame *)game;

// scores methods
- (NSArray *)getAllScoresForPlayer:(AJPlayer *)player;
- (AJScore *)createScoreWithValue:(double)value inRound:(int)round forPlayer:(AJPlayer *)player;
- (void)deleteScore:(AJScore *)score;
- (void)deleteAllScoresForPlayer:(AJPlayer *)player;

// other methods
- (BOOL)saveContext;

@end
