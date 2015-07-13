//
//  PlayerTableViewCell.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 7/13/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerTableViewCell : UITableViewCell

@property (strong, nonatomic) UITextField *playerNameField;
@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIStepper *scoreStepper;

- (void)updateWithPlayer:(Player *)player;

@end
