//
//  SKScoreViewController.m
//  Score Keeper
//
//  Created by Joshua Howland on 5/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "SKScoreViewController.h"

static CGFloat margin = 20;
static CGFloat scoreViewHeight = 90;

@interface SKScoreViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *scoreLabels;

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
    
    // Set ViewController title to string
    self.title = @"Score Keeper";
    
    // Initialize scoreLabels array property
    self.scoreLabels = [NSMutableArray new];
    
    // Initialize scrollView, add to view, & set to ScrollView property
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // Call addScoreView 4 times, passing in index as parameter
    for (NSInteger i = 0; i < 4; i++) {
        [self addScoreView:i];
    }
}

- (void)addScoreView:(NSInteger)index {
    
    CGFloat nameFieldWidth = 90;
    CGFloat scoreFieldWidth = 60;
    CGFloat stepperButtonWidth = 90;
    
    CGFloat width = self.view.frame.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, index * scoreViewHeight, width, scoreViewHeight)];
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(margin, margin, nameFieldWidth, 44)];
    nameField.tag = -1000;
    // Set UITextfield delegate to the viewController in order to call textFieldShouldReturn
    nameField.delegate = self;
    nameField.placeholder = @"Name";
    [view addSubview:nameField];
    
    // We need to store the index we're adding as the tag of the text field so that we can find the corresponding button when the text changes
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin + nameFieldWidth, margin, scoreFieldWidth, 44)];
    scoreLabel.text = @"0";
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.scoreLabels addObject:scoreLabel];
    [view addSubview:scoreLabel];
    
    // We need to store the index we're adding as the tag of the button so we can find the corresponding text when the user taps the button
    UIStepper *scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(60 + nameFieldWidth + scoreFieldWidth, 30, stepperButtonWidth, 44)];
    scoreStepper.maximumValue = 1000;
    scoreStepper.minimumValue = -1000;
    scoreStepper.tag = index;
    
    // Add scoreStepperChanged method as the action when scoreStepper's value changes
    [scoreStepper addTarget:self action:@selector(scoreStepperChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:scoreStepper];
    
    // Initialize separator UIView at the bottom of view that stretches across the width of the screen
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, scoreViewHeight - 1, self.view.frame.size.width, 1)];
    separator.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:separator];
    
    // Add the view that contains nameField, scoreLabel, scoreStepper, and separator to scrollView
    [self.scrollView addSubview:view];
}

- (void)scoreStepperChanged:(id)sender {
   
    // Initialize stepper as the value passed in as the method parameter
    UIStepper *stepper = sender;
    
    // Initialize an NSInteger as the stepper tag value
    NSInteger index = stepper.tag;
    
    // Initialize double as stepper value (default is 0)
    double value = [stepper value];
    
    // Initialize UILabel as a scoreLabel from our scoreLabels array property with an index corresponding to the stepper on that line
    UILabel *scoreLabel = self.scoreLabels[index];

    // Update the label text with the new stepper value
    scoreLabel.text = [NSString stringWithFormat:@"%d", (int)value];
}

// UITextfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    // Remove keyboard for the UITextField passed in as parameter when return is pressed
    [textField resignFirstResponder];
    return YES;
}

@end
