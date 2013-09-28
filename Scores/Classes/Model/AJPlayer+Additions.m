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

@end
