//
//  AJScoresManager.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AJGame;

@interface AJScoresManager : NSObject

+ (AJScoresManager *)sharedInstance;

// games methods
- (NSArray *)getGamesArray;
- (AJGame *)getGameWithRowId:(int)rowId;
- (void)addGameWithName:(NSString *)name andRowId:(int)rowId;
- (void)deleteGame:(AJGame *)game;

// other methods
- (BOOL)saveContext;

@end
