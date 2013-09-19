//
//  AJGame+Additions.m
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJGame+Additions.h"

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

@end
