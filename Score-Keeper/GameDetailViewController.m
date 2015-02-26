//
//  GameDetailViewController.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 2/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GameDetailViewController.h"
#import "GameDetailViewDataSource.h"
#import "GameController.h"

@interface GameDetailViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet GameDetailViewDataSource *dataSource;

@end

@implementation GameDetailViewController

- (IBAction)addPlayer:(UIBarButtonItem *)sender {
    [[GameController sharedInstance] addPlayerToGame:self.game];
    
    [self.dataSource updateWithGame:self.game];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.game.name;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithGame:(Game *)game {
    self.game = game;
    [self.dataSource updateWithGame:game];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
