//
//  PlayerController.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 7/13/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

#import "PlayerController.h"
#import "Player.h"

@implementation PlayerController

- (instancetype)init
{
    self = [super init];
    if (self) {
        Player *playerOne = [Player new];
        playerOne.name = @"Caleb Hicks";
        playerOne.score = 5;
        
        Player *playerTwo = [Player new];
        playerTwo.name = @"Alan Barth";
        playerTwo.score = 3;
        
        Player *playerThree = [Player new];
        playerThree.name = @"Wagner Pinto";
        playerThree.score = 4;
        
        Player *playerFour = [Player new];
        playerFour.name = @"Christian Monson";
        playerFour.score = 7;
        
        Player *playerFive = [Player new];
        playerFive.name = @"Taylor Mott";
        playerFive.score = 5;
        
        self.players = @[playerOne, playerTwo, playerThree, playerFour, playerFive];
    }
    return self;
}

@end
