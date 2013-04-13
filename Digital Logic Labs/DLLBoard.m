//
//  DLLModel.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoard.h"

@interface  DLLBoard()
@property (assign, nonatomic) NSInteger activeLab;
@property (strong, nonatomic) NSMutableDictionary *chipDictionary;
@property (strong, nonatomic) NSMutableArray *electricalPointToBoardPointArray;
@property (strong, nonatomic) NSMutableDictionary *boardPointToElectricalPointDictionary;
@property (strong, nonatomic) NSMutableArray *electricalPointArray;

//Note: changed boardPointToElectricalPointDictionary to have NSNumber values rather than NSString.

- (BOOL) illegalConnectionExists;
- (void) determineChipFunctionality;
- (void) setUpElectricalPointStates;
- (void) simulateInitialState;
- (void) simulateCombinational;
- (void) populateDatastructures;
- (DLLAComponent *)boardStateAt:(DLLPoint *)coords;

@end

@implementation DLLBoard

#define NUMROWS 31
#define NUMCOLUMNS 63
#define CLOCK_LIMIT 100

DLLAComponent * breadboardStateArray[NUMCOLUMNS][NUMROWS];

@synthesize activeLab = _activeLab;

#pragma mark -
#pragma mark Lab View API
- (void)labSelectionChangedTo:(NSInteger)labNum
{
    // Casey - added this to complete the lab view
}

- (NSMutableDictionary *)chipDictionary
{
    if (!_chipDictionary){
        _chipDictionary = [[NSMutableDictionary alloc] init];
    }
    return _chipDictionary;
}

- (NSMutableArray *)electricalPointToBoardPointArray;
{
    if (!_electricalPointToBoardPointArray){
        _electricalPointToBoardPointArray = [[NSMutableArray alloc] init];
    }
    return _electricalPointToBoardPointArray;
}

- (NSMutableDictionary *)boardPointToElectricalPointDictionary
{
    if (!_boardPointToElectricalPointDictionary){
        _boardPointToElectricalPointDictionary = [[NSMutableDictionary alloc] init];
    }
    return _boardPointToElectricalPointDictionary;
}

- (NSMutableArray *)electricalPointArray
{
    if (!_electricalPointArray){
        _electricalPointArray = [[NSMutableArray alloc] initWithCapacity:274];
    }
    return _electricalPointArray;
}

#pragma mark -
#pragma mark initialization methods
- (id)init
{
    // Creates an array w/ 63 columns and 31 rows w/ all values set to NSNull * myNull
    // define overarching array as columns
    if((self = [super init])){        
        for(int i = 0; i < NUMCOLUMNS; i++)
        {
            for(int j = 0; j < NUMROWS; j++)
            {
                breadboardStateArray[i][j] = nil;
            }
        }
        
        [self populateDatastructures];
    }
    
    return self;
}

