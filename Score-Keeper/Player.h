//
//  Player.h
//  Score-Keeper
//
//  Created by Caleb Hicks on 7/13/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger score;

@end