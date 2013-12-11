//
//  AJPlayer+Additions.m
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPlayer+Additions.h"
#import "AJGame.h"
#import "AJScore.h"
#import "UIImage+Additions.h"

@implementation AJPlayer (Additions)

+ (AJPlayer *)createPlayerWithName:(NSString *)name forGame:(AJGame *)game {
    AJPlayer *player = nil;
    
    player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:game.managedObjectContext];
    player.name = name;
    player.game = game;
    player.sortOrder = AJScoresSortingByRoundASC;
    
    return player;
}

#pragma mark - Public properties

- (double)totalScore {
    double total = 0.0;
    
    for (AJScore *score in self.scores) {
        total += score.value;
    }
    
    return total;
}

- (NSArray *)orderedScoresArray {
    return [self orderedScoresArraySortedAscending:(self.sortOrder == AJScoresSortingByRoundASC)];
    
}

- (NSArray *)orderedScoresArraySortedAscending:(BOOL)ascending {
    NSMutableArray *orderedArray = [NSMutableArray arrayWithArray:[self.scores allObjects]];
    
    int playersSortingType = self.sortOrder;
    
    BOOL isSortingASC = (playersSortingType == AJScoresSortingByRoundASC || playersSortingType == AJScoresSortingByRoundDESC);
    
    [orderedArray sortUsingComparator:^NSComparisonResult(AJScore *score1, AJScore *score2) {
        if (score1.round <  score2.round) {
            return isSortingASC ? NSOrderedAscending : NSOrderedDescending;
        } else {
            return isSortingASC ? NSOrderedDescending : NSOrderedAscending;
        }
    }];
    
    return orderedArray;
    
}

#pragma mark - Public methods

- (NSDictionary *)toDictionary {
    NSMutableDictionary *displayDictionary = [NSMutableDictionary dictionary];
    
    displayDictionary[kAJNameKey] = self.name;
    displayDictionary[kAJColorStringKey] = self.color;
    
    NSData *data = self.imageData;
    if (!data) {
        data = UIImagePNGRepresentation([UIImage defaultPlayerPicture]);
    }
    displayDictionary[kAJPictureDataKey] = data;
    
    displayDictionary[kAJRowIdKey] = [NSNumber numberWithInt:-1];
    displayDictionary[kAJPlayerTotalScoresKey] = @([self totalScore]);
    displayDictionary[kAJPlayerNumberOfRoundsKey] = @([self.scores count]);
    
    return displayDictionary;
}

- (void)setPlayerPropertiesFromDictionary:(NSDictionary *)dictionary {
    self.name = dictionary[kAJNameKey];
    self.color = dictionary[kAJColorStringKey];
    self.imageData = dictionary[kAJPictureDataKey];
}

- (double)intermediateTotalAtRound:(int)row {
    double total = 0.0;
    
    NSArray *scores = [self orderedScoresArraySortedAscending:YES];
    int currentRow = row;
    for (int rowIndex = 0; rowIndex < currentRow; rowIndex++) {
        AJScore *score = scores[rowIndex];
        total += score.value;
    }
    
    return total;
}

- (void)updateRoundsForScores {
    NSArray *orderedArray = [NSArray arrayWithArray:self.orderedScoresArray];
    
    int rounds = self.orderedScoresArray.count;
    int scoresSortingType = self.sortOrder;
    
    [orderedArray enumerateObjectsUsingBlock:^(AJScore *score, NSUInteger scoreIndex, BOOL *stop) {
        if (scoresSortingType == AJScoresSortingByRoundDESC) {
            score.round = rounds - scoreIndex;
        } else {
            score.round = scoreIndex + 1;
        }
    }];
    
    [self.managedObjectContext save:nil];
}


@end
