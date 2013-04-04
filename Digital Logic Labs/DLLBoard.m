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
@property (strong, nonatomic) NSMutableArray *breadboardStateArray;
@property (strong, nonatomic) NSMutableArray *electricalPointToBoardPointArray;
@property (strong, nonatomic) NSMutableDictionary *boardPointToElectricalPointDictionary;
@property (strong, nonatomic) NSMutableArray *electricalPointArray;

//Note: changed boardPointToElectricalPointDictionary to have NSNumber values rather than NSString.

- (BOOL) illegalConnectionExists;
- (void) determineChipFunctionality;
- (void) simulateInitialState;
- (void) simulateCombinational;
- (void) populateDatastructures;
- (DLLAComponent *)boardStateAt:(DLLPoint *)coords;

@end

@implementation DLLBoard

#define NUMROWS 31
#define NUMCOLUMNS 63

@synthesize breadboardStateArray = _breadboardStateArray;
@synthesize activeLab = _activeLab;


#pragma mark -
#pragma mark lazy instantiation methods
- (NSMutableArray *)breadboardStateArray
{
    if (!_breadboardStateArray){
        _breadboardStateArray = [[NSMutableArray alloc] initWithCapacity: NUMCOLUMNS];
    }
    return _breadboardStateArray;
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
        NSNull * myNull = [NSNull null];
    
        NSMutableArray * boardColumns;
        
        for(int i = 0; i < NUMCOLUMNS; i++)
        {
            boardColumns = [[NSMutableArray alloc] initWithCapacity: NUMROWS];
            for(int j = 0; j < NUMROWS; j++)
            {
                [boardColumns insertObject: myNull atIndex: j];
            }
            
            [self.breadboardStateArray insertObject: boardColumns atIndex: i];
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
        NSArray *value0 = @[p0, p1, p2, p3, p4];
        NSArray *value1 = @[p5, p6, p7, p8, p9];
        NSArray *value2 = @[p10, p1, p12, p13, p14];
        NSArray *value3 = @[p15, p16, p17, p18, p19];
        
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
        groundArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 5];
        powerArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 6];
        [self.boardPointToElectricalPointDictionary setValue: groundValue forKey: [groundArray[x] toString]];
        [self.boardPointToElectricalPointDictionary setValue: powerValue forKey: [powerArray[x] toString]];
    }
    for (int x = 63; x <= 125; x++)
    {
        groundArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 17];
        powerArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 18];
        [self.boardPointToElectricalPointDictionary setValue: groundValue forKey: [groundArray[x] toString]];
        [self.boardPointToElectricalPointDictionary setValue: powerValue forKey: [powerArray[x] toString]];
    }
    for (int x = 126; x <= 188; x++)
    {
        groundArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 29];
        powerArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 30];
        [self.boardPointToElectricalPointDictionary setValue: groundValue forKey: [groundArray[x] toString]];
        [self.boardPointToElectricalPointDictionary setValue: powerValue forKey: [powerArray[x] toString]];
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
        p1 = [[DLLPoint alloc] initWithIntX:x*5 andY: 1];
        p2 = [[DLLPoint alloc] initWithIntX:x*5 andY: 2];
        p3 = [[DLLPoint alloc] initWithIntX:x*5 andY: 3];
        p4 = [[DLLPoint alloc] initWithIntX:x*5 andY: 4];
        
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
    p1 = [[DLLPoint alloc] initWithIntX:25 andY: 0];
    p2 = [[DLLPoint alloc] initWithIntX:26 andY: 0];
    p3 = [[DLLPoint alloc] initWithIntX:27 andY: 0];
    p4 = [[DLLPoint alloc] initWithIntX:28 andY: 0];
    p5 = [[DLLPoint alloc] initWithIntX:50 andY: 0];
    p6 = [[DLLPoint alloc] initWithIntX:51 andY: 0];
    p7 = [[DLLPoint alloc] initWithIntX:52 andY: 0];
    p8 = [[DLLPoint alloc] initWithIntX:53 andY: 0];
    
    NSArray *lightArray1 = @[p1];
    NSArray *lightArray2 = @[p2];
    NSArray *lightArray3 = @[p3];
    NSArray *lightArray4 = @[p4];
    NSArray *lightArray5 = @[p5];
    NSArray *lightArray6 = @[p6];
    NSArray *lightArray7 = @[p7];
    NSArray *lightArray8 = @[p8];
    
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
        [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] init] atIndex:x];
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
    DLLChip *newChip = [[DLLChip alloc] initWithIdenfifier: partNum];
    [self.chipDictionary setValue: newChip forKey: [coords toString]];
    //TODO: for Joe to implement
    // add pointers to breadboardStateArray
    // Joe, I think the breadboardStateArray needs to point to the same object that chipDictionary points to.  Is that possible?
    //          -Brooke
}

- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *)endingPoint withColor:(UIColor *)color
{
    //TODO: for Joe to implement
    //add a component to the XML file and to data structure for the active board
    // need internal safety w/ exceptions
}



#pragma mark -
#pragma mark component removal methods
- (void)removeComponentAtCoordinate:(DLLPoint *)coords //this will return component type -Casey
{
    //TODO: for Joe to implement
    //not necessarily upper left-need to check 2D array
    // Code below is not quite right, but close
    DLLAComponent * tempComponent = [self.chipDictionary objectForKey:[coords toString]];
    [self.chipDictionary removeObjectForKey:[coords toString]];
}

