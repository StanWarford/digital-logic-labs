//
//  DLLSplitViewController.m
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/20/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLSplitViewController.h"

@interface DLLSplitViewController ()

@end

@implementation DLLSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DLLLabTableViewController *tableView = [self.viewControllers objectAtIndex:0];
    DLLPDFViewController *pdfView = [self.viewControllers objectAtIndex:1];
    tableView.delegate = pdfView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
