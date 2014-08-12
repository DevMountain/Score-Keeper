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

@property (nonatomic, strong) NSMutableArray *scoreViews;
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
    
    self.scoreViews = [NSMutableArray new];
    self.scoreFields = [NSMutableArray new];
    self.scoreButtons = [NSMutableArray new];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    [self addScoreView];
    
}

- (void)addScoreView {
    
    CGFloat nameFieldWidth = 90;
    CGFloat scoreFieldWidth = 60;
    CGFloat stepperButtonWidth = 90;
    
    NSInteger index = [self.scoreViews count];
    CGFloat width = self.view.frame.size.width;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, index * scoreViewHeight, width, scoreViewHeight)];
    
    // We set the nameField tag as -1000 so that we can ignore it when we set the score via the textfield

    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(margin, margin, nameFieldWidth, 44)];
    nameField.tag = -1000;
    nameField.delegate = self;
    nameField.placeholder = @"Name";
    [view addSubview:nameField];

    // We need to store the index we're adding as the tag of the text field so that we can find the corresponding button when the text changes
    
    UITextField *scoreField = [[UITextField alloc] initWithFrame:CGRectMake(margin + nameFieldWidth, margin, scoreFieldWidth, 44)];
    scoreField.tag = index;
    scoreField.delegate = self;
    scoreField.text = @"0";
    scoreField.textAlignment = NSTextAlignmentCenter;
    [self.scoreFields addObject:scoreField];
    [view addSubview:scoreField];
    

    // Black Diamond:
    scoreField.keyboardType = UIKeyboardTypeNumberPad;
    // Because we use the numberpad we need to add a done button to the textfield
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissButtonPressed:)];
    doneItem.tag = index;
    UIBarButtonItem *flexableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    [toolbar setItems:[NSArray arrayWithObjects:flexableItem,doneItem, nil]];
    scoreField.inputAccessoryView = toolbar;
    
    
    // We need to store the index we're adding as the tag of the button so we can find the corresponding text when the user taps the button

    UIStepper *scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(60 + nameFieldWidth + scoreFieldWidth, 30, stepperButtonWidth, 44)];
    scoreStepper.maximumValue = 1000;
    scoreStepper.minimumValue = -1000;
    scoreStepper.tag = index;
    [scoreStepper addTarget:self action:@selector(scoreStepperChanged:) forControlEvents:UIControlEventValueChanged];
    [self.scoreButtons addObject:scoreStepper];
    [view addSubview:scoreStepper];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, scoreViewHeight - 1, self.view.frame.size.width, 1)];
    separator.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:separator];
    
    [self.scoreViews addObject:view];
    [self.scrollView addSubview:view];
    
    [self updateButtonView];

}

- (void)updateButtonView {
    
    CGFloat buttonWidth = 130;

    if (!self.addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addButton setTitle:@"Add Player" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addScoreView) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:addButton];
        
        self.addButton = addButton;
    }
    
    self.addButton.frame = CGRectMake(20, ([self.scoreViews count] * scoreViewHeight) + 23, buttonWidth, 44);
    
    if (!self.removeButton) {
        
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [removeButton setTitle:@"Remove Player" forState:UIControlStateNormal];
        [removeButton addTarget:self action:@selector(removeLastScore) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:removeButton];
        
        self.removeButton = removeButton;
    }
    
    self.removeButton.frame = CGRectMake(170, ([self.scoreViews count] * scoreViewHeight) + 23, buttonWidth, 44);
    
    [self updateScrollViewContentSize];
}

- (void)removeLastScore {
    
    UIView *view = self.scoreViews.lastObject;
    [view removeFromSuperview];
    
    [self.scoreViews removeObject:view];
    
    [self updateButtonView];
}


- (void)scoreStepperChanged:(id)sender {

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

    return ([self.scoreViews count] + 1) * (scoreViewHeight);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSInteger value = [textField.text integerValue];
    UIStepper *stepper = self.scoreButtons[textField.tag];
    stepper.value = value;
    
    return YES;
}

- (void)dismissButtonPressed:(id)sender {
    
    UITextField *scoreField = self.scoreFields[[sender tag]];

    NSInteger value = [scoreField.text integerValue];
    UIStepper *stepper = self.scoreButtons[scoreField.tag];
    stepper.value = value;

    [scoreField resignFirstResponder];
    
}

@end
