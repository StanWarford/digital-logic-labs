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
- (void)displayGhostChip:(NSInteger)chipNum atCoordinate:(CGPoint)coords withHoleAvailable:(BOOL)available;
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
// if something is touched, assume the user wants to edit its position and remove it immediately
// then begin placing the ghost image on screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject]; // with multitouch disabled, this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    BOOL availability = [self.model boardStateAt:loc] == EMPTY; // EMPTY defined in DLLBoard.h
    if(!availability){
        self.chipNumCache = [self.model removeComponentAtCoordinate:loc];
    }
    [self displayGhostChip:self.chipNumCache ? self.chipNumCache : self.selectedChip atCoordinate:loc withHoleAvailable:availability];
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    BOOL availability = [self.model boardStateAt:loc] == EMPTY; // EMPTY defined in DLLBoard.h
    [self displayGhostChip:self.chipNumCache ? self.chipNumCache : self.selectedChip atCoordinate:loc withHoleAvailable:availability];
}

// when the touch ends, query the model one more time before adding the element
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    BOOL availability = [self.model boardStateAt:loc] == EMPTY; // EMPTY defined in DLLBoard.h
    if(availability){
        [self.model addChipWithPartNum:self.chipNumCache ? self.chipNumCache : self.selectedChip atUpperLeftCornerCoordinate:loc];
    }
    // display a permanent chip on the board at loc
    self.chipNumCache = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    // in case an error occurs, cancel out all touch info
    self.chipNumCache = nil;
}

#pragma mark -
#pragma mark display methods
- (void)displayGhostChip:(NSInteger)chipNum atCoordinate:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    // Display a normal ghost image of the chip if it's available
    // Otherwise display a red shifted ghost image of the chip
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
