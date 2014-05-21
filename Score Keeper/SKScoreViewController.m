//
//  SKScoreViewController.m
//  Score Keeper
//
//  Created by Joshua Howland on 5/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "SKScoreViewController.h"

static CGFloat scoreHeight = 90;
static CGFloat nameFieldWidth = 100;

@interface SKScoreViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *scores;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SKScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Score Keeper";
    self.scores = [NSMutableArray new];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self updateScrollViewContentSize];
    [self.view addSubview:scrollView];
    
    [self setupInitialScoreViews];
    
}

- (void)setupInitialScoreViews {

    [self addScoreView];

}

- (void)addScoreView {
    
    NSInteger index = [self.scores count];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, index * scoreHeight, self.view.frame.size.width, scoreHeight)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 23, nameFieldWidth, 44)];
    nameField.delegate = self;
    nameField.placeholder = @"Name";
    [view addSubview:nameField];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, scoreHeight - 1, self.view.frame.size.width, 1)];
    separator.backgroundColor = [UIColor darkGrayColor];
    [view addSubview:separator];
    
    [self.scores addObject:view];
    [self.view addSubview:view];
    
}

- (void)updateScrollViewContentSize {
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self scrollViewHeight]);
    
}

- (CGFloat)scrollViewHeight {
    
    return [self.scores count] * (scoreHeight + 1);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
