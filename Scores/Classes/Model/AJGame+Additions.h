//
//  AJGame+Additions.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGame.h"

@interface AJGame (Additions)

+ (AJGame *)createGameWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

// public methods
- (NSDictionary *)toDictionary;
- (void)setGamePropertiesFromDictionary:(NSDictionary *)dictionary;
- (NSArray *)orderedPlayersArray;

@end
