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
@property (nonatomic, strong) NSDictionary *pointMap;
- (DLLPoint*)nearestBoardCoordinateTo:(CGPoint)loc;
- (CGPoint)viewCoordinateFromBoardCoordinate:(DLLPoint*)loc;
@end

@implementation DLLBoardViewController

@synthesize activeComponent = _activeComponent;
@synthesize boardModel = _boardModel;
@synthesize selection = _selection;
@synthesize pointMap = _pointMap;

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
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled, this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    DLLPoint *boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];
    BOOL isEmpty = [self.boardModel boardStateAt:boardLoc] == nil;
    
    // Remove any component the user touched, and assume the user wants to edit that component otherwise add a new component from the dock
    if(!isEmpty){
        // Query dictionary to find and remove correct chipview
        [self.boardModel removeComponentAtCoordinate:boardLoc];
        self.activeComponent = [self.pointMap objectForKey:boardLoc];
        [self.activeComponent removeImageView];
        NSArray *temp = [self.pointMap allKeysForObject:self.activeComponent];
        NSMutableDictionary *dict = [self.pointMap mutableCopy];
        for(NSValue *value in temp){
            [dict removeObjectForKey:value];
        }
        self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
    }else{
        // Instantiate a new chip based on dock selection
        self.activeComponent = [[[self.selection class] alloc] initChipOfSize:self.selection.size AtLocation:displayLoc];
    }
    
    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.size];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    [self.activeComponent displayGhostInView:self.view withHoleAvailable:isAvailable];
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    DLLPoint *boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];

    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.size];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    [self.activeComponent translateGhostImageTo:displayLoc withHoleAvailable:isAvailable];
}

// when the touch ends, query the model one more time before adding the element
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    DLLPoint *boardLoc = [self nearestBoardCoordinateTo:loc];
    CGPoint displayLoc = [self viewCoordinateFromBoardCoordinate:boardLoc];

    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.size];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    if(isAvailable){
        // Tell the active component to display itself and notify model
        [self.activeComponent displayComponentInView:self.view];
        [self.boardModel addChipWithPartNum:self.activeComponent.size atUpperLeftCornerCoordinate:boardLoc];
        
        // Set pointers in dictionary to the displayed object
        NSInteger x = displayLoc.x;
        NSInteger y = displayLoc.y;
        NSMutableDictionary *dict = [self.pointMap mutableCopy];
        for(int i = 0; i < self.activeComponent.size; i++){
            i < self.activeComponent.size/2 ? [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:CGPointMake(x+i, y)]] : [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:CGPointMake(x+i, y+1)]];
        }
        self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
    }else{
        // User requested invalid object placement, remove activeComponent from view
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
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger calcX = (x*62)/1024;
    NSInteger calcY = (y*62)/768;
    return [[DLLPoint alloc] initWithCoords:CGPointMake(calcX, calcY)];
}

- (CGPoint)viewCoordinateFromBoardCoordinate:(DLLPoint*)loc
{
    NSInteger x = loc.xCoord;
    NSInteger y = loc.yCoord;
    NSInteger calcX = (x*1024)/62;
    NSInteger calcY = (y*768)/62;
    return CGPointMake(calcX, calcY);
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
