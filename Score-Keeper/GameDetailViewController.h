//
//  GameDetailViewController.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface GameDetailViewController : UIViewController

@property (strong, nonatomic) Game *game;

- (void)updateWithGame:(Game *)game;

@end
