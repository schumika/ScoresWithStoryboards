//
//  AJPlayer.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AJGame, AJScore;

@interface AJPlayer : NSManagedObject

@property (nonatomic) int16_t rowId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t sortOrder;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) AJGame *game;
@property (nonatomic, retain) NSSet *scores;
@end

@interface AJPlayer (CoreDataGeneratedAccessors)

- (void)addScoresObject:(AJScore *)value;
- (void)removeScoresObject:(AJScore *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

@end
