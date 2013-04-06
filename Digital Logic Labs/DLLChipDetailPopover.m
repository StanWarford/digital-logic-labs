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

@synthesize webView = _webView;
@synthesize identifier = _identifier;

#pragma mark -
#pragma mark initialization methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setPDFPathByIdentifier:self.identifier];
    [self displayPage];
}

#pragma mark -
#pragma mark page display methods

#pragma mark -
#pragma mark uitility methods
- (void)displayPage
{
    NSURL *targetURL = [NSURL fileURLWithPath:self.pdfPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.webView loadRequest:request];
    [self.webView setScalesPageToFit:YES]; // enables zooming
}

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
    // Dispose of any resources that can be recreated.
}

@end
