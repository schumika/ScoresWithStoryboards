//
//  AJScoresManager.m
//  Scores
//
//  Created by Anca Calugar on 9/19/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "AJScoresManager.h"
#import "UIColor+Additions.h"
#import "AJGame+Additions.h"
#import "AJPlayer+Additions.h"

@interface AJScoresManager ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AJScoresManager

+ (id)sharedInstance {
    static dispatch_once_t once;
    static AJScoresManager *sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Scores" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Scores.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@ %@", error, error.userInfo);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Public methods
#pragma mark - Games methods

- (NSArray *)getGamesArray {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"rowId" ascending:NO]];
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (AJGame *)getGameWithRowId:(int)rowId {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rowId = %d", rowId];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"rowId" ascending:NO]];
    
    return [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
}

- (void)addGameWithName:(NSString *)name andRowId:(int)rowId {
    AJGame *game = [AJGame createGameWithName:name inManagedObjectContext:self.managedObjectContext];
    game.rowId = rowId;
    
    [self saveContext];
}

- (void)deleteGame:(AJGame *)game {
    [[self managedObjectContext] deleteObject:game];
    
    [self saveContext];
}

- (NSArray *)getAllPlayersForGame:(AJGame *)game {
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"AJPlayer"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game.name = %@ AND game.rowId = %@", game.name, game.rowId];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]];
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (AJPlayer *)createPlayerWithName:(NSString *)playerName forGame:(AJGame *)game {
    AJPlayer *player = [AJPlayer createPlayerWithName:playerName forGame:game];
    player.color = [[UIColor AJGreenColor] toHexString:YES];
    
    if (![self saveContext]) return nil;
    
    return player;
}

- (void)deletePlayer:(AJPlayer *)player {
    [[self managedObjectContext] deleteObject:player];
    
    [self saveContext];
}

- (void)deleteAllPlayersForGame:(AJGame *)game {
    NSArray *playersForGame = [self getAllPlayersForGame:game];
    
    for (AJPlayer *player in playersForGame) {
        [[self managedObjectContext] deleteObject:player];
    }
    
    [self saveContext];
}


#pragma mark - Other public methods

- (BOOL)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *mObjectContext = self.managedObjectContext;
    if (mObjectContext != nil) {
        if ([mObjectContext hasChanges] && ![mObjectContext save:&error]) {
            NSLog(@"Unresolved error %@ %@", error, error.userInfo);
            return NO;
        }
    }
    return YES;
}

#pragma mark - Private methods

// Returns the URL to the application's Document directory
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)insertDummyData {
    NSManagedObjectContext *context = self.managedObjectContext;
    /*NSManagedObject *game1 = [NSEntityDescription insertNewObjectForEntityForName:@"AJGame" inManagedObjectContext:context];
     [game1 setValue:[NSNumber numberWithInt:1] forKey:@"rowId"];
     [game1 setValue:@"Game1" forKey:@"name"];
     NSManagedObject *game2 = [NSEntityDescription insertNewObjectForEntityForName:@"AJGame" inManagedObjectContext:context];
     [game2 setValue:[NSNumber numberWithInt:2] forKey:@"rowId"];
     [game2 setValue:@"Game2" forKey:@"name"];*/
    
    /*AJGame *game1 = [AJGame createGameWithName:@"game1" inManagedObjectContext:context];
     game1.rowId = [NSNumber numberWithInt:1];*/
    
    [AJGame createGameWithName:@"game test" inManagedObjectContext:context];
    [AJGame createGameWithName:@"game test 2" inManagedObjectContext:context];
    [AJGame createGameWithName:@"game testc3" inManagedObjectContext:context];
    [AJGame createGameWithName:@"game test 5" inManagedObjectContext:context];
    
//    [AJPlayer createPlayerWithName:@"player 1" forGame:game2];
//    [AJPlayer createPlayerWithName:@"player 2" forGame:game2];
//    [AJPlayer createPlayerWithName:@"player 3" forGame:game2];
    
    [self saveContext];
}

@end
