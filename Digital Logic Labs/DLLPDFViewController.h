//
//  DLLPDFViewController.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/13/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLLabTableViewController.h"
#import "DLLBoard.h"

@interface DLLPDFViewController : UIViewController <DLLLabTableViewControllerDelegate>

@property (nonatomic, weak) DLLBoard *boardModel;
@property (nonatomic, weak) IBOutlet UIWebView *myWebView;
@property (nonatomic, assign) NSInteger selection;
- (void) selectionDidChangeTo:(NSInteger)selection;

@end
