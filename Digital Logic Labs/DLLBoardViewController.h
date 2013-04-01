//
//  DLLBoardViewController.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLDockViewController.h"
#import "DLLBoard.h"
#import "DLLAComponentView.h"
#import "DLLTestViewController.h"
#import "DLLPoint.h"

@interface DLLBoardViewController : UIViewController <DLLDockViewControllerDelegate>

@property (nonatomic, weak) DLLBoard *boardModel;

@end
