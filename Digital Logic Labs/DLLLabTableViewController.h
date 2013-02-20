//
//  DLLLabTableViewController.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/13/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLLabTableViewController : UITableViewController <UITableViewDataSource>

@property(nonatomic, assign) id<UITableViewDelegate> delegate;

@end
