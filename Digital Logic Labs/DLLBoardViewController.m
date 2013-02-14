//
//  DLLBoardViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoardViewController.h"

@interface DLLBoardViewController ()
@property (assign, nonatomic) NSInteger chipNumCache;
@property (assign, nonatomic) NSInteger selectedChip;
- (void)displayChip:(NSInteger)chipNum atCoordinate:(CGPoint)coords;
@end

@implementation DLLBoardViewController

@synthesize selectedChip = _selectedChip;
@synthesize testLabel = _testLabel;
@synthesize model = _model;
@synthesize chipNumCache = _chipNumCache;

#pragma mark -
#pragma mark Initialization Metods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.testLabel.text = [NSString stringWithFormat:@"%d", self.selectedChip ];
    self.view.multipleTouchEnabled = NO;
    self.model = [[DLLBoard alloc] init];
    self.chipNumCache = nil;
    if(nil){
        NSLog(@"Nil does not return false");
    }else{
        NSLog(@"Nil does return false");
    }
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
    
    /*
    BOOL retVal = [self.model isConnectionAvailableAt:CGPointMake(1,1)];
    self.testLabel.text = retVal ? @"Yes" : @"No";
    NSLog(retVal ? @"Yes" : @"No");
    */
}

#pragma mark -
#pragma mark DLLDockViewControllerDelegate methods
- (void)selectionDidChange:(NSInteger)selection
{
    self.selectedChip = selection;
    self.testLabel.text = [NSString stringWithFormat:@"%d", self.selectedChip];
}

#pragma mark -
#pragma mark Touch Recognition methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject]; // with multitouch disabled, this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    if(![self.model isConnectionAvailableAt:loc]){
        self.chipNumCache = [self.model removeComponentAtCoordinate:loc];
    }
    [self displayChip:self.chipNumCache ? self.chipNumCache : self.selectedChip atCoordinate:loc];
}

#pragma mark -
#pragma mark display methods
- (void)displayChip:(NSInteger)chipNum atCoordinate:(CGPoint)coords
{
    
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