-(void)populateDatastructures
{
    // Set up electricalPointToBoardPointDictionary and boardPointToElectricalPointDictionary for Electrical Point Values 0 to 251
    // Board Points of Main Board (including Power and Ground) have Coordinates 0 < x < 62, 5 < y < 30 
    // First 'for' loop maps all Board Points except Power, Ground, All Switches, and Lights
    
    
    for (int x = 0; x <= 62; x++) {
        NSNumber * key0 = [NSNumber numberWithInt: x * 4];
        NSNumber * key1 = [NSNumber numberWithInt: x * 4 + 1];
        NSNumber * key2 = [NSNumber numberWithInt: x * 4 + 2];
        NSNumber * key3 = [NSNumber numberWithInt: x * 4 + 3];
        DLLPoint *p0, *p1, *p2, *p3, *p4,
                 *p5, *p6, *p7, *p8, *p9,
                 *p10, *p11, *p12, *p13, *p14,
                 *p15, *p16, *p17, *p18, *p19;
        p0 = [[DLLPoint alloc] initWithIntX:x andY: 7];
        p1 = [[DLLPoint alloc] initWithIntX:x andY: 8];
        p2 = [[DLLPoint alloc] initWithIntX:x andY: 9];
        p3 = [[DLLPoint alloc] initWithIntX:x andY: 10];
        p4 = [[DLLPoint alloc] initWithIntX:x andY: 11];
        p5 = [[DLLPoint alloc] initWithIntX:x andY: 12];
        p6 = [[DLLPoint alloc] initWithIntX:x andY: 13];
        p7 = [[DLLPoint alloc] initWithIntX:x andY: 14];
        p8 = [[DLLPoint alloc] initWithIntX:x andY: 15];
        p9 = [[DLLPoint alloc] initWithIntX:x andY: 16];
        p10 = [[DLLPoint alloc] initWithIntX:x andY: 19];
        p11 = [[DLLPoint alloc] initWithIntX:x andY: 20];
        p12 = [[DLLPoint alloc] initWithIntX:x andY: 21];
        p13 = [[DLLPoint alloc] initWithIntX:x andY: 22];
        p14 = [[DLLPoint alloc] initWithIntX:x andY: 23];
        p15 = [[DLLPoint alloc] initWithIntX:x andY: 24];
        p16 = [[DLLPoint alloc] initWithIntX:x andY: 25];
        p17 = [[DLLPoint alloc] initWithIntX:x andY: 26];
        p18 = [[DLLPoint alloc] initWithIntX:x andY: 27];
        p19 = [[DLLPoint alloc] initWithIntX:x andY: 28];
        
        [self.boardPointToElectricalPointDictionary setValue: key0 forKey: [p0 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key0 forKey: [p1 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key0 forKey: [p2 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key0 forKey: [p3 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key0 forKey: [p4 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key1 forKey: [p5 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key1 forKey: [p6 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key1 forKey: [p7 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key1 forKey: [p8 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key1 forKey: [p9 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key2 forKey: [p10 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key2 forKey: [p11 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key2 forKey: [p12 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key2 forKey: [p13 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key2 forKey: [p14 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key3 forKey: [p15 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key3 forKey: [p16 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key3 forKey: [p17 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key3 forKey: [p18 toString]];
        [self.boardPointToElectricalPointDictionary setValue: key3 forKey: [p19 toString]];
        
    }
    
     for (int x = 0; x <= 62; x++)
     {

         DLLPoint *p0, *p1, *p2, *p3, *p4,
         *p5, *p6, *p7, *p8, *p9,
         *p10, *p11, *p12, *p13, *p14,
         *p15, *p16, *p17, *p18, *p19;
         p0 = [[DLLPoint alloc] initWithIntX:x andY: 7];
         p1 = [[DLLPoint alloc] initWithIntX:x andY: 8];
         p2 = [[DLLPoint alloc] initWithIntX:x andY: 9];
         p3 = [[DLLPoint alloc] initWithIntX:x andY: 10];
         p4 = [[DLLPoint alloc] initWithIntX:x andY: 11];
         p5 = [[DLLPoint alloc] initWithIntX:x andY: 12];
         p6 = [[DLLPoint alloc] initWithIntX:x andY: 13];
         p7 = [[DLLPoint alloc] initWithIntX:x andY: 14];
         p8 = [[DLLPoint alloc] initWithIntX:x andY: 15];
         p9 = [[DLLPoint alloc] initWithIntX:x andY: 16];
         p10 = [[DLLPoint alloc] initWithIntX:x andY: 19];
         p11 = [[DLLPoint alloc] initWithIntX:x andY: 20];
         p12 = [[DLLPoint alloc] initWithIntX:x andY: 21];
         p13 = [[DLLPoint alloc] initWithIntX:x andY: 22];
         p14 = [[DLLPoint alloc] initWithIntX:x andY: 23];
         p15 = [[DLLPoint alloc] initWithIntX:x andY: 24];
         p16 = [[DLLPoint alloc] initWithIntX:x andY: 25];
         p17 = [[DLLPoint alloc] initWithIntX:x andY: 26];
         p18 = [[DLLPoint alloc] initWithIntX:x andY: 27];
         p19 = [[DLLPoint alloc] initWithIntX:x andY: 28];
         NSArray *value0 = [NSArray arrayWithObjects: p0, p1, p2, p3, p4, nil]; // if this works may need to change elsewhere
         NSArray *value1 = [NSArray arrayWithObjects: p5, p6, p7, p8, p9, nil];
         NSArray *value2 = [NSArray arrayWithObjects: p10, p1, p12, p13, p14, nil];
         NSArray *value3 = [NSArray arrayWithObjects: p15, p16, p17, p18, p19, nil];
         [self.electricalPointToBoardPointArray insertObject:value0 atIndex:x * 4];
         [self.electricalPointToBoardPointArray insertObject:value1 atIndex:x * 4 + 1];
         [self.electricalPointToBoardPointArray insertObject:value2 atIndex:x * 4 + 2];
         [self.electricalPointToBoardPointArray insertObject:value3 atIndex:x * 4 + 3];
     }
    
    // ground == Electrical Point 252
    // Board Coordinates: {(0-62, 5), (0-62, 17), (0-62, 29)}
    
    // power == Electrical Point 253
    // Board Coordinates: {(0-62, 6), (0-62, 18), (0-62, 30)}
    NSMutableArray *groundArray = [[NSMutableArray alloc] initWithCapacity:189];
    NSMutableArray *powerArray = [[NSMutableArray alloc] initWithCapacity:189];
    NSNumber *groundValue = [NSNumber numberWithInteger: 252];
    NSNumber *powerValue = [NSNumber numberWithInteger: 253];
    
    for (int x = 0; x <= 62;x++)
    {
        [groundArray insertObject:[[DLLPoint alloc] initWithIntX:x andY: 5] atIndex:x];
        [powerArray insertObject:[[DLLPoint alloc] initWithIntX:x andY: 6] atIndex:x];
        [self.boardPointToElectricalPointDictionary setValue: groundValue forKey: [[groundArray objectAtIndex:x] toString]];
        [self.boardPointToElectricalPointDictionary setValue: powerValue forKey: [[powerArray objectAtIndex:x] toString]];
    }
    for (int x = 63; x <= 125; x++)
    {
        [groundArray insertObject:[[DLLPoint alloc] initWithIntX:x-63 andY: 17] atIndex:x];
        [powerArray insertObject:[[DLLPoint alloc] initWithIntX:x-63 andY: 18] atIndex:x];
        [self.boardPointToElectricalPointDictionary setValue: groundValue forKey: [[groundArray objectAtIndex:x] toString]];
        [self.boardPointToElectricalPointDictionary setValue: powerValue forKey: [[powerArray objectAtIndex:x] toString]];
        
    }
    for (int x = 126; x <= 188; x++)
    {
        [groundArray insertObject:[[DLLPoint alloc] initWithIntX:x-126 andY: 29] atIndex:x];
        [powerArray insertObject:[[DLLPoint alloc] initWithIntX:x-126 andY: 30] atIndex:x];
        [self.boardPointToElectricalPointDictionary setValue: groundValue forKey: [[groundArray objectAtIndex:x] toString]];
        [self.boardPointToElectricalPointDictionary setValue: powerValue forKey: [[powerArray objectAtIndex:x] toString]];
        
    }
    
    [self.electricalPointToBoardPointArray insertObject:groundArray atIndex:252];
    [self.electricalPointToBoardPointArray insertObject:powerArray atIndex:253];
    
    
    // Switch X == Electrical Point 254
    // Board Coordinates: {(0, 1-4)}
    
    // Debounced Switch X == Electrical Point 255
    // Board Coordinates: {(5, 1-4)}
    
    // Switch Y == Electrical Point 256
    // Board Coordinates: {(10, 1-4)}
    
    // Debounced Switch Y == Electrical Point 257
    // Board Coordinates: {(15, 1-4)}
    
    // SW1-SW8 == Electrical Points 258-265
    // Board Coordinates: {(20, 1-4), (25, 1-4), (30, 1-4), (35, 1-4), (40, 1-4), (45, 1-4), (50, 1-4), (55, 1-4)} 
    for (int x=0; x <= 11; x++)
    {
        DLLPoint *p1, *p2, *p3, *p4;
        p1 = [[DLLPoint alloc] initWithIntX:x andY: 1];
        p2 = [[DLLPoint alloc] initWithIntX:x andY: 2];
        p3 = [[DLLPoint alloc] initWithIntX:x andY: 3];
        p4 = [[DLLPoint alloc] initWithIntX:x andY: 4];
        
        NSArray *switchArray = @[p1, p2, p3, p4];
        NSNumber *electricalPoint = [NSNumber numberWithInt: x + 254];
        
        [self.boardPointToElectricalPointDictionary setValue: electricalPoint forKey: [p1 toString]];
        [self.boardPointToElectricalPointDictionary setValue: electricalPoint forKey: [p2 toString]];
        [self.boardPointToElectricalPointDictionary setValue: electricalPoint forKey: [p3 toString]];
        [self.boardPointToElectricalPointDictionary setValue: electricalPoint forKey: [p4 toString]];
        
        [self.electricalPointToBoardPointArray insertObject:switchArray atIndex:x + 254];

    }
    
    // Lights A-H == Electrical Points 266-273
    // Board Coordinates: {(25-28, 0), (50-53, 0)}
    
    DLLPoint *p1, *p2, *p3, *p4, *p5, *p6, *p7, *p8;
    p1 = [[DLLPoint alloc] initWithIntX:0 andY: 0];
    p2 = [[DLLPoint alloc] initWithIntX:1 andY: 0];
    p3 = [[DLLPoint alloc] initWithIntX:2 andY: 0];
    p4 = [[DLLPoint alloc] initWithIntX:3 andY: 0];
    p5 = [[DLLPoint alloc] initWithIntX:4 andY: 0];
    p6 = [[DLLPoint alloc] initWithIntX:5 andY: 0];
    p7 = [[DLLPoint alloc] initWithIntX:6 andY: 0];
    p8 = [[DLLPoint alloc] initWithIntX:7 andY: 0];
    
    NSArray *lightArray1 = [NSArray arrayWithObject:p1];
    NSArray *lightArray2 = [NSArray arrayWithObject:p2];
    NSArray *lightArray3 = [NSArray arrayWithObject:p3];
    NSArray *lightArray4 = [NSArray arrayWithObject:p4];
    NSArray *lightArray5 = [NSArray arrayWithObject:p5];
    NSArray *lightArray6 = [NSArray arrayWithObject:p6];
    NSArray *lightArray7 = [NSArray arrayWithObject:p7];
    NSArray *lightArray8 = [NSArray arrayWithObject:p8];
    
    NSNumber *v1 = [NSNumber numberWithInteger: 266];
    NSNumber *v2 = [NSNumber numberWithInteger: 267];
    NSNumber *v3 = [NSNumber numberWithInteger: 268];
    NSNumber *v4 = [NSNumber numberWithInteger: 269];
    NSNumber *v5 = [NSNumber numberWithInteger: 270];
    NSNumber *v6 = [NSNumber numberWithInteger: 271];
    NSNumber *v7 = [NSNumber numberWithInteger: 272];
    NSNumber *v8 = [NSNumber numberWithInteger: 273];
    
    [self.boardPointToElectricalPointDictionary setValue: v1 forKey: [p1 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v2 forKey: [p2 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v3 forKey: [p3 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v4 forKey: [p4 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v5 forKey: [p5 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v6 forKey: [p6 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v7 forKey: [p7 toString]];
    [self.boardPointToElectricalPointDictionary setValue: v8 forKey: [p8 toString]];
    
    [self.electricalPointToBoardPointArray insertObject:lightArray1 atIndex:266];
    [self.electricalPointToBoardPointArray insertObject:lightArray2 atIndex:267];
    [self.electricalPointToBoardPointArray insertObject:lightArray3 atIndex:268];
    [self.electricalPointToBoardPointArray insertObject:lightArray4 atIndex:269];
    [self.electricalPointToBoardPointArray insertObject:lightArray5 atIndex:270];
    [self.electricalPointToBoardPointArray insertObject:lightArray6 atIndex:271];
    [self.electricalPointToBoardPointArray insertObject:lightArray7 atIndex:272];
    [self.electricalPointToBoardPointArray insertObject:lightArray8 atIndex:273];

    // Initialize Electrical Point Array
    for(int x = 0; x < 252; x++)
    {
        [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeOther] atIndex:x];
    }
    
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeGround] atIndex:252];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypePower] atIndex:253];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:254];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeDebouncedSwitch] atIndex:255];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:256];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeDebouncedSwitch] atIndex:257];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:258];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:259];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:260];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:261];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:262];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:263];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:264];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:265];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:266];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:267];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:268];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:269];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:270];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:271];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:272];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:273];
}

