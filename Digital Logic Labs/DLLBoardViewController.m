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
- (CGPoint)gridCoordinateFromViewCoordinate:(CGPoint)loc;
- (CGPoint)viewCoordinateFromGridCoordinate:(CGPoint)loc;
- (DLLPoint*)boardCoordinateFromGridCoordinate:(CGPoint)loc;
- (CGPoint)gridCoordinateFromBoardCoordinate:(DLLPoint*)loc;
- (void)removeComponentFromPointMap:(DLLAComponentView*)component;
@end

@implementation DLLBoardViewController

#define HORIZONTAL_BOARD_SPACING 11.9
#define VERTICAL_BOARD_SPACING 12.2

#define HORIZONTAL_BOARD_OFFSET 6
#define VERTICAL_BOARD_OFFSET 7

#define VIEW_HEIGHT 634
#define VIEW_WIDTH 1024

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
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, VIEW_HEIGHT);
    
    // set background image
    UIImage *sourceBG = [UIImage imageNamed:@"board-new-resized.png"];
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
    CGPoint gridLoc = [self gridCoordinateFromViewCoordinate:loc];
    CGPoint snapLoc = [self viewCoordinateFromGridCoordinate:gridLoc];
    DLLPoint* boardLoc = [self boardCoordinateFromGridCoordinate:gridLoc];
    BOOL isEmpty = [self.boardModel boardStateAt:boardLoc] == nil;
    
    if(self.state == notWire){ // user has not placed a wire
        // Remove any component the user touched, and assume the user wants to edit that component otherwise add a new component from the dock
        if(!isEmpty){
            // Query dictionary to find and remove correct chipview
            [self.boardModel removeComponentAtCoordinate:boardLoc];
            self.activeComponent = [self.pointMap objectForKey:boardLoc];
            [self removeComponentFromPointMap:self.activeComponent];
            [self.activeComponent removeGraphics];
        }else{ // spot is empty
            // Instantiate a new chip or wire based on dock selection
            if([self.selection isKindOfClass:[DLLChipView class]]){
                self.activeComponent = [[[self.selection class] alloc] initChipAtLocation:snapLoc inView:self.view withID:[self.selection identifier]];
            }else{
                self.activeComponent = [[[self.selection class] alloc] initWireWithStartAt:snapLoc withColor:self.selection.color inView:self.view];
            }
        }
        self.state = [self.activeComponent isKindOfClass:[DLLWireView class]] ? wireStart : notWire;
        
        BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize:self.activeComponent.size];
        //NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
        
        [self.activeComponent displayGhostWithHoleAvailable:isAvailable];
    }else{ // wireEnd - user is placing end of wire
        BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize:self.activeComponent.size];
        BOOL didTouchStart = NO; // True if user touched the start of the wire false otherwise
        if(didTouchStart){
            // change state back to wireStart and edit the start position of the wire
        }else{
            [self.activeComponent translateEndTo:snapLoc withHoleAvailable:isAvailable];
        }
    }
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    CGPoint gridLoc = [self gridCoordinateFromViewCoordinate:loc];
    CGPoint snapLoc = [self viewCoordinateFromGridCoordinate:gridLoc];
    DLLPoint *boardLoc = [self boardCoordinateFromGridCoordinate:gridLoc];
    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.size];
    NSLog([NSString stringWithFormat:@"%@", isAvailable? @"YES" : @"NO"]);
    
    //NSLog([NSString stringWithFormat:@"Board: (%i, %i)", (NSInteger)boardLoc.xCoord, (NSInteger)boardLoc.yCoord]);
    
    if(self.state == wireEnd){ // user is placing end of wire
        [self.activeComponent translateEndTo:snapLoc withHoleAvailable:isAvailable];
    }else{ // user is placing start of wire or not placing a wire
        [self.activeComponent translateStartTo:snapLoc withHoleAvailable:isAvailable];
    }
}

