//
//  DLLBoardViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoardViewController.h"

@interface DLLBoardViewController ()
@property (nonatomic, strong) DLLAComponentView *activeComponent;
@property (nonatomic, assign) BOOL isPlacingWire;
@property (nonatomic, assign) DLLAComponentView *selection;
- (DLLPoint*)nearestBoardCoordinateTo:(CGPoint)loc;
- (CGPoint)viewCoordinateFromBoardCoordinate:(DLLPoint*)loc;
@end

@implementation DLLBoardViewController

@synthesize activeComponent = _activeComponent;
@synthesize boardModel = _boardModel;
@synthesize selection = _selection;

NSMutableDictionary *dictionary = nil;
+ (void)initialize {
    dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  @"1", @"One",
                  @"2", @"Two",
                  @"3", @"Three",
                  nil];
    NSLog(@"dictionary = %@", dictionary);
}

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
- (void)selectionDidChange:(DLLAComponentView*)selection
{
    self.selection = selection;
}

#pragma mark -
#pragma mark Touch Recognition methods
// if something is touched, assume the user wants to edit its position and remove it immediately
// then begin placing the ghost image on screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSString *value = [dictionary objectForKey:@"One"];
    NSLog(value);
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled, this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    DLLPoint *boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];
    BOOL isEmpty = [self.boardModel boardStateAt:boardLoc] == nil;
    
    if(!isEmpty){
        // Query dictionary to find and remove correct chipview
        self.activeComponent = [self.boardModel removeComponentAtCoordinate:boardLoc];
        [self.activeComponent removeImageView];
    }else{
        // Ask the dock to instantiate and return the correct chipview class
        self.activeComponent = self.selection;
    }
    
    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.identifier];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    [self.activeComponent displayGhostInView:self.view withHoleAvailable:isAvailable];
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSString *value = [dictionary objectForKey:@"Two"];
    NSLog(value);
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    DLLPoint *boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];

    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.identifier];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    [self.activeComponent translateGhostImageTo:displayLoc withHoleAvailable:isAvailable];
}

// when the touch ends, query the model one more time before adding the element
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSString *value = [dictionary objectForKey:@"Three"];
    NSLog(value);
    
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    DLLPoint *boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];

    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.identifier];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    if(isAvailable){
        // Tell the active component to display itself
        [self.boardModel addChipWithPartNum:self.activeComponent atUpperLeftCornerCoordinate:boardLoc];
        [self.activeComponent displayComponentInView:self.view];
    }else{
        // tell the active component that the user canceled the add command and deallocate
        [self.activeComponent removeImageView];
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
- (DLLPoint*)nearestBoardCoordinateTo:(CGPoint)loc
{
    return [[DLLPoint alloc] initWithCoords:loc];
}

- (CGPoint)viewCoordinateFromBoardCoordinate:(DLLPoint*)loc
{
    return [loc CGPointFromCoords];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
