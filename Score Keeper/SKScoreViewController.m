//
//  SKScoreViewController.m
//  Score Keeper
//
//  Created by Joshua Howland on 5/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "SKScoreViewController.h"

static CGFloat scoreHeight = 90;
static CGFloat nameFieldWidth = 90;
static CGFloat scoreFieldWidth = 60;
static CGFloat stepperButtonWidth = 90;

static CGFloat buttonWidth = 130;

@interface SKScoreViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *scores;
@property (nonatomic, strong) NSMutableArray *scoreFields;
@property (nonatomic, strong) NSMutableArray *scoreButtons;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *removeButton;

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
    self.scoreFields = [NSMutableArray new];
    self.scoreButtons = [NSMutableArray new];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    [self updateScrollViewContentSize];
    [self setupInitialScoreViews];
    
}

- (void)setupInitialScoreViews {

    [self addScoreView];

}

- (void)addScoreView {
    
    NSInteger index = [self.scores count];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, index * scoreHeight, self.view.frame.size.width, scoreHeight)];
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 23, nameFieldWidth, 44)];
    nameField.delegate = self;
    nameField.placeholder = @"Name";
    [view addSubview:nameField];

    // We need to store the index we're adding as the tag of the text field so that we can find the corresponding button when the text changes
    
    UITextField *scoreField = [[UITextField alloc] initWithFrame:CGRectMake(20 + nameFieldWidth, 23, scoreFieldWidth, 44)];
    scoreField.tag = index;
    scoreField.delegate = self;
    scoreField.text = @"0";
    scoreField.keyboardType = UIKeyboardTypeNumberPad;
    scoreField.textAlignment = NSTextAlignmentCenter;
    [self.scoreFields addObject:scoreField];
    [view addSubview:scoreField];
    
    // We need to store the index we're adding as the tag of the button so we can find the corresponding text when the user taps the button

    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(60 + nameFieldWidth + scoreFieldWidth, 30, stepperButtonWidth, 44)];
    stepper.maximumValue = 1000;
    stepper.minimumValue = -1000;
    stepper.tag = index;
    [stepper addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];
    [self.scoreButtons addObject:stepper];
    [view addSubview:stepper];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, scoreHeight - 1, self.view.frame.size.width, 1)];
    separator.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:separator];
    
    [self.scores addObject:view];
    [self.scrollView addSubview:view];
    
    [self updateButtonView];

}

- (void)updateButtonView {
    
    if (!self.addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addButton setTitle:@"Add Player" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addScoreView) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:addButton];
        
        self.addButton = addButton;
    }
    
    self.addButton.frame = CGRectMake(20, ([self.scores count] * scoreHeight) + 23, buttonWidth, 44);
    
    if (!self.removeButton) {
        
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [removeButton setTitle:@"Remove Player" forState:UIControlStateNormal];
        [removeButton addTarget:self action:@selector(removeLastScore) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:removeButton];
        
        self.removeButton = removeButton;
    }
    
    self.removeButton.frame = CGRectMake(170, ([self.scores count] * scoreHeight) + 23, buttonWidth, 44);
    
    [self updateScrollViewContentSize];
}

- (void)removeLastScore {
    
    UIView *view = self.scores.lastObject;
    [view removeFromSuperview];
    
    [self.scores removeObject:view];
    
    [self updateButtonView];
}


- (void)stepperChanged:(id)sender {

    UIStepper *stepper = sender;
    NSInteger index = stepper.tag;
    double value = [stepper value];

    UITextField *scoreField = self.scoreFields[index];
    scoreField.text = [NSString stringWithFormat:@"%d", (int)value];

}

- (void)updateScrollViewContentSize {
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self scrollViewContentHeight]);
    
}

- (CGFloat)scrollViewContentHeight {

    return ([self.scores count] + 1) * (scoreHeight);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSInteger value = [textField.text integerValue];
    UIStepper *stepper = [self.scoreButtons objectAtIndex:textField.tag];
    stepper.value = value;
    
    return YES;
}

@end
