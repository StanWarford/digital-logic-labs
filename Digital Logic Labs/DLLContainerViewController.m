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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.boardView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIBoardViewBoard"];
    self.dockView = [self.storyboard instantiateViewControllerWithIdentifier:@"UIDockViewDock"];
    
    CGRect initialBoardFrame = self.boardView.view.frame;
    CGRect initialDockFrame = self.dockView.view.frame;
    CGAffineTransform moveBoard = CGAffineTransformMakeTranslation(-20, 0);
    CGAffineTransform moveDock = CGAffineTransformMakeTranslation(-20, 584);
    self.boardView.view.frame = CGRectApplyAffineTransform(initialBoardFrame, moveBoard);
    self.dockView.view.frame = CGRectApplyAffineTransform(initialDockFrame, moveDock);
    
    [self addChildViewController:self.boardView];
    [self addChildViewController:self.dockView];
    
    [self.view addSubview:self.boardView.view];
    [self.view addSubview:self.dockView.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
