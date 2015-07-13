//
//  PlayerTableViewCell.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 7/13/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

#import "PlayerTableViewCell.h"

static CGFloat margin = 20;
static CGFloat elementHeight = 44;

@implementation PlayerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat nameFieldWidth = 120;
        CGFloat scoreFieldWidth = 60;
        CGFloat stepperButtonWidth = 90;
        
        self.playerNameField = [UITextField new];
        self.playerNameField.frame = CGRectMake(margin, margin, nameFieldWidth, elementHeight);
        self.playerNameField.placeholder = @"Name";
        [self.contentView addSubview:self.playerNameField];
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin + nameFieldWidth, margin, scoreFieldWidth, elementHeight)];
        self.scoreLabel.text = @"0";
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.scoreLabel];
        
        self.scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(60 + nameFieldWidth + scoreFieldWidth, 30, stepperButtonWidth, 44)];
        self.scoreStepper.maximumValue = 1000;
        self.scoreStepper.minimumValue = -1000;
        [self.scoreStepper addTarget:self action:@selector(scoreStepperChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.scoreStepper];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)scoreStepperChanged:(UIStepper *)stepper {
    
    int score = stepper.value;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
}

- (void)updateWithPlayer:(Player *)player {
    self.playerNameField.text = player.name;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)player.score];
    self.scoreStepper.value = player.score;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
