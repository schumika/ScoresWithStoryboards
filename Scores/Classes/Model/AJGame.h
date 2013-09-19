//
//  AJGame.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AJPlayer;

@interface AJGame : NSManagedObject

@property (nonatomic) int16_t rowId;
@property (nonatomic) int16_t sortOrder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSSet *players;
@end

@interface AJGame (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(AJPlayer *)value;
- (void)removePlayersObject:(AJPlayer *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
