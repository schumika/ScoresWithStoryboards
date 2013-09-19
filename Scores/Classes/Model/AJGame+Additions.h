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

- (NSDictionary *)toDictionary;

@end
