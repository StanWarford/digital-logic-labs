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

#define HORIZONTAL_BOARD_SPACING 11.9 // defines space between logical horizontal grid lines
#define VERTICAL_BOARD_SPACING 12.2 // defines space between logical vertical grid lines

#define HORIZONTAL_BOARD_OFFSET 6 // defines right direction horizontal offset for logical grid
#define VERTICAL_BOARD_OFFSET 7 // defines down direction vertical offset for logical grid

#define VIEW_HEIGHT 634 // defines height of view
#define VIEW_WIDTH 1024 // defines width of view

#define CHIP_PIN_X_OFFSET 12 // defines right direction horizontal offset for upper left pin on a chipview
#define CHIP_PIN_Y_OFFSET 16 // defines down direction vertical offset for upper left pin on a chipview

@synthesize activeComponent = _activeComponent; // pointer to the component being actively edited
@synthesize pointMap = _pointMap; // pointer to internal dictionary of DLLPoints and objects placed in the view
@synthesize selection = _selection; // pointer to componentview that's selected in dock
@synthesize boardModel = _boardModel; // pointer to model
@synthesize state = _state; // variable representing the state of the board as defined by placement state enum
@synthesize parent = _parent; // pointer to containerview

#pragma mark -
#pragma mark Initialization Metods
// disable multitouch, reset activecomponent, and enter initial state
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.multipleTouchEnabled = NO;
    self.activeComponent = nil;
    self.state = notWire;
}

// setup visual elements of the view
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
// called when dock changes selection
- (void)selectionDidChange:(DLLAComponentView*)selection
{
    self.selection = selection;
}

#pragma mark -
#pragma mark Touch Recognition methods
// if something is touched, assume the user wants to edit its position and remove it immediately
// otherwise allocate a new component based on dock selection and 
// then begin placing the ghost image on screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled, this should only ever return a single touch
    CGPoint tLoc = [touch locationInView:self.view];
    CGPoint tGridLoc = [self gridCoordinateFromViewCoordinate:tLoc];
    CGPoint tSnapLoc = [self viewCoordinateFromGridCoordinate:tGridLoc];
    DLLPoint* tBoardLoc = [self boardCoordinateFromGridCoordinate:tGridLoc];
    BOOL isEmpty = ![self.boardModel isOccupiedAt:tBoardLoc];
    
    if(self.state == notWire){ // user has not placed a wire
        if(!isEmpty){ // user touched a component, remove that component from the board and make it the active component
            [self.boardModel removeComponentAtCoordinate:tBoardLoc];
            self.activeComponent = [self.pointMap objectForKey:tBoardLoc];
            [self removeComponentFromPointMap:self.activeComponent];
            [self.activeComponent removeGraphics];
        }else{ // user touched an empty spot, allocate a new chip or wire based on dock selection
            if([self.selection isKindOfClass:[DLLChipView class]]){
                self.activeComponent = [[[self.selection class] alloc] initChipAtLocation:tSnapLoc inView:self.view withID:[self.selection identifier]];
            }else{
                self.activeComponent = [[[self.selection class] alloc] initWireWithStartAt:tSnapLoc withColor:self.selection.color inView:self.view];
            }
        }
        self.state = [self.activeComponent isKindOfClass:[DLLWireView class]] ? wireStart : notWire;
        
        CGPoint cLoc = [self gridCoordinateFromViewCoordinate:CGPointMake(self.activeComponent.start.x+CHIP_PIN_X_OFFSET, self.activeComponent.start.y+CHIP_PIN_Y_OFFSET)];
        DLLPoint *cOffset = [self boardCoordinateFromGridCoordinate:cLoc];
        CGPoint wLoc = [self gridCoordinateFromViewCoordinate:self.activeComponent.start];
        // location correction
        wLoc.x++;
        DLLPoint *wOffset = [self boardCoordinateFromGridCoordinate:wLoc];
        BOOL isAvailable = [self.boardModel cellAt:self.state == notWire ? cOffset : wOffset IsAvailableForComponentOfSize:self.activeComponent.size];
        
        // NSLog([NSString stringWithFormat:@"%@", isAvailable ? @"YES" : @"NO"]);
        // NSLog([NSString stringWithFormat:@"(%f, %f)", wLoc.x, wLoc.y]);
        // NSLog([NSString stringWithFormat:@"(%f, %f)", cLoc.x, cLoc.y]);
        NSLog([NSString stringWithFormat:@"(%d, %d)", wOffset.xCoord, wOffset.yCoord]);
        // NSLog([NSString stringWithFormat:@"(%d, %d)", cOffset.xCoord, cOffset.yCoord]);
        
        [self.activeComponent displayGhostWithHoleAvailable:isAvailable];
    }else{ // wireEnd - user is placing end of wire
        BOOL didTouchStart = self.activeComponent.start.x < tSnapLoc.x + 1 && self.activeComponent.start.x > tSnapLoc.x - 1 &&
                             self.activeComponent.start.y < tSnapLoc.y + 1 && self.activeComponent.start.y > tSnapLoc.y - 1;
        CGPoint wLoc = [self.activeComponent getOffsetPointFrom:tSnapLoc];
        DLLPoint *wOffset = [self boardCoordinateFromGridCoordinate:wLoc];
        BOOL isAvailable = [self.boardModel cellAt:wOffset IsAvailableForComponentOfSize:self.activeComponent.size];
        
        if(didTouchStart){ // user touched the start of the wire, edit the start
            [self.activeComponent translateStartTo:tSnapLoc withHoleAvailable:isAvailable];
            self.state = wireStart;
        }else{
            [self.activeComponent translateEndTo:tSnapLoc withHoleAvailable:isAvailable];
        }
    }
}

