//
//  DLLBoardViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoardViewController.h"

@interface DLLBoardViewController ()
@property (nonatomic, strong) DLLAComponent *selectedChip;
@property (nonatomic, strong) DLLAComponent *activeComponent;
@property (assign, nonatomic) BOOL isPlacingWire;
- (CGPoint)nearestBoardCoordinateTo:(CGPoint)loc;
- (CGPoint)viewCoordinateFromBoardCoordinate:(CGPoint)loc;
@end

@implementation DLLBoardViewController

@synthesize selectedChip = _selectedChip;
@synthesize activeComponent = _activeComponent;
@synthesize testLabel = _testLabel;
@synthesize boardModel = _boardModel;

#pragma mark -
#pragma mark Initialization Metods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.testLabel.text = [NSString stringWithFormat:@"%d", self.selectedChip.identifier];
    self.view.multipleTouchEnabled = NO;
    self.activeComponent = nil;
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
- (void)selectionDidChange:(DLLAComponent*)selection
{
    self.selectedChip = selection;
    self.testLabel.text = [NSString stringWithFormat:@"%d", self.selectedChip.identifier];
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
    BOOL isEmpty = [self.boardModel boardStateAt:loc] == EMPTY;
    if(!isEmpty){
        self.activeComponent = [self.boardModel removeComponentAtCoordinate:loc];
    }else{
        self.activeComponent = self.selectedChip;
    }
    BOOL isAvailable = [self.boardModel cellAt:loc IsAvailableForChip:self.activeComponent.identifier OfType:self.activeComponent.type];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    [self.activeComponent displayGhostInView:self.view atCoordinates:loc withHoleAvailable:isAvailable];
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    BOOL isAvailable = [self.boardModel cellAt:loc IsAvailableForChip:self.activeComponent.identifier OfType:self.activeComponent.type];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    [self.activeComponent displayGhostInView:self.view atCoordinates:loc withHoleAvailable:isAvailable];
}

// when the touch ends, query the model one more time before adding the element
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    BOOL isAvailable = [self.boardModel cellAt:loc IsAvailableForChip:self.activeComponent.identifier OfType:self.activeComponent.type];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    if(isAvailable){
        [self.boardModel addChipWithPartNum:self.activeComponent.identifier atUpperLeftCornerCoordinate:loc];
        [self.activeComponent displayComponentInView:self.view atCoordinates:loc];
    } // otherwise do nothing
    self.activeComponent = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    // in case an error occurs, cancel out all touch info
    self.activeComponent = nil;
}

#pragma mark -
#pragma mark display methods
- (CGPoint)nearestBoardCoordinateTo:(CGPoint)loc
{
    return loc;
}

- (CGPoint)viewCoordinateFromBoardCoordinate:(CGPoint)loc
{
    return loc;
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
