//
//  ViewController.m
//  Score-Keeper
//
//  Created by Caleb Hicks on 7/13/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

#import "ViewController.h"
#import "PlayerTableViewCell.h"
#import "PlayerController.h"
#import "Player.h"

static NSString * const PlayerCellKey = @"playerCell";

CGFloat CellHeight = 90;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PlayerController *playerController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Score Keeper";
    
    self.playerController = [PlayerController new];
    
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.frame;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    
    [self.tableView registerClass:[PlayerTableViewCell class] forCellReuseIdentifier:PlayerCellKey];
    
    [self.view addSubview:self.tableView];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlayerCellKey];
    [cell updateWithPlayer:self.playerController.players[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playerController.players.count;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