#pragma mark -
#pragma mark component addition methods
- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords
{
    DLLChip * newChip;
    //TODO: add cases for other chip numbers - Joe
    switch(partNum)
    {
        case 7400: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7402: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7404: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7408: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7432: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7447: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7476: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7485: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 7486: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 74151: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 74164: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 74176: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 74181: newChip = [[DLL7400DIP alloc] initWithLocation: coords];
            break;
        case 74711: newChip = [[DLL7400DIP alloc] initWithLocation: coords];   // MAN 
            break; 
        default: newChip = nil;
            break;
    }
    
    if(newChip)
    {
        [self.chipDictionary setValue: newChip forKey: [coords toString]];
    
        //add chip to breadboardStateArray
        DLLPoint * current = [[DLLPoint alloc] initWithIntX: coords.xCoord andY: coords.yCoord];
        
        for(;current.xCoord < coords.xCoord + newChip.size / 2; current.xCoord++)
        {
            breadboardStateArray[current.xCoord][current.yCoord] = newChip;
            breadboardStateArray[current.xCoord][current.yCoord + 1] = newChip;
        }
    }
}

- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *)endingPoint withColor:(UIColor *)color
{
    
    DLLWire * newWire = [[DLLWire alloc] initWithStartPoint: startingPoint EndPoint: endingPoint AndColor: color];
    //Uncomment for debugging
    //NSLog([NSString stringWithFormat:@"Start Point: %d, %d", newWire.startPoint.xCoord, newWire.startPoint.yCoord]);
    //NSLog([NSString stringWithFormat:@"End Point: %d, %d", newWire.endPoint.xCoord, newWire.endPoint.yCoord]);
    
    //add new wire to both start and end point in breadboardStateArray
    breadboardStateArray[startingPoint.xCoord][startingPoint.yCoord] = newWire;
    breadboardStateArray[endingPoint.xCoord][endingPoint.yCoord] = newWire;

    //DEBUG
    //[self dumpBreadBoardStateArray];
    //comment to check branch
}



