//
//  AJDefines.h
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AJPlayersSortingNone = 0,
    AJPlayersSortingByTotalASC,
    AJPlayersSortingByTotalDESC,
    AJPlayersSortingByNameASC,
    AJPlayersSortingByNameDESC
} AJPlayersSortingType;

typedef enum {
    AJScoresSortingByRoundASC = 0,
    AJScoresSortingByRoundDESC,
} AJScoresSortingType;

extern NSString const * kAJNameKey;
extern NSString const * kAJColorStringKey;
extern NSString const * kAJPictureDataKey;
extern NSString const * kAJRowIdKey;

extern NSString const * kAJPlayerTotalScoresKey;
extern NSString const * kAJPlayerNumberOfRoundsKey;

extern NSString const * kAJGameNumberOfPlayersKey;

extern NSString const * kAJScoreRoundKey;
extern NSString const * kAJScoreValueKey;
extern NSString const * kAJScoreIntermediateTotal;
