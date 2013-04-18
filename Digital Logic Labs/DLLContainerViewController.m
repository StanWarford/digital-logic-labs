//
//  DLLContainerViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLContainerViewController.h"
#import "DLLTestViewController.h"

@interface DLLContainerViewController ()
- (void)swipeLeftSegue:(UISwipeGestureRecognizer*)recogizer;
- (void)swipeRightSegue:(UISwipeGestureRecognizer*)recognizer;
@end

@implementation DLLContainerViewController

#define NAV_BUTTON_SPACING 50 // defines pixel spacing between programatically added nav bar items

@synthesize boardView = _boardView; // pointer to board subview
@synthesize dockView = _dockView; // pointer to dock subview
@synthesize boardModel = _boardModel; // pointer to model

#pragma mark -
#pragma mark view initialization methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // instantiate the subviews to be added
    self.boardView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIBoardViewBoard"];
    self.boardView.boardModel = self.boardModel;
    self.boardView.parent = self;
    self.dockView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIDockViewDock"];
    self.dockView.boardModel = self.boardModel;
    self.dockView.parent = self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dock"]];
    
    // move the instantiated frames to their correct positions on screen
    CGRect initialBoardFrame = self.boardView.view.frame;
    CGRect initialDockFrame = self.dockView.view.frame;
    initialBoardFrame.origin.x = 0;
    initialBoardFrame.origin.y = 0;
    initialDockFrame.origin.x = 0;
    initialDockFrame.origin.y = 634;
    
    [self.boardView.view setFrame:initialBoardFrame];
    [self.dockView.view setFrame:initialDockFrame];
    
    imageView.frame = CGRectMake(0, 634, imageView.frame.size.width, imageView.frame.size.height);
    
    // set dockView delegate to be boardView
    self.dockView.delegate = self.boardView;
    
    // add the subviews as children
    [self addChildViewController:self.boardView];
    [self addChildViewController:self.dockView];
    
    // display the subviews
    [self.view addSubview:self.boardView.view];
    [self.view addSubview:self.dockView.view];
    [self.view addSubview:imageView];
    
    // add buttons to navigation bar
    UIBarButtonItem *testButton = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStyleBordered target:self action:@selector(goToTestScreen)];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear Board" style:UIBarButtonItemStyleBordered target:self action:@selector(clearBoard)];
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:nil action:nil];
    fixedSpaceBarButtonItem.width = NAV_BUTTON_SPACING;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:testButton, fixedSpaceBarButtonItem, clearButton, nil];
    
    // setup 2 finger swipe left/right gesture recognizers
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightSegue:)];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftSegue:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeLeft setDelaysTouchesBegan:YES];
    [swipeRight setDelaysTouchesBegan:YES];
    [swipeLeft setNumberOfTouchesRequired:2];
    [swipeRight setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
}

#pragma mark -
#pragma mark target action methods
// called when user presses clear board
- (void) clearBoard
{
    // create and show an alert view
    UIAlertView *alert = [[UIAlertView alloc]
                           initWithTitle:@"Are you sure?"
                           message:@"Are you sure that you want to clear the board?"
                           delegate:self
                           cancelButtonTitle:@"Cancel"
                           otherButtonTitles:@"OK", nil];
    [alert show];
}

// called when user presses test button
- (IBAction)goToTestScreen
{
    [self performSegueWithIdentifier:@"BoardToTestSegue" sender:self];
}

#pragma mark -
#pragma mark segue control methods
// pass the board model on to the test screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"BoardToTestSegue"]){
        DLLTestViewController *controller = (DLLTestViewController*)segue.destinationViewController;
        controller.boardModel = self.boardModel;
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate protocol methods
// responds to events in the alertview shown when user presses clear board
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) { // User pressed OK
        [self.boardView clearBoard];
    }else{ // user pressed cancel
        // do nothing
    }
}

#pragma mark -
#pragma mark gesture recognizer responder methods
- (void)swipeLeftSegue:(UISwipeGestureRecognizer *)recogizer
{
    [self performSegueWithIdentifier:@"BoardToTestSegue" sender:self];
}

- (void)swipeRightSegue:(UISwipeGestureRecognizer *)recognizer
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark MISC
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // nothing to deallocate
}

@end