#pragma mark -
#pragma mark component removal methods
- (void)removeComponentAtCoordinate:(DLLPoint *)coords {
    //remove component from breadboardStateArray
    //not necessarily upper left-need to check 2D array
    
  /*  if([breadboardStateArray[coords.xCoord][coords.yCoord] isKindOfClass: [DLLWire class]])
    {
        
    }
    else
    {
        DLLChip *currentChip = breadboardStateArray[coords.xCoord][coords.yCoord];
        for(;currentChip.xCoord < coords.xCoord + newChip.size / 2; current.xCoord++)
        {
            breadboardStateArray[current.xCoord][current.yCoord] = newChip;
            breadboardStateArray[current.xCoord][current.yCoord + 1] = newChip;
        }
    }
    
    breadboardStateArray[coords.xCoord][coords.yCoord] = nil;*/
    
}

- (void)removeWireAtPoint: (DLLPoint *)startPoint
{    
    breadboardStateArray[startPoint.xCoord][startPoint.yCoord] = nil;
}

- (void)clearBoard
{
    [self.chipDictionary removeAllObjects];
    for (int i = 0; i < NUMCOLUMNS; i++)
    {
        for(int j = 0; j < NUMROWS; j++)
        {
            breadboardStateArray[i][j] = nil;
        }
    }
}

#pragma mark -
#pragma mark board state methods

- (BOOL)isOccupiedAt:(DLLPoint *)coords
{
    if(coords.xCoord > 63 && coords.yCoord > 31)
        return NO;
    
    id component = breadboardStateArray[coords.xCoord][coords.yCoord];
    BOOL occupied = (component != nil);

    return occupied;
    
    // If a chip or a wire is at given coords return occupied (YES)
    // (99,99) is a 'trash' point, items put here will not be added-mark as always unavailable
}

- (DLLAComponent *)boardStateAt:(DLLPoint *)coords
{
    return breadboardStateArray[coords.xCoord][coords.yCoord];
    // returning nil means the board is empty at given coords
}

- (BOOL)cellAt: (DLLPoint *)coords IsAvailableForComponentOfSize: (NSUInteger) size
{
    /*
        Wire size = 1
        All chips size = 14, 16, or 24, respectively
     */
    NSArray * validChipRows = @[@11, @23];
    NSInteger numRows = 0;
    
    if(size == 1) // wire
    {
        return !((coords.xCoord > 63) || (coords.yCoord > 31));
                 //([[self.breadboardStateArray objectAtIndex: coords.xCoord] objectAtIndex: coords.yCoord] != nil) 
    }
    
    if (size == 24)     // ALU
    {
        numRows = 4;
    } else              // chip
    {
        numRows = 2;
    }
    
    if(![validChipRows containsObject: [NSNumber numberWithInt: coords.yCoord]])
        return NO;
    
    DLLPoint * tempPoint = [[DLLPoint alloc] initWithIntX: coords.xCoord andY: coords.yCoord];
    for(int j = 0; j < numRows; j++){
        for(int i = coords.xCoord; i < coords.xCoord + size / 2; i++){
            
            if ([self boardStateAt: tempPoint]) return NO;
            
            tempPoint.xCoord++;
        }
        tempPoint.yCoord++;
    }
    
    return YES;
}

#pragma mark -
#pragma mark test screen API

- (void) runSimulation
{
    [self determineChipFunctionality];
    [self setUpElectricalPointStates];
    
    if (![self illegalConnectionExists])
    {
        [self simulateInitialState];
    }
}

