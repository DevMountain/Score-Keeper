//
//  GameController.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GameController.h"
#import "Stack.h"

@implementation GameController

+ (GameController *)sharedInstance {
    static GameController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GameController new];
    });
    return sharedInstance;
}

- (NSArray *)games {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
}

- (Game *)createGameWithName:(NSString *)name {
    Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    game.name = name;
    
    [self save];
    return game;
}

- (void)removeGame:(Game *)game {
    [[Stack sharedInstance].managedObjectContext deleteObject:game];
    
    [self save];
}

- (void)addPlayerToGame:(Game *)game {
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];

    player.game = game;
    
    [self save];
}

- (void)removePlayer:(Player *)player {
    [[Stack sharedInstance].managedObjectContext deleteObject:player];
    
    [self save];
}


     
- (void)save {
    [[Stack sharedInstance].managedObjectContext save:NULL];
}


@end
