//
//  DLLBoardViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoardViewController.h"

@interface DLLBoardViewController ()

@end

@implementation DLLBoardViewController

@synthesize selectedChip = _selectedChip;
@synthesize testLabel = _testLabel;

#pragma mark -
#pragma mark Initialization Metods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.testLabel.text = [NSString stringWithFormat:@"%d", self.selectedChip ];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set frame height to 634
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 634);
    
    // set background image
    UIImage *sourceBG = [UIImage imageNamed:@"breadboard"];
    CGSize bgSize = self.view.frame.size;
    
    UIGraphicsBeginImageContext(bgSize);
    [sourceBG drawInRect:CGRectMake(0,0,bgSize.width,bgSize.height)];
    UIImage *resizedBG = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:resizedBG];
}

#pragma mark -
#pragma mark DLLDockViewControllerDelegate methods
- (void)selectionDidChange:(NSInteger)selection
{
    self.selectedChip = selection;
    self.testLabel.text = [NSString stringWithFormat:@"%d", self.selectedChip];
}

#pragma mark -
#pragma mark Gesture Recognition methods
- (IBAction)dragDetected:(UIPanGestureRecognizer*)sender
{
    // do something...
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