- (void) determineChipFunctionality // currently: chip is assumed functional, set to NO if not connected to power or ground
{
   // NSEnumerator *enumerator = [self.chipDictionary objectEnumerator];
   // DLLChip * chip;
    
   // while (chip = (DLLChip *)[enumerator nextObject]) //{
        
   // }
    NSArray *chipsOnBoard = [self.chipDictionary allValues];
   for(int i = 0; i < [chipsOnBoard count]; i++)
    {
        DLLChip *chip = [chipsOnBoard objectAtIndex:i];
        DLLPoint *powerPinCoord = [chip powerPinCoordinate];
        // TODO: change bellow
        NSNumber *powerElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[powerPinCoord toString]]; 
        NSArray *powerElectricalArrayOfHoles = [self.electricalPointToBoardPointArray objectAtIndex:[powerElectricalPoint integerValue]];
        
        for(int j = 0; j < [powerElectricalArrayOfHoles count]; j++)
        {
            DLLPoint *currentBoardPoint = powerElectricalArrayOfHoles[j];
            
            if([breadboardStateArray[currentBoardPoint.xCoord][currentBoardPoint.yCoord] isKindOfClass:[DLLWire class]])
            {
                DLLAComponent *currentComponent = breadboardStateArray[currentBoardPoint.xCoord][currentBoardPoint.yCoord];
                DLLWire *currentWire = (DLLWire *) currentComponent;
                DLLPoint *otherPoint = [currentWire otherBoardHole: currentBoardPoint];
                NSNumber *otherElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[otherPoint toString]];
                DLLElectricalPoint *electricalPoint = [self.electricalPointArray objectAtIndex: [otherElectricalPoint integerValue]];
                if(!(electricalPoint.electricalPointType == EPTypePower)){
                    chip.isFunctional = NO;
                }
            }
        }
        DLLPoint *groundPinCoord = [chip groundPinCoordinate];
        NSNumber *groundElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[groundPinCoord toString]];
        NSArray *groundElectricalArrayOfHoles = [self.electricalPointToBoardPointArray objectAtIndex:[groundElectricalPoint integerValue]];
        
        for(int j = 0; j < [groundElectricalArrayOfHoles count]; j++)
        {
            DLLPoint *currentBoardPoint = groundElectricalArrayOfHoles[j];
            
            if([breadboardStateArray[currentBoardPoint.xCoord][currentBoardPoint.yCoord] isKindOfClass:[DLLWire class]])
            {
                DLLAComponent *currentComponent = breadboardStateArray[currentBoardPoint.xCoord][currentBoardPoint.yCoord];
                DLLWire *currentWire = (DLLWire *) currentComponent;
                DLLPoint *otherPoint = [currentWire otherBoardHole: currentBoardPoint];
                NSNumber *otherElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[otherPoint toString]];
                DLLElectricalPoint *electricalPoint = [self.electricalPointArray objectAtIndex: [otherElectricalPoint integerValue]];
                if(!(electricalPoint.electricalPointType == EPTypeGround)){
                    chip.isFunctional = NO;
                }
            }
        }
    }
}

// TODO: implement CLOCK PINS
- (void) setUpElectricalPointStates
{
    NSArray *chipsOnBoard = [self.chipDictionary allValues];
    for(int i = 0; i < [chipsOnBoard count]; i++)
    {
        DLLChip *chip = chipsOnBoard[i];
        
        DLLPoint *powerPinCoord = [chip powerPinCoordinate];
        DLLPoint *groundPinCoord = [chip groundPinCoordinate];
        NSNumber *powerElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[powerPinCoord toString]];
        NSNumber *groundElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[groundPinCoord toString]];
        [[self.electricalPointArray objectAtIndex:[powerElectricalPoint integerValue]] changePointTypeTo:EPTypeInput];
        [[self.electricalPointArray objectAtIndex:[groundElectricalPoint integerValue]] changePointTypeTo:EPTypeInput];
        
        NSArray *coordsOfInputPins = [chip coordinatesOfInputPins];
        for(int j = 0; j < [coordsOfInputPins count]; j++)
        {
            NSNumber *electricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[[coordsOfInputPins objectAtIndex:j] toString]];
            [[self.electricalPointArray objectAtIndex:[electricalPoint integerValue]] changePointTypeTo:EPTypeInput];
        }
        
        NSArray *coordsOfOutputPins = [chip coordinatesOfOutputPins];
        for(int j = 0; j < [coordsOfOutputPins count]; j++)
        {
            NSNumber *electricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[[coordsOfOutputPins objectAtIndex:j] toString]];
            [[self.electricalPointArray objectAtIndex:[electricalPoint integerValue]] changePointTypeTo:EPTypeOutput];
        }
    }
}

