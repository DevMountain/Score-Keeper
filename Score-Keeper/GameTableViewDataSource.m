//
//  GameTableViewDataSource.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GameTableViewDataSource.h"
#import "GameController.h"
@import UIKit;

@interface GameTableViewDataSource () <UITableViewDataSource>

@end

@implementation GameTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameCell"];
    
    Game *game = [[GameController sharedInstance].games objectAtIndex:indexPath.row];
    
    cell.textLabel.text = game.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[GameController sharedInstance] removeGame:[[GameController sharedInstance].games objectAtIndex:indexPath.row]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [GameController sharedInstance].games.count;
}

@end
