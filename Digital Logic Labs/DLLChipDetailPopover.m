//
//  DLLChipDetailPopover.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 4/5/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChipDetailPopover.h"

@interface DLLChipDetailPopover ()

@property (nonatomic, strong) NSString *pdfPath;
- (void)displayPage;
- (void)setPDFPathByIdentifier:(NSInteger)identifier;

@end

@implementation DLLChipDetailPopover

@synthesize webView = _webView; // pointer to webview to display pdfs
@synthesize identifier = _identifier; // currently selected pdf to read
@synthesize pdfPath = _pdfPath; // string for the path to pdf to read

#pragma mark -
#pragma mark initialization methods
// set the path to the correct pdf to display and display it
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setPDFPathByIdentifier:self.identifier];
    [self displayPage];
}

#pragma mark -
#pragma mark uitility methods
// get pdf to read and display it
- (void)displayPage
{
    NSURL *targetURL = [NSURL fileURLWithPath:self.pdfPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.webView loadRequest:request];
    [self.webView setScalesPageToFit:YES]; // enables zooming
}

// based on the identifier, set the global pdfPath variable
- (void)setPDFPathByIdentifier:(NSInteger)identifier
{
    switch (identifier)
    {
        case 7400:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7400" ofType:@"pdf" inDirectory:@""];
            break;
        case 7402:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7402" ofType:@"pdf" inDirectory:@""];
            break;
        case 7404:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7404" ofType:@"pdf" inDirectory:@""];
            break;
        case 7408:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7408" ofType:@"pdf" inDirectory:@""];
            break;
        case 7432:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7432" ofType:@"pdf" inDirectory:@""];
            break;
        case 7447:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7447" ofType:@"pdf" inDirectory:@""];
            break;
        case 7476:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7476" ofType:@"pdf" inDirectory:@""];
            break;
        case 7485:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7485" ofType:@"pdf" inDirectory:@""];
            break;
        case 7486:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"7486" ofType:@"pdf" inDirectory:@""];
            break;
        case 74151:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"74151" ofType:@"pdf" inDirectory:@""];
            break;
        case 74164:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"74164" ofType:@"pdf" inDirectory:@""];
            break;
        case 74176:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"74176-177" ofType:@"pdf" inDirectory:@""];
            break;
        case 74181:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"74181" ofType:@"pdf" inDirectory:@""];
            break;
        case 74711:
            self.pdfPath = [[NSBundle mainBundle] pathForResource:@"MAN71A" ofType:@"pdf" inDirectory:@""];
            break;
        default:
            self.pdfPath = @"";
            break;
    }
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.pdfPath = nil;
}

@end