- (BOOL) illegalConnectionExists
{
    NSMutableArray *activeElectricalPoints = [NSMutableArray array];
    NSMutableArray *activeElectricalPointIndices = [NSMutableArray array];
    int count = 0;
    int count2 = 0;
    for(int i = 0; i < [self.electricalPointArray count]; i++)
    {
        DLLElectricalPoint *currentPoint = [self.electricalPointArray objectAtIndex:i];
        if(!([currentPoint electricalPointType] == EPTypeOther))
        {
            if([currentPoint electricalPointType] == EPTypeLight ||
               [currentPoint electricalPointType] == EPTypeInput ||
               [currentPoint electricalPointType] == EPTypeClockInput)
            {
                currentPoint.setNumber = -1;
            }
            else
            {
                currentPoint.setNumber = count;
                count++;
            }
            NSNumber *electricalIndex = [NSNumber numberWithInt:i];
            [activeElectricalPoints insertObject:currentPoint atIndex:count2];
            [activeElectricalPointIndices insertObject:electricalIndex atIndex:count2];
            count2++;
            
        }
    }
    BOOL changed = NO;
    do {
        changed = NO;
        for(int i = 0; i < [activeElectricalPoints count]; i++){
            
            DLLElectricalPoint *currentElectricalPoint = [activeElectricalPoints objectAtIndex:i];
            NSNumber *currentIndex = [activeElectricalPointIndices objectAtIndex:i];
            NSArray *electricalArrayOfHoles = [self.electricalPointToBoardPointArray objectAtIndex:[currentIndex integerValue]];
            for(int j = 0; j < [electricalArrayOfHoles count]; j++)
            {
                DLLPoint *currentPhysicalPoint = electricalArrayOfHoles[j];
                if([breadboardStateArray[currentPhysicalPoint.xCoord][currentPhysicalPoint.yCoord] isKindOfClass:[DLLWire class]])
                {
                    DLLAComponent *currentComponent = breadboardStateArray[currentPhysicalPoint.xCoord][currentPhysicalPoint.yCoord];
                    DLLWire *currentWire = (DLLWire *) currentComponent;
                    DLLPoint *otherPhysicalPoint = [currentWire otherBoardHole: currentPhysicalPoint];
                    NSNumber *indexOfOtherElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[otherPhysicalPoint toString]];
                    DLLElectricalPoint *otherElectricalPoint = [self.electricalPointArray objectAtIndex: [indexOfOtherElectricalPoint integerValue]];
                    if(currentElectricalPoint.setNumber == -1){
                        if(otherElectricalPoint.setNumber != -1){
                            currentElectricalPoint.setNumber = otherElectricalPoint.setNumber;
                            changed = YES;
                        }
                    }
                    else if(otherElectricalPoint.setNumber == -1){
                        otherElectricalPoint.setNumber = currentElectricalPoint.setNumber;
                        changed = YES;
                    }
                    else if(currentElectricalPoint.setNumber != otherElectricalPoint.setNumber)
                    {
                            // TODO: BAIL with ERROR
                        return NO;
                    }
                }
            }
        }
        
    } while (changed);
    
    return NO;
}

- (void) simulateInitialState
{
// initialize value and previousValue of each electrical point
    
    //main board: set electrical point value to unknown
    for (int i = 0; i < 252; i++)
    {
        DLLElectricalPoint *currentElectricalPoint = [self.electricalPointArray objectAtIndex:i];
        currentElectricalPoint.electricalPointValue = EPValueUnknown;
        currentElectricalPoint.electricalPointPreviousValue = EPValueUnknown;
    }
    //power: set electrical point value to 1
    DLLElectricalPoint *powerElectricalPoint = [self.electricalPointArray objectAtIndex:253];
    powerElectricalPoint.electricalPointValue = EPValueOne;
    powerElectricalPoint.electricalPointPreviousValue = EPValueOne;
    
    //ground: set electrical point value to 0
    DLLElectricalPoint *groundElectricalPoint = [self.electricalPointArray objectAtIndex:252];
    groundElectricalPoint.electricalPointValue = EPValueZero;
    groundElectricalPoint.electricalPointPreviousValue = EPValueZero;
    
    //switches: set electrical point value to initial state of switches on swipe to test screen
            //All switches initially 0 except for debouncedSwitches, which are initially 1
    DLLElectricalPoint *switchXElectricalPoint = [self.electricalPointArray objectAtIndex:254];
    DLLElectricalPoint *debouncedSwitchXElectricalPoint = [self.electricalPointArray objectAtIndex:255];
    DLLElectricalPoint *switchYElectricalPoint = [self.electricalPointArray objectAtIndex:256];
    DLLElectricalPoint *debouncedSwitchYElectricalPoint = [self.electricalPointArray objectAtIndex:257];
    
    switchXElectricalPoint.electricalPointValue = EPValueZero;
    switchXElectricalPoint.electricalPointPreviousValue = EPValueZero;
    
    debouncedSwitchXElectricalPoint.electricalPointValue = EPValueOne;
    debouncedSwitchXElectricalPoint.electricalPointPreviousValue = EPValueOne;
    
    switchYElectricalPoint.electricalPointValue = EPValueZero;
    switchYElectricalPoint.electricalPointPreviousValue = EPValueZero;
    
    debouncedSwitchYElectricalPoint.electricalPointValue = EPValueOne;
    debouncedSwitchYElectricalPoint.electricalPointPreviousValue = EPValueOne;
    // rest of switches
    for(int i = 258; i < 266; i++){
        DLLElectricalPoint *currentElectricalPoint = [self.electricalPointArray objectAtIndex:i];
        currentElectricalPoint.electricalPointValue = EPValueZero;
        currentElectricalPoint.electricalPointPreviousValue = EPValueZero;
    }
    
    //lights: set electrical point value to unknown
    for(int i = 266; i < 274; i++){
        DLLElectricalPoint *currentElectricalPoint = [self.electricalPointArray objectAtIndex:i];
        currentElectricalPoint.electricalPointValue = EPValueUnknown;
        currentElectricalPoint.electricalPointPreviousValue = EPValueUnknown;
    }
    
//TODO: initialize internal state of Flip Flop to unknown?
    
    [self simulateCombinational];
}

