//
//  DLLChipDetailPopover.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 4/5/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLChipDetailPopover : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, assign) NSInteger identifier;

@end
