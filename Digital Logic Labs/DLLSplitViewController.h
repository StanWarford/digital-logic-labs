//
//  DLLSplitViewController.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/20/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLLabTableViewController.h"
#import "DLLPDFViewController.h"
#import "DLLBoard.h"
#import "DLLContainerViewController.h"

@interface DLLSplitViewController : UISplitViewController

@property (nonatomic, strong) DLLBoard *boardModel;

@end