// when the touch moves, query the model and update the ghost image
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject]; // with multitouch disabled this should only ever return a single touch
    CGPoint tLoc = [touch locationInView:self.view];
    CGPoint tGridLoc = [self gridCoordinateFromViewCoordinate:tLoc];
    CGPoint tSnapLoc = [self viewCoordinateFromGridCoordinate:tGridLoc];
    
    if(self.state == wireEnd){ // user is placing end of wire
        CGPoint wLoc = [self.activeComponent getOffsetPointFrom:tSnapLoc];
        CGPoint wCalcPoint = [self gridCoordinateFromViewCoordinate:wLoc];
        wCalcPoint.x++;
        wCalcPoint.y++;
        DLLPoint *wOffset = [self boardCoordinateFromGridCoordinate:wCalcPoint];
        
        BOOL isAvailable = [self.boardModel cellAt:wOffset IsAvailableForComponentOfSize:self.activeComponent.size];
        [self.activeComponent translateEndTo:tSnapLoc withHoleAvailable:isAvailable];
    }else{ // user is placing start of wire or not placing a wire
        CGPoint cLoc = [self.activeComponent getOffsetPointFrom:tSnapLoc];
        CGPoint cCalcPoint = [self gridCoordinateFromViewCoordinate:CGPointMake(cLoc.x+CHIP_PIN_X_OFFSET, cLoc.y+CHIP_PIN_Y_OFFSET)];
        CGPoint wCalcPoint = [self gridCoordinateFromViewCoordinate:cLoc];
        // location correction
        wCalcPoint.x++;
        wCalcPoint.y++;
        DLLPoint *cOffset = [self boardCoordinateFromGridCoordinate:cCalcPoint];
        DLLPoint *wOffset = [self boardCoordinateFromGridCoordinate:wCalcPoint];
        
        // NSLog([NSString stringWithFormat:@"(%f, %f)", wCalcPoint.x, wCalcPoint.y]);
        // NSLog([NSString stringWithFormat:@"(%f, %f)", cCalcPoint.x, cCalcPoint.y]);
        NSLog([NSString stringWithFormat:@"(%u, %u)", wOffset.xCoord, wOffset.yCoord]);
        // NSLog([NSString stringWithFormat:@"(%d, %d)", cOffset.xCoord, cOffset.yCoord]);
        
        BOOL isAvailable = [self.boardModel cellAt:self.state == notWire ? cOffset : wOffset IsAvailableForComponentOfSize: self.activeComponent.size];
        
        [self.activeComponent translateStartTo:tSnapLoc withHoleAvailable:isAvailable];
    }
}