- (void) simulateCombinational
{
    int clock = 0;
    BOOL changed = NO;
    
    // set up array of activeElectricalPoints
    
    int count = 0;
    NSMutableArray *activeElectricalPoints = [NSMutableArray array];
    NSMutableArray *activeElectricalPointIndices = [NSMutableArray array];
    
    for(int i = 0; i < [self.electricalPointArray count]; i++)
    {
        DLLElectricalPoint *currentPoint = [self.electricalPointArray objectAtIndex:i];
        
        if(([currentPoint electricalPointType] == EPTypeInput) ||
           ([currentPoint electricalPointType] == EPTypeOutput) ||
           ([currentPoint electricalPointType] == EPTypeClockInput) ||
           ([currentPoint electricalPointType] == EPTypeLight))
        {
            [activeElectricalPoints insertObject:currentPoint atIndex:count];
            
            NSNumber *currentIndex = [NSNumber numberWithInt:i];
            [activeElectricalPointIndices insertObject:currentIndex atIndex:count];
            
            count++;
        }
    }
    
    do {
        changed = NO;
        for(int j =0; j < [activeElectricalPoints count]; j++)
        {
            DLLElectricalPoint *currentElectricalPoint = [activeElectricalPoints objectAtIndex:j];
            NSNumber *electricalIndex = [activeElectricalPointIndices objectAtIndex:j];
            NSArray *physicalArrayOfHoles = [self.electricalPointToBoardPointArray objectAtIndex:[electricalIndex integerValue]];
            for(int i = 0; i < [physicalArrayOfHoles count]; i++)
            {
                DLLPoint *currentBoardPoint = physicalArrayOfHoles[i];
                
                if([breadboardStateArray[currentBoardPoint.xCoord][currentBoardPoint.yCoord] isKindOfClass:[DLLWire class]])
                {
                    DLLAComponent *currentComponent = breadboardStateArray[currentBoardPoint.xCoord][currentBoardPoint.yCoord];
                    DLLWire *currentWire = (DLLWire *) currentComponent;
                    DLLPoint *otherPoint = [currentWire otherBoardHole: currentBoardPoint];
                    NSNumber *otherElectricalPointIndex = [self.boardPointToElectricalPointDictionary valueForKey:[otherPoint toString]];
                    DLLElectricalPoint *otherElectricalPoint = [self.electricalPointArray objectAtIndex: [otherElectricalPointIndex integerValue]];
                    if((currentElectricalPoint.electricalPointValue != otherElectricalPoint.electricalPointValue))
                    {
                        if ((currentElectricalPoint.electricalPointType == EPTypeInput) ||
                            (currentElectricalPoint.electricalPointType == EPTypeClockInput) ||
                            (currentElectricalPoint.electricalPointType == EPTypeLight))
                        {
                            changed = YES;
                            switch (otherElectricalPoint.electricalPointType)
                            {
                                case EPTypePower:
                                    currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                    currentElectricalPoint.electricalPointValue = EPValueOne;
                                    break;
                                case EPTypeGround:
                                    currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                    currentElectricalPoint.electricalPointValue = EPValueZero;
                                    break;
                                case EPTypeSwitch:
                                    currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                    currentElectricalPoint.electricalPointValue = otherElectricalPoint.electricalPointValue;
                                    break;
                                case EPTypeDebouncedSwitch:
                                    currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                    currentElectricalPoint.electricalPointValue = otherElectricalPoint.electricalPointValue;
                                    break;
                                case EPTypeInput: 
                                    if (otherElectricalPoint.electricalPointValue != EPValueUnknown)
                                    {
                                        currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                        currentElectricalPoint.electricalPointValue = otherElectricalPoint.electricalPointValue;
                                    }
                                    break;
                                case EPTypeClockInput: 
                                    if (otherElectricalPoint.electricalPointValue != EPValueUnknown)
                                    {
                                        currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                        currentElectricalPoint.electricalPointValue = otherElectricalPoint.electricalPointValue;
                                    }
                                    break;
                                case EPTypeOutput:
                                    currentElectricalPoint.electricalPointPreviousValue = currentElectricalPoint.electricalPointValue;
                                    currentElectricalPoint.electricalPointValue = otherElectricalPoint.electricalPointValue;
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }
            }
        }
        
        if (changed == YES)
        {
            int count = 0;
            
            // Create an array of active chips (chips that return isFunctional == YES)
            NSMutableArray *activeChips = [NSMutableArray array];      
            NSArray *chipsOnBoard = [self.chipDictionary allValues];
            
            for(int i = 0; i < [chipsOnBoard count]; i++)
            {
                DLLChip *currentChip = [chipsOnBoard objectAtIndex:i];
                
                if([currentChip isFunctional])
                {
                    [activeChips insertObject:currentChip atIndex:count];
                    count++;
                }
            }
            
            // Loop through array of active chips
            for(int i = 0; i < [activeChips count]; i++)
            {
                DLLChip *currentChip = [activeChips objectAtIndex:i];
                
                // set input values for currentChip
                NSArray *inputPinCoords = [currentChip coordinatesOfInputPins];
                NSArray *inputPinIndices = [currentChip inputPins];
                for(int j = 0; j < [inputPinCoords count]; j++)
                {
                    DLLPoint *currentPhysicalPoint = inputPinCoords[j];
                    NSNumber *indexOfElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[currentPhysicalPoint toString]];
                    DLLElectricalPoint *electricalPoint = [self.electricalPointArray objectAtIndex: [indexOfElectricalPoint integerValue]];
                    [currentChip setPin:[[inputPinIndices objectAtIndex:j] integerValue] to:electricalPoint];
                }
                
                [currentChip calculateOutputs];
                
                // set electrical points to new output values for currentChip
                NSArray *outputPinCoords = [currentChip coordinatesOfOutputPins];
                NSArray *outputPinIndices = [currentChip outputPins];
                for(int j = 0; j < [outputPinCoords count]; j++)
                {
                    DLLPoint *currentPhysicalPoint = [outputPinCoords objectAtIndex:j];
                    NSNumber *indexOfElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[currentPhysicalPoint toString]];
                    DLLElectricalPoint *electricalPoint = [self.electricalPointArray objectAtIndex: [indexOfElectricalPoint integerValue]];
                    DLLElectricalPoint *outputElectricalPoint = [currentChip.pins objectAtIndex: [[outputPinIndices objectAtIndex:j] integerValue]];
                    if (electricalPoint.electricalPointValue != outputElectricalPoint.electricalPointValue)
                    {
                        electricalPoint.electricalPointPreviousValue = electricalPoint.electricalPointValue;
                        electricalPoint.electricalPointValue = outputElectricalPoint.electricalPointValue;
                    }
                }
            }
        }
        clock++;
    } while (changed && clock < CLOCK_LIMIT);
    
}

// switches start at 0 with the debounced x switch, followed by debounced y, then SW1... SW8. SW8 has switch id 9

- (void) simulateThrowOfSwitchLabeled:(int)switchID
{
    /* TODO:
     For each sequential chip!
        Store the current states (Q values)!
        Store the current Ck values! */
    if(switchID == 0)
    {
        DLLElectricalPoint *switchX = [self.electricalPointArray objectAtIndex:254];
        DLLElectricalPoint *debouncedSwitchX = [self.electricalPointArray objectAtIndex:255];
        if (switchX.electricalPointValue == EPValueZero)
        {
            switchX.electricalPointValue = EPValueOne;
          debouncedSwitchX.electricalPointValue = EPValueZero;
        }
        else
        {
            switchX.electricalPointValue = EPValueZero;
            debouncedSwitchX.electricalPointValue = EPValueOne;
        }
    }
    else if(switchID == 1)
    {
        DLLElectricalPoint *switchY = [self.electricalPointArray objectAtIndex:256];
        DLLElectricalPoint *debouncedSwitchY = [self.electricalPointArray objectAtIndex:257];
        if (switchY.electricalPointValue == EPValueZero)
        {
            switchY.electricalPointValue = EPValueOne;
            debouncedSwitchY.electricalPointValue = EPValueZero;
        }
        else
        {
            switchY.electricalPointValue = EPValueZero;
            debouncedSwitchY.electricalPointValue = EPValueOne;
        }
    }
    else if (switchID > 1 && switchID < 10)
    {
        DLLElectricalPoint *currentSwitch = [self.electricalPointArray objectAtIndex:256 + switchID];
        if (currentSwitch.electricalPointValue == EPValueZero)
        {
            currentSwitch.electricalPointValue = EPValueOne;
        }
        else
        {
            currentSwitch.electricalPointValue = EPValueZero;
        }
    }
    [self simulateCombinational];
    BOOL stateChanged = NO;
    
    
     /* TODO: For each sequential chip // This simulates Master-Slave behavior!
        Compare Ck input value with stored Ck values!
        If Ck transition causes a state change!
        Set Q outputs accordingly!
        stateChanged := YES!*/
    
    if(stateChanged)
    {
        [self simulateCombinational];
    }
}

// TODO: reminder-need to add functionality to wire classes as well as chips

- (NSArray*)newStateOfLights
{
    NSMutableArray *stateOfLights = [NSMutableArray array];
    for (int i = 266; i < 274; i++)
    {
        DLLElectricalPoint *light = [self.electricalPointArray objectAtIndex:i];
        
        if (light.electricalPointValue == EPValueOne)
        {
            [stateOfLights insertObject:[NSNumber numberWithInt:1] atIndex: i - 266]; // ON
        }
        else if (light.electricalPointValue == EPValueZero || light.electricalPointValue == EPValueUnknown)
        {
            [stateOfLights insertObject:[NSNumber numberWithInt:0] atIndex: i - 266];  // OFF
        }
        else
        {
            [stateOfLights insertObject:[NSNumber numberWithInt:2] atIndex: i - 266];  // DIM
        }
    }
    
   /* NSNumber *temp0 = [NSNumber numberWithInt:1];
    NSNumber *temp1 = [NSNumber numberWithInt:1];
    NSNumber *temp2 = [NSNumber numberWithInt:1];
    NSNumber *temp3 = [NSNumber numberWithInt:1];
    NSNumber *temp4 = [NSNumber numberWithInt:1];
    NSNumber *temp5 = [NSNumber numberWithInt:1];
    NSNumber *temp6 = [NSNumber numberWithInt:1];
    NSNumber *temp7 = [NSNumber numberWithInt:1];
    return [NSArray arrayWithObjects:temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, nil];*/
    
    return  stateOfLights;
}

- (void)dumpBreadBoardStateArray
{
    for(int i = 0; i < NUMCOLUMNS; i++)
    {
        for(int j = 0; j < NUMROWS; j++)
        {
            
            NSString * item = [NSString stringWithFormat: @"%d, %d: ", i, j];
            
            if(!breadboardStateArray[i][j])
                item = [item stringByAppendingString: @"0"];
            else if([breadboardStateArray[i][j] isKindOfClass: [DLLWire class]])
                item = [item stringByAppendingString: @"W"];
            else
                item = [item stringByAppendingString: @"C"];
            
            NSLog(item);
        }
    }
}

@end
