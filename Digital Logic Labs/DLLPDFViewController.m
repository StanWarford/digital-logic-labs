//
//  DLLPDFViewController.m
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/13/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLPDFViewController.h"

@interface DLLPDFViewController ()
- (void)displayPageNamed:(NSString*)title ofType:(NSString*)type;
@end

@implementation DLLPDFViewController

#define FILE_TYPE @"pdf"

@synthesize myWebView = _myWebView;

#pragma mark -
#pragma mark view initialization methods
// begin by displaying lab 1
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayPageNamed:@"Lab1" ofType:FILE_TYPE];
}

#pragma mark -
#pragma mark DLLTableViewControllerDelegate methods
// lab selection in tableview changed, update pdf viewer and model
- (void)selectionDidChangeTo:(NSInteger)selection
{
    NSInteger offsetSelection = selection + 1;
    [self displayPageNamed:[NSString stringWithFormat:@"Lab%d", offsetSelection] ofType:FILE_TYPE];
    [self.boardModel labSelectionChangedTo:selection];
}

#pragma mark -
#pragma mark page display methods
// access webview and display given page
- (void)displayPageNamed:(NSString *)title ofType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:title ofType:type inDirectory:@""];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.myWebView loadRequest:request];
    [self.myWebView setScalesPageToFit:YES]; // enables zooming
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Nothing to deallocate
}

@end
