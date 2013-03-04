//
//  DLLPDFViewController.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/13/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLLabTableViewController.h"

@interface DLLPDFViewController : UIViewController <DLLLabTableViewControllerDelegate>

- (void) selectionDidChangeTo:(NSInteger)selection;

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end
