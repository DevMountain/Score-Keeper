//
//  GameController.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"

@interface GameController : NSObject

@property (strong, nonatomic, readonly) NSArray *games;

+ (GameController *)sharedInstance;
- (Game *)createGameWithName:(NSString *)name;
- (void)addPlayerToGame:(Game *)game;

- (void)removeGame:(Game *)game;
- (void)removePlayer:(Player *)player;

- (void)save;

@end
