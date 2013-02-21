//
//  DLLPDFViewController.m
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/13/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLPDFViewController.h"


@interface DLLPDFViewController ()

@end

@implementation DLLPDFViewController

@synthesize myWebView = _myWebView;


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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Lab1" ofType:@"pdf" inDirectory:@""];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.myWebView loadRequest:request];
	// Do any additional setup after loading the view.
    // data source
    // delegate
}

- (void)selectionDidChangeTo:(NSInteger)selection
{
    NSInteger offsetSelection = selection + 1;
    NSString *path;
    
    // switch to determine path
    
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.myWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
