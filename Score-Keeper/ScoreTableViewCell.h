//
//  ScoreTableViewCell.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface ScoreTableViewCell : UITableViewCell

- (void)updateWithPlayer:(Player *)player;

@end
