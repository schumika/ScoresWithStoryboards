//
//  AJPlayer+Additions.h
//  Scores
//
//  Created by Anca Calugar on 9/27/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJPlayer.h"

@interface AJPlayer (Additions)

@property (nonatomic, assign, readonly) double totalScore;

+ (AJPlayer *)createPlayerWithName:(NSString *)name forGame:(AJGame *)game;

- (NSDictionary *)toDictionary;

@end
