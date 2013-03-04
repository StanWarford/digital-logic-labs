//
//  DLLBoardViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoardViewController.h"

@interface DLLBoardViewController ()
@property (nonatomic, strong) DLLAComponent *activeComponent;
@property (assign, nonatomic) BOOL isPlacingWire;
@property (nonatomic, assign) NSInteger selection;
- (CGPoint)nearestBoardCoordinateTo:(CGPoint)loc;
- (CGPoint)viewCoordinateFromBoardCoordinate:(CGPoint)loc;
@end

@implementation DLLBoardViewController

@synthesize activeComponent = _activeComponent;
@synthesize boardModel = _boardModel;
@synthesize selection = _selection;

#pragma mark -
#pragma mark Initialization Metods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
- (void)selectionDidChange:(NSInteger)selection
{
    self.selection = selection;
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
    CGPoint boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];
    BOOL isEmpty = [self.boardModel boardStateAt:boardLoc] == EMPTY;
    
/***** Casey - This chunk will be affected by the view model and chipview changes *****/
    if(!isEmpty){
        // Query dictionary to find and remove correct chipview
        self.activeComponent = [self.boardModel removeComponentAtCoordinate:loc];
        //[self.activeComponent removeImageView];
    }else{
        // Ask the view model to instantiate and return the correct chipview class
        self.activeComponent = [self.boardModel getNewComponentFromInventoryIndex:self.selection];
    }
    
    BOOL isAvailable = [self.boardModel cellAt:loc IsAvailableForChip:self.activeComponent.identifier OfType:self.activeComponent.type];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    //[self.activeComponent displayGhostInView:self.view atCoordinates:displayLoc withHoleAvailable:isAvailable];
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    CGPoint boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];

/***** Casey - This chunk will be affected by the view model and chipview changes *****/
    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForChip:self.activeComponent.identifier OfType:self.activeComponent.type];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    // This code will work once activecomponent is a DLLAComponentView
    //[self.activeComponent translateGhostImageTo:displayLoc withHoleAvailable:isAvailable];
}

// when the touch ends, query the model one more time before adding the element
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    CGPoint boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];

/***** Casey - This chunk will be affected by the view model and chipview changes *****/
    BOOL isAvailable = [self.boardModel cellAt:loc IsAvailableForChip:self.activeComponent.identifier OfType:self.activeComponent.type];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    if(isAvailable){
        // Tell the active component to display itself
        [self.boardModel addChipWithPartNum:self.activeComponent.identifier atUpperLeftCornerCoordinate:boardLoc];
        //[self.activeComponent displayComponentInView:self.view atCoordinates:displayLoc];
    }else{
        // tell the active component that the user canceled the add command and deallocate
        //[self.activeComponent removeImageView];
    }
    
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
