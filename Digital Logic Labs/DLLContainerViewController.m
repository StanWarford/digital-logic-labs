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

@end

@implementation DLLContainerViewController

@synthesize boardView = _boardView;
@synthesize dockView = _dockView;
@synthesize boardModel = _boardModel;

#pragma mark -
#pragma mark view initialization methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // instantiate the subviews to be added
    self.boardView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIBoardViewBoard"];
    self.boardView.boardModel = self.boardModel;
    self.dockView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIDockViewDock"];
    self.dockView.boardModel = self.boardModel;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dock"]];
    
    // move the instantiated frames to their correct positions on screen
    CGRect initialBoardFrame = self.boardView.view.frame;
    CGRect initialDockFrame = self.dockView.view.frame;
    CGAffineTransform moveBoard = CGAffineTransformMakeTranslation(-20, 0);
    CGAffineTransform moveDock = CGAffineTransformMakeTranslation(-20, 634);
    self.boardView.view.frame = CGRectApplyAffineTransform(initialBoardFrame, moveBoard);
    self.dockView.view.frame = CGRectApplyAffineTransform(initialDockFrame, moveDock);
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
    
    
    
    UIBarButtonItem* testButton = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStyleBordered target:self action:@selector(goToTestScreen)];    
    [testButton respondsToSelector:@selector(goToTestScreen:)];
    
    UIBarButtonItem* clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear Board" style:UIBarButtonItemStyleBordered target:self action:@selector(clearButton)];    
    [clearButton respondsToSelector:@selector(clearBoard)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:testButton, clearButton, nil];
}



- (void) clearButton
{
    // tell boardviewcontroller to clear the board
}


- (IBAction)goToTestScreen
{
    DLLTestViewController *testView = [[DLLTestViewController alloc] init];
    [self performSegueWithIdentifier:@"BoardToTestSegue" sender:self];
}


#pragma mark -
#pragma mark MISC
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
