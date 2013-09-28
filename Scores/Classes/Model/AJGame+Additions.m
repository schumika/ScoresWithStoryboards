//
//  AJGame+Additions.m
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGame+Additions.h"
#import "AJPlayer+Additions.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"

@implementation AJGame (Additions)

+ (AJGame *)createGameWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context {
    AJGame *game = nil;
    
    game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:context];
    game.color = [[UIColor AJPurpleColor] toHexString:YES];
    game.name = name;
    game.rowId = 0;
    game.sortOrder = AJPlayersSortingNone;
    
    return game;
}

#pragma mark - Public methods

- (NSDictionary *)toDictionary {
    NSMutableDictionary *displayDictionary = [NSMutableDictionary dictionary];
    
    displayDictionary[kAJNameKey] = self.name;
    displayDictionary[kAJColorStringKey] = self.color;
    
    NSData *data = self.imageData;
    if (!data) {
        data = UIImagePNGRepresentation([UIImage defaultGamePicture]);
    }
    displayDictionary[kAJPictureDataKey] = data;
    
    displayDictionary[kAJRowIdKey] = @(self.rowId);
    displayDictionary[kAJGameNumberOfPlayersKey] = @([self.players count]);
    
    return displayDictionary;
}

- (NSArray *)orderedPlayersArray {
    NSMutableArray *orderedArray = [NSMutableArray arrayWithArray:[self.players allObjects]];
    
    int playersSortingType = self.sortOrder;
    if (playersSortingType == AJPlayersSortingNone) return orderedArray;
    
    BOOL isSortingByTotal = (playersSortingType == AJPlayersSortingByTotalASC || playersSortingType == AJPlayersSortingByTotalDESC);
    BOOL isSortingASC = (playersSortingType == AJPlayersSortingByTotalASC || playersSortingType == AJPlayersSortingByNameASC);
    
    [orderedArray sortUsingComparator:^NSComparisonResult(AJPlayer *player1, AJPlayer *player2) {
        if (isSortingByTotal) {
            if (player1.totalScore < player2.totalScore) {
                return isSortingASC ? NSOrderedAscending : NSOrderedDescending;
            } else {
                return isSortingASC ? NSOrderedDescending : NSOrderedAscending;
            }
        } else {
            if ([player1.name compare:player2.name] == NSOrderedAscending) {
                return isSortingASC ? NSOrderedAscending : NSOrderedDescending;
            } else {
                return isSortingASC ? NSOrderedDescending : NSOrderedAscending;
            }
        }
    }];
    
    return orderedArray;
}


@end
