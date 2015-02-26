//
//  Game.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSOrderedSet *players;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
