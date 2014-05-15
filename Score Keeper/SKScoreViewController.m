//
//  SKScoreViewController.m
//  Score Keeper
//
//  Created by Joshua Howland on 5/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "SKScoreViewController.h"

static CGFloat scoreHeight = 90;

@interface SKScoreViewController ()

@property (nonatomic, strong) NSMutableArray *scores;

@end

@implementation SKScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Score Keeper";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self scrollViewHeight]);
    [self.view addSubview:scrollView];
 
}

- (CGFloat)scrollViewHeight {
    return [self.scores count] * (scoreHeight + 1);
}

@end
