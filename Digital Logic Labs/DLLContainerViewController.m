//
//  DLLContainerViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLContainerViewController.h"

@interface DLLContainerViewController ()

@end

@implementation DLLContainerViewController

@synthesize boardView = _boardView;
@synthesize dockView = _dockView;
@synthesize boardModel = _boardModel;

#pragma mark -
#pragma mark property instantiation
- (DLLBoard*)boardModel
{
    if (!_boardModel){
        _boardModel = [[DLLBoard alloc] init];
    }
    return _boardModel;
}

#pragma mark -
#pragma mark view initialization code
- (void)viewDidLoad
{
    [super viewDidLoad];
    // instantiate the two subviews to be added
    self.boardView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIBoardViewBoard"];
    self.boardView.boardModel = self.boardModel;
    self.dockView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIDockViewDock"];
    self.dockView.boardModel = self.boardModel;
    
    // move the instantiated frames to their correct positions on screen
    CGRect initialBoardFrame = self.boardView.view.frame;
    CGRect initialDockFrame = self.dockView.view.frame;
    CGAffineTransform moveBoard = CGAffineTransformMakeTranslation(-20, 0);
    CGAffineTransform moveDock = CGAffineTransformMakeTranslation(-20, 634);
    self.boardView.view.frame = CGRectApplyAffineTransform(initialBoardFrame, moveBoard);
    self.dockView.view.frame = CGRectApplyAffineTransform(initialDockFrame, moveDock);
    
    // set dockView delegate to be boardView
    self.dockView.delegate = self.boardView;
    
    // add the subviews as children
    [self addChildViewController:self.boardView];
    [self addChildViewController:self.dockView];
    
    // display the subviews
    [self.view addSubview:self.boardView.view];
    [self.view addSubview:self.dockView.view];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
