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

// other methods
- (BOOL)saveContext;

@end
