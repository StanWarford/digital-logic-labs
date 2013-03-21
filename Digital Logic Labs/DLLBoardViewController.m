//
//  DLLBoardViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoardViewController.h"

typedef enum{
    notWire, // user is not placing a wire
    wireStart, // user is placing the start of a wire
    wireEnd // user is placing the end of a wire
} placementState;

@interface DLLBoardViewController ()
@property (nonatomic, strong) DLLAComponentView *activeComponent;
@property (nonatomic, strong) NSDictionary *pointMap;
@property (nonatomic, strong) DLLAComponentView *selection;
@property (nonatomic, assign) placementState state;
- (DLLPoint*)nearestBoardCoordinateTo:(CGPoint)loc;
- (CGPoint)viewCoordinateFromBoardCoordinate:(DLLPoint*)loc;
- (void)removeComponentFromPointMap:(DLLAComponentView*)component;
@end

@implementation DLLBoardViewController

@synthesize activeComponent = _activeComponent;
@synthesize pointMap = _pointMap;
@synthesize selection = _selection;
@synthesize boardModel = _boardModel;
@synthesize state = _state;

#pragma mark -
#pragma mark Initialization Metods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.multipleTouchEnabled = NO;
    self.activeComponent = nil;
    self.state = notWire;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set frame height to 634
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 634);
    
    CGRect viewBounds = [self.view bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    NSLog([NSString stringWithFormat:@"%f x %f", viewBounds.size.width * scale, viewBounds.size.height * scale]);
    
    // set background image
    UIImage *sourceBG = [UIImage imageNamed:@"breadboard-new"];
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
    
    if(self.state == notWire){ // user has not placed a wire
        // Remove any component the user touched, and assume the user wants to edit that component otherwise add a new component from the dock
        if(!isEmpty){
            // Query dictionary to find and remove correct chipview
            [self.boardModel removeComponentAtCoordinate:boardLoc];
            self.activeComponent = [self.pointMap objectForKey:boardLoc];
            [self removeComponentFromPointMap:self.activeComponent];
            [self.activeComponent removeGraphics];
        }else{ // spot is not empty
            // Instantiate a new chip or wire based on dock selection
            if([self.selection isKindOfClass:[DLLChipView class]]){
                self.activeComponent = [[[self.selection class] alloc] initChipOfSize:self.selection.size AtLocation:displayLoc inView:self.view];
            }else{
                self.activeComponent = [[[self.selection class] alloc] initWireWithStartAt:displayLoc withColor:self.selection.color inView:self.view];
            }
        }
        self.state = [self.activeComponent isKindOfClass:[DLLWireView class]] ? wireStart : notWire;
        
        BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize:self.activeComponent.size];
        NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
        
        [self.activeComponent displayGhostWithHoleAvailable:isAvailable];
    }else{ // wireEnd - user is placing end of wire
        BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize:self.activeComponent.size];
        BOOL didTouchStart = NO; // True if user touched the start of the wire false otherwise
        if(didTouchStart){
            // change state back to wireStart and edit the start position of the wire
        }else{
            [self.activeComponent translateEndTo:displayLoc withHoleAvailable:isAvailable];
        
            [self.activeComponent displayGhostWithHoleAvailable:isAvailable];
        }
    }
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
    
    if(self.state == wireEnd){ // user is placing end of wire
        [self.activeComponent translateEndTo:displayLoc withHoleAvailable:isAvailable];
    }else{ // user is placing start of wire or not placing a wire
        [self.activeComponent translateStartTo:displayLoc withHoleAvailable:isAvailable];
    }
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
    
    if(self.state = notWire){ // user is not placing a wire
        if(isAvailable){
            // Tell the active component to display itself and notify model
            [self.activeComponent displayComponent];
            [self.boardModel addChipWithPartNum:self.activeComponent.size atUpperLeftCornerCoordinate:boardLoc];
            
            // Set pointers in dictionary to the displayed object
            NSInteger x = self.activeComponent.start.x;
            NSInteger y = self.activeComponent.start.y;
            NSMutableDictionary *dict = [self.pointMap mutableCopy];
            for(int i = 0; i < self.activeComponent.size; i++){
                i < self.activeComponent.size/2 ? [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:CGPointMake(x+i, y)]] : [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:CGPointMake(x+i, y+1)]];
            }
            self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
        }else{
            // User requested invalid object placement, remove activeComponent from view
            [self.activeComponent removeGraphics];
        }
        self.activeComponent = nil;
        
    }else if(self.state == wireStart){ // user is placing start of wire
        if(isAvailable){
            // add start of wire to pointMap
            NSMutableDictionary *dict = [self.pointMap mutableCopy];
            [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:self.activeComponent.start]];
            self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
            
            self.state = wireEnd;
        }else{
            [self.activeComponent removeGraphics];
            self.state = notWire;
            self.activeComponent = nil;
        }
        
    }else{ // user is placing end of wire
        if(isAvailable){
            [self.activeComponent displayComponent];
            [self.boardModel addWireFromPoint:[[DLLPoint alloc] initWithCoords:self.activeComponent.start] toPoint:[[DLLPoint alloc] initWithCoords:self.activeComponent.end] withColor:self.activeComponent.color];
            
            // set pointers in dictionary to the displayed object
            NSMutableDictionary *dict = [self.pointMap mutableCopy];
            [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:self.activeComponent.end]];
            self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
        }else{
            // user requested invalid object placement, remove activeComponent from view and dictionary
            [self.activeComponent removeGraphics];
            [self removeComponentFromPointMap:self.activeComponent];
        }
        self.state = notWire;
    }
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
#pragma mark utility methods
- (void)removeComponentFromPointMap:(DLLAComponentView *)component
{
    NSArray *temp = [self.pointMap allKeysForObject:component];
    NSMutableDictionary *dict = [self.pointMap mutableCopy];
    for(NSValue *value in temp){
        [dict removeObjectForKey:value];
    }
    self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