// when the touch ends, query the model one more time before adding the element
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint loc = [touch locationInView:self.view];
    CGPoint gridLoc = [self gridCoordinateFromViewCoordinate:loc];
    CGPoint snapLoc = [self viewCoordinateFromGridCoordinate:loc];
    DLLPoint *boardLoc = [self boardCoordinateFromGridCoordinate:gridLoc];

    BOOL isAvailable = [self.boardModel cellAt:boardLoc IsAvailableForComponentOfSize: self.activeComponent.size];
    
    if(self.state == notWire){ // user is not placing a wire
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
- (CGPoint)gridCoordinateFromViewCoordinate:(CGPoint)loc
{
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger calcX = abs(floor((x - HORIZONTAL_BOARD_OFFSET)/HORIZONTAL_BOARD_SPACING));
    NSInteger calcY = abs(floor((y - VERTICAL_BOARD_OFFSET)/VERTICAL_BOARD_SPACING));
    return CGPointMake(calcX, calcY);
}

- (CGPoint)viewCoordinateFromGridCoordinate:(CGPoint)loc
{
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger calcX = x*HORIZONTAL_BOARD_SPACING + HORIZONTAL_BOARD_OFFSET;
    NSInteger calcY = y*VERTICAL_BOARD_SPACING + VERTICAL_BOARD_OFFSET;
    return CGPointMake(calcX, calcY);
}

- (DLLPoint*)boardCoordinateFromGridCoordinate:(CGPoint)loc
{
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger retX;
    NSInteger retY;
    NSArray *yGridPoints = [[NSArray alloc] initWithObjects:
                            [NSNumber numberWithInt:23],
                            [NSNumber numberWithInt:24],
                            [NSNumber numberWithInt:28],
                            [NSNumber numberWithInt:29],
                            [NSNumber numberWithInt:30],
                            [NSNumber numberWithInt:31],
                            [NSNumber numberWithInt:32],
                            [NSNumber numberWithInt:35],
                            [NSNumber numberWithInt:36],
                            [NSNumber numberWithInt:37],
                            [NSNumber numberWithInt:38],
                            [NSNumber numberWithInt:39],
                            [NSNumber numberWithInt:44],
                            [NSNumber numberWithInt:45],
                            [NSNumber numberWithInt:49],
                            [NSNumber numberWithInt:50],
                            [NSNumber numberWithInt:51],
                            [NSNumber numberWithInt:52],
                            [NSNumber numberWithInt:53],
                            [NSNumber numberWithInt:56],
                            [NSNumber numberWithInt:57],
                            [NSNumber numberWithInt:58],
                            [NSNumber numberWithInt:59],
                            [NSNumber numberWithInt:60],
                            [NSNumber numberWithInt:64],
                            [NSNumber numberWithInt:65],
                            nil];
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 0; i < [yGridPoints count]; i++){
        [temp addObject:[NSNumber numberWithInt:i]];
    }
    NSArray *yBoardPoints = [NSArray arrayWithArray:temp];
    NSDictionary *yGridToBoardPoints = [NSDictionary dictionaryWithObjects:yBoardPoints forKeys:yGridPoints];
    if(x < 8 || x > 70 || y < 23 || y > 65){
        retX = 99; // trash point
        retY = 99; // trash point
    }else{
        if((y > 24 && y < 28) ||
           (y > 32 && y < 35) ||
           (y > 39 && y < 44) ||
           (y > 45 && y < 49) ||
           (y > 53 && y < 56) ||
           (y > 60 && y < 64)){
            retX = 99; // trash point
            retY = 99; // trash point
        }else{
            retX = x - 8;
            retY = [[yGridToBoardPoints objectForKey:[NSNumber numberWithInt:y]] intValue];
        }
    }
    return [[DLLPoint alloc] initWithIntX:retX andY:retY];
}

// Vertical ranges of grid coordinates corresponding to holes on the board
// 23, 24
// 28-32
// 35-39
// 44, 45
// 49-53
// 56-60
// 64, 65

- (CGPoint)gridCoordinateFromBoardCoordinate:(DLLPoint*)loc
{
    NSInteger x = loc.xCoord;
    NSInteger y = loc.yCoord;
    NSInteger retX;
    NSInteger retY;
    NSArray *yGridPoints = [[NSArray alloc] initWithObjects:
                            [NSNumber numberWithInt:23],
                            [NSNumber numberWithInt:24],
                            [NSNumber numberWithInt:28],
                            [NSNumber numberWithInt:29],
                            [NSNumber numberWithInt:30],
                            [NSNumber numberWithInt:31],
                            [NSNumber numberWithInt:32],
                            [NSNumber numberWithInt:35],
                            [NSNumber numberWithInt:36],
                            [NSNumber numberWithInt:37],
                            [NSNumber numberWithInt:38],
                            [NSNumber numberWithInt:39],
                            [NSNumber numberWithInt:44],
                            [NSNumber numberWithInt:45],
                            [NSNumber numberWithInt:49],
                            [NSNumber numberWithInt:50],
                            [NSNumber numberWithInt:51],
                            [NSNumber numberWithInt:52],
                            [NSNumber numberWithInt:53],
                            [NSNumber numberWithInt:56],
                            [NSNumber numberWithInt:57],
                            [NSNumber numberWithInt:58],
                            [NSNumber numberWithInt:59],
                            [NSNumber numberWithInt:60],
                            [NSNumber numberWithInt:64],
                            [NSNumber numberWithInt:65],
                            nil];
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 0; i < [yGridPoints count]; i++){
        [temp addObject:[NSNumber numberWithInt:i]];
    }
    NSArray *yBoardPoints = [NSArray arrayWithArray:temp];
    NSDictionary *yBoardToGridPoints = [NSDictionary dictionaryWithObjects:yGridPoints forKeys:yBoardPoints];
    
    retX = x + 8;
    retY = [[yBoardToGridPoints objectForKey:[NSNumber numberWithInt:y]] intValue];
    
    return CGPointMake(retX, retY);
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
#pragma mark segue control methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LabToBoardSegue"]){
        DLLTestViewController *controller = (DLLTestViewController*)segue.destinationViewController;
        controller.boardModel = self.boardModel;
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