- (void)clearBoard
{
    [self.chipDictionary removeAllObjects];
    for (int i = 0; i < NUMCOLUMNS; i++){
        NSMutableArray * row = [self.breadboardStateArray objectAtIndex:i];
        for(int j = 0; j < NUMROWS; j++){
            NSNull * myNull = [NSNull null];
            [row insertObject:myNull atIndex:j];
        }
    }
    //clear chipDictionary, and set all cells in breadboardStateArray to NSNull
}

#pragma mark -
#pragma mark board state methods

- (BOOL)isOccupiedAt:(DLLPoint *)coords
{
    if(coords.xCoord > 63 && coords.yCoord > 31)
        return NO;
    
    id component = [[self.breadboardStateArray objectAtIndex: coords.xCoord] objectAtIndex: coords.yCoord];
    NSNull * myNull = [NSNull null];
    
    return !(component == myNull);
    
    // If a chip or a wire is at given coords return !NO
    // (99,99) is a 'trash' point, items put here will not be added-mark as always unavailable
}

- (DLLAComponent *)boardStateAt:(DLLPoint *)coords
{
    id component = [[self.breadboardStateArray objectAtIndex: coords.xCoord] objectAtIndex: coords.yCoord];
    NSNull * myNull = [NSNull null];
    
    if(component == myNull)
        return nil;
    else return (DLLAComponent *)component;
    
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
        //if (!([[self.breadboardStateArray objectAtIndex: coords.xCoord] objectAtIndex: coords.yCoord] == nil) || coords.xCoord == 99 || coords.yCoord == 99) return NO; //  *********Casey - This is crashing for some reason*************
        // Casey, if you see this, I think it's because we have not yet implemented chips in the breadboard logic yet
        return YES;
        
    }
    if (size == 24){
        numRows = 4;
    }else // chip
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

//TODO: for Brooke to implement
- (void) runSimulation
{
    [self determineChipFunctionality];
    if (![self illegalConnectionExists])
    {
        [self simulateInitialState];
    }
}

- (void) determineChipFunctionality // currently: chip is assumed functional, set to NO if not connected to power or ground
{
    NSArray *chipsOnBoard = [self.chipDictionary allValues];
    for(int i = 0; i < [chipsOnBoard count]; i++)
    {
        DLLChip *chip = chipsOnBoard[i];
        
        DLLPoint *powerPinCoord = [chip powerPinCoordinate];
        NSNumber *powerElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[powerPinCoord toString]];
        NSArray *powerElectricalArrayOfHoles = [self.electricalPointToBoardPointArray objectAtIndex:powerElectricalPoint];
        
        for(int i = 0; i < [powerElectricalArrayOfHoles count]; i++)
        {
            DLLPoint *currentBoardPoint = powerElectricalArrayOfHoles[i];
            
            if([[[self.breadboardStateArray objectAtIndex: currentBoardPoint.xCoord]
                                            objectAtIndex: currentBoardPoint.yCoord]
                                            isKindOfClass:[DLLWire class]])
            {
                DLLWire *currentWire = [[self.breadboardStateArray objectAtIndex: currentBoardPoint.xCoord]
                                         objectAtIndex: currentBoardPoint.yCoord];
                DLLPoint *otherPoint = [currentWire otherBoardHole: currentBoardPoint];
                NSNumber *otherElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[otherPoint toString]];
                DLLElectricalPoint *electricalPoint = [self.electricalPointArray objectAtIndex: otherElectricalPoint];
                if(!(electricalPoint.electricalPointType == EPTypePower)){
                    chip.isFunctional = NO;
                }
            }
        }
        DLLPoint *groundPinCoord = [chip groundPinCoordinate];
        NSNumber *groundElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[groundPinCoord toString]];
        NSArray *groundElectricalArrayOfHoles = [self.electricalPointToBoardPointArray objectAtIndex:groundElectricalPoint];
        
        for(int i = 0; i < [groundElectricalArrayOfHoles count]; i++)
        {
            DLLPoint *currentBoardPoint = groundElectricalArrayOfHoles[i];
            
            if([[[self.breadboardStateArray objectAtIndex: currentBoardPoint.xCoord]
                 objectAtIndex: currentBoardPoint.yCoord]
                isKindOfClass:[DLLWire class]])
            {
                DLLWire *currentWire = [[self.breadboardStateArray objectAtIndex: currentBoardPoint.xCoord]
                                        objectAtIndex: currentBoardPoint.yCoord];
                DLLPoint *otherPoint = [currentWire otherBoardHole: currentBoardPoint];
                NSNumber *otherElectricalPoint = [self.boardPointToElectricalPointDictionary valueForKey:[otherPoint toString]];
                DLLElectricalPoint *electricalPoint = [self.electricalPointArray objectAtIndex: otherElectricalPoint];
                if(!(electricalPoint.electricalPointType == EPTypeGround)){
                    chip.isFunctional = NO;
                }
            }
        }
    }
}

- (BOOL) illegalConnectionExists
{
    return NO;
}

- (void) simulateInitialState
{
    // initialize value each electrical pt
    // initialize previousvalue
    // initialize internal state of FF to unknown
    [self simulateCombinational];
}

- (void) simulateCombinational
{
    
}

- (void) simulateThrowOfSwitchLabeled:(int)switchID
{
    // more code necessary here
    [self simulateCombinational];
}

@end
