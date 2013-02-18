//
//  DLLContainerViewController.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLBoardViewController.h"
#import "DLLDockViewController.h"
#import "DLLBoard.h"

@interface DLLContainerViewController : UIViewController

// pointers to the two subviews that will be added to this container
@property (nonatomic, strong) DLLBoardViewController *boardView;
@property (nonatomic, strong) DLLDockViewController *dockView;
@property (nonatomic, strong) DLLBoard *boardModel;

@end