// when the touch ends, query the model one more time adding the component to both the model and the internal pointmap
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if(self.state == notWire){ // user is not placing a wire
        CGPoint cGridLoc = [self gridCoordinateFromViewCoordinate:CGPointMake(self.activeComponent.start.x+CHIP_PIN_X_OFFSET, self.activeComponent.start.y+CHIP_PIN_Y_OFFSET)];
        DLLPoint *cStart = [self boardCoordinateFromGridCoordinate:cGridLoc];
        BOOL isAvailable = [self.boardModel cellAt:cStart IsAvailableForComponentOfSize: self.activeComponent.size];
        
        if(isAvailable){
            // Tell the active component to display itself and notify model
            [self.activeComponent displayComponent];
            [self.boardModel addChipWithPartNum:self.activeComponent.identifier atUpperLeftCornerCoordinate:cStart];
            
            // Set pointers in dictionary to the displayed object
            NSInteger x = cStart.xCoord;
            NSInteger y = cStart.yCoord;
            NSMutableDictionary *dict = [self.pointMap mutableCopy];
            for(int i = 0; i < self.activeComponent.size; i++){
                i < self.activeComponent.size/2 ? [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:CGPointMake(x+i, y)]] : [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:CGPointMake(x+i-self.activeComponent.size/2, y+1)]];
            }
            self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
        }else{
            // User requested invalid chip placement, remove activeComponent from view
            [self.activeComponent removeGraphics];
        }
        self.activeComponent = nil;
        
    }else if(self.state == wireStart){ // user is placing start of wire
        CGPoint wGridLoc = [self gridCoordinateFromViewCoordinate:self.activeComponent.start];
        // location correction
        wGridLoc.x++;
        wGridLoc.y++;
        DLLPoint *wBoardLoc = [self boardCoordinateFromGridCoordinate:wGridLoc];
        BOOL isAvailable = [self.boardModel cellAt:wBoardLoc IsAvailableForComponentOfSize: self.activeComponent.size];

        if(isAvailable){
            // add start of wire to pointMap
            NSMutableDictionary *dict = [self.pointMap mutableCopy];
            [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:[wBoardLoc CGPointFromCoords]]];
            self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
            
            self.state = wireEnd;
        }else{
            [self.activeComponent removeGraphics];
            self.state = notWire;
            self.activeComponent = nil;
        }
        
    }else{ // user is placing end of wire
        CGPoint wGridLoc = [self gridCoordinateFromViewCoordinate:self.activeComponent.end];
        // location correction
        wGridLoc.x++;
        wGridLoc.y++;
        DLLPoint *wBoardLoc = [self boardCoordinateFromGridCoordinate:wGridLoc];
        BOOL isAvailable = [self.boardModel cellAt:wBoardLoc IsAvailableForComponentOfSize: self.activeComponent.size];

        if(isAvailable){
            [self.activeComponent displayComponent];
            [self.boardModel addWireFromPoint:[[DLLPoint alloc] initWithCoords:self.activeComponent.start] toPoint:[[DLLPoint alloc] initWithCoords:self.activeComponent.end] withColor:self.activeComponent.color];
            
            // set pointers in dictionary to the displayed object
            NSMutableDictionary *dict = [self.pointMap mutableCopy];
            [dict setObject:self.activeComponent forKey:[NSValue valueWithCGPoint:[wBoardLoc CGPointFromCoords]]];
            self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
        }else{
            // user requested invalid object placement, remove activeComponent from view and dictionary
            [self.activeComponent removeGraphics];
            [self removeComponentFromPointMap:self.activeComponent];
        }
        self.activeComponent = nil;
        self.state = notWire;
    }
}

// in case an error occurs, cancel out all touch info
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.activeComponent = nil;
}

#pragma mark -
#pragma mark display point translation methods
// translate a view coordinate to coordinates on the logical grid
- (CGPoint)gridCoordinateFromViewCoordinate:(CGPoint)loc
{
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger calcX = abs(ceil((x - HORIZONTAL_BOARD_OFFSET)/HORIZONTAL_BOARD_SPACING));
    NSInteger calcY = abs(ceil((y - VERTICAL_BOARD_OFFSET)/VERTICAL_BOARD_SPACING));
    return CGPointMake(calcX, calcY);
}

// translate a logical grid coordinate back to a coordinate in the view
- (CGPoint)viewCoordinateFromGridCoordinate:(CGPoint)loc
{
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger calcX = x*HORIZONTAL_BOARD_SPACING + HORIZONTAL_BOARD_OFFSET;
    NSInteger calcY = y*VERTICAL_BOARD_SPACING + VERTICAL_BOARD_OFFSET;
    return CGPointMake(calcX, calcY);
}

/*
Vertical ranges of grid coordinates corresponding to holes on the board
3
11-14

19, 20
22-26
28-32
34, 35
37-41
43-47
49, 50
*/

