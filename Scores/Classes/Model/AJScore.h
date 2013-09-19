//
//  AJScore.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AJPlayer;

@interface AJScore : NSManagedObject

@property (nonatomic) int16_t rowID;
@property (nonatomic) double value;
@property (nonatomic, retain) AJPlayer *player;

@end
