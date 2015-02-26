//
//  ViewController.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GameViewController.h"
#import "GameController.h"
#import "GameDetailViewController.h"


@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addGame"]) {
        GameDetailViewController *gameDetailViewController = segue.destinationViewController;
        
        [gameDetailViewController updateWithGame:[[GameController sharedInstance] createGameWithName:@"Game"]];
    }
    
    if ([segue.identifier isEqualToString:@"gameTapped"]) {
        UITableViewCell *cell = sender;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        GameDetailViewController *gameDetailViewController = segue.destinationViewController;
        
        [gameDetailViewController updateWithGame:[[GameController sharedInstance].games objectAtIndex:indexPath.row]];
    }
}

@end
