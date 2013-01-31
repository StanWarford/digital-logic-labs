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
    CGAffineTransform zt = CGAffineTransformMakeTranslation(0, -20);
    self.boardView.view.frame = CGRectApplyAffineTransform(initialBoardFrame, zt);
    self.dockView.view.frame = CGRectApplyAffineTransform(initialDockFrame, zt);
    
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