// Translate logical grid coordinates into coordinates used by the board model
- (DLLPoint*)boardCoordinateFromGridCoordinate:(CGPoint)loc
{
    NSInteger x = loc.x;
    NSInteger y = loc.y;
    NSInteger retX;
    NSInteger retY;
    NSArray *yGridPoints = [[NSArray alloc] initWithObjects:
                            [NSNumber numberWithInt:19],
                            [NSNumber numberWithInt:20],
                            
                            [NSNumber numberWithInt:22],
                            [NSNumber numberWithInt:23],
                            [NSNumber numberWithInt:24],
                            [NSNumber numberWithInt:25],
                            [NSNumber numberWithInt:26],
                            
                            [NSNumber numberWithInt:28],
                            [NSNumber numberWithInt:29],
                            [NSNumber numberWithInt:30],
                            [NSNumber numberWithInt:31],
                            [NSNumber numberWithInt:32],
                            
                            [NSNumber numberWithInt:34],
                            [NSNumber numberWithInt:35],
                            
                            [NSNumber numberWithInt:37],
                            [NSNumber numberWithInt:38],
                            [NSNumber numberWithInt:39],
                            [NSNumber numberWithInt:40],
                            [NSNumber numberWithInt:41],

                            [NSNumber numberWithInt:43],
                            [NSNumber numberWithInt:44],
                            [NSNumber numberWithInt:45],
                            [NSNumber numberWithInt:46],
                            [NSNumber numberWithInt:47],
                            
                            [NSNumber numberWithInt:49],
                            [NSNumber numberWithInt:50],
                            nil];
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 0; i < [yGridPoints count]; i++){
        [temp addObject:[NSNumber numberWithInt:i+5]];
    }
    NSArray *yBoardPoints = [NSArray arrayWithArray:temp];
    NSDictionary *yGridToBoardPoints = [NSDictionary dictionaryWithObjects:yBoardPoints forKeys:yGridPoints];
    
    if(x < 12 || x > 74 || y > 50){
        // point is outside the area where valid board holes are located
        retX = 99; // trash point
        retY = 99; // trash point
    }else if(y < 15){
        if(y == 3){
            retY = 0;
            // 29-32
            // 55-58
            if(x >= 29 && x <= 32){
                retX = x - 29;
            }else if(x >= 55 && x <= 58){
                retX = x - 51;
            }else{
                retX = 99;
                retY = 99;
            }
        }else if(y >= 11){
            retY = y - 10;
            // 17, 18
            // 21, 22
            // 27
            // 33
            // 39
            // 45
            // 51
            // 57
            // 63
            // 69
            if(x == 17 || x == 18){
                retX = x - 17;
            }else if(x == 21 || x == 22){
                retX = x - 19;
            }else if(x == 27 || x == 33 || x == 39 || x == 45 || x == 51 || x == 57 || x == 63 || x == 69){
                retX = (x - 27)/6 + 4;
            }else{
                retX = 99;
                retY = 99;
            }
        }else{
            // point is in a space where there are no valid board holes
            retX = 99;
            retY = 99;
        }
    }else{
        if((y > 14 && y < 19) || y == 21 || y == 27 || y == 33 || y == 36 || y == 42 || y == 48){
            // point is in a space where there are no valid board holes
            retX = 99; // trash point
            retY = 99; // trash point
        }else{
            // point is on a valid board hole, calculate board value
            retX = x - 12;
            retY = [[yGridToBoardPoints objectForKey:[NSNumber numberWithInt:y]] intValue];
        }
    }
    return [[DLLPoint alloc] initWithIntX:retX andY:retY];
}

// translate coordinates used by the board model into logical grid coordinates
- (CGPoint)gridCoordinateFromBoardCoordinate:(DLLPoint*)loc
{
    NSInteger x = loc.xCoord;
    NSInteger y = loc.yCoord;
    NSInteger retX;
    NSInteger retY;
    NSArray *yGridPoints = [[NSArray alloc] initWithObjects:
                            [NSNumber numberWithInt:19],
                            [NSNumber numberWithInt:20],
                            
                            [NSNumber numberWithInt:22],
                            [NSNumber numberWithInt:23],
                            [NSNumber numberWithInt:24],
                            [NSNumber numberWithInt:25],
                            [NSNumber numberWithInt:26],
                            
                            [NSNumber numberWithInt:28],
                            [NSNumber numberWithInt:29],
                            [NSNumber numberWithInt:30],
                            [NSNumber numberWithInt:31],
                            [NSNumber numberWithInt:32],
                            
                            [NSNumber numberWithInt:34],
                            [NSNumber numberWithInt:35],
                            
                            [NSNumber numberWithInt:37],
                            [NSNumber numberWithInt:38],
                            [NSNumber numberWithInt:39],
                            [NSNumber numberWithInt:40],
                            [NSNumber numberWithInt:41],
                            
                            [NSNumber numberWithInt:43],
                            [NSNumber numberWithInt:44],
                            [NSNumber numberWithInt:45],
                            [NSNumber numberWithInt:46],
                            [NSNumber numberWithInt:47],
                            
                            [NSNumber numberWithInt:49],
                            [NSNumber numberWithInt:50],
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
// remove all references in pointmap to component
- (void)removeComponentFromPointMap:(DLLAComponentView *)component
{
    NSArray *temp = [self.pointMap allKeysForObject:component];
    NSMutableDictionary *dict = [self.pointMap mutableCopy];
    for(NSValue *value in temp){
        [dict removeObjectForKey:value];
    }
    self.pointMap = [NSDictionary dictionaryWithDictionary:dict];
}

// completely empty pointmap and tell all components to go out of the view
- (void)clearBoard
{
    [self.boardModel clearBoard];
    NSArray *components = [self.pointMap allValues];
    for(DLLAComponentView *component in components){
        [component removeGraphics];
    }
    self.pointMap = [NSDictionary dictionary];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.activeComponent = nil;
    self.selection = nil;
    // cannot deallocate pointmap since that holds information that can't be restored.
    // cannot deallocate placementstate since that holds information that can't be restored.
}

@end
