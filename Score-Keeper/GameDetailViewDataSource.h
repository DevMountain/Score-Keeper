//
//  ScoreTableViewDataSource.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameController.h"

@interface GameDetailViewDataSource : NSObject

@property (strong, nonatomic) Game *game;

- (void)updateWithGame:(Game *)game;

@end
