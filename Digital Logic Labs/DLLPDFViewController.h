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

@property (nonatomic, strong) IBOutlet UIWebView *myWebView;
- (void) selectionDidChangeTo:(NSInteger)selection;

@end
