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
@property (strong, nonatomic) NSMutableDictionary *electricalPointToBoardPointDictionary;
@property (strong, nonatomic) NSMutableDictionary *boardPointToElectricalPointDictionary;
@end

@implementation DLLBoard

@synthesize breadboardStateArray = _breadboardStateArray;
@synthesize activeLab = _activeLab;

#pragma mark -
#pragma mark lazy instantiation methods
- (NSMutableArray *)breadboardStateArray
{
    if (!_breadboardStateArray){
        _breadboardStateArray = [[NSMutableArray alloc] initWithCapacity: 62];
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

- (NSMutableDictionary *)electricalPointToBoardPointDictionary;
{
    if (!_electricalPointToBoardPointDictionary){
        _electricalPointToBoardPointDictionary = [[NSMutableDictionary alloc] init];
    }
    return _electricalPointToBoardPointDictionary;
}

- (NSMutableDictionary *)boardPointToElectricalPointDictionary
{
    if (!_boardPointToElectricalPointDictionary){
        _boardPointToElectricalPointDictionary = [[NSMutableDictionary alloc] init];
    }
    return _boardPointToElectricalPointDictionary;
}

#pragma mark -
#pragma mark initialization methods
- (id)init
{
    // Creates 62 x 62 array w/ all values set to NSNull * myNull
    // define overarching array as rows
    if((self = [super init])){
        int numRows = 62;
        NSNull * myNull = [NSNull null];
    
        NSMutableArray * boardColumns;
        
        for(int i = 0; i < numRows; i++)
        {
            boardColumns = [[NSMutableArray alloc] initWithCapacity: numRows];
            for(int j = 0; j < numRows; j++)
            {
                [boardColumns insertObject: myNull atIndex: j];
            }
            
            [self.breadboardStateArray insertObject: boardColumns atIndex: i];
        }
        
        //[self populateDictionaries];
        // Commented this out to avoid crashes and continue UI testing - Casey
    }
    
    return self;
}

-(void)populateDictionaries
{
    for (int x = 0; x <= 62; x++) {
        NSString * key0 = [[NSNumber numberWithInt: x * 4] stringValue];
        NSString * key1 = [[NSNumber numberWithInt: x * 4 + 1] stringValue];
        NSString * key2 = [[NSNumber numberWithInt: x * 4 + 2] stringValue];
        NSString * key3 = [[NSNumber numberWithInt: x * 4 + 3] stringValue];
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
        [self.electricalPointToBoardPointDictionary setValue: value0 forKey: key0];
        [self.electricalPointToBoardPointDictionary setValue: value1 forKey: key1];
        [self.electricalPointToBoardPointDictionary setValue: value2 forKey: key2];
        [self.electricalPointToBoardPointDictionary setValue: value3 forKey: key3];
    }
    
    // ground = Electrical Point 252
    // power = Electrical Point 253
    NSMutableArray *groundArray = [[NSMutableArray alloc] initWithCapacity:189];
    NSMutableArray *powerArray = [[NSMutableArray alloc] initWithCapacity:189];
    for (int x = 0; x <= 62;x++)
    {
        groundArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 5];
        groundArray[x + 63] = [[DLLPoint alloc] initWithIntX:x andY: 17]; // **CRASHES FIRST TIME THROUGH HERE - Casey
        groundArray[x + 126] = [[DLLPoint alloc] initWithIntX:x andY: 29];
        powerArray[x] = [[DLLPoint alloc] initWithIntX:x andY: 6];
        powerArray[x + 63] = [[DLLPoint alloc] initWithIntX:x andY: 18];
        powerArray[x + 126] = [[DLLPoint alloc] initWithIntX:x andY: 30];
    }
    [self.electricalPointToBoardPointDictionary setValue: groundArray forKey: @"252"];
    [self.electricalPointToBoardPointDictionary setValue: powerArray forKey: @"253"];
    
    // Switch X = Electrical Point 254
    // Debounced Switch X = Electrical Point 255
    // Switch Y = Electrical Point 256
    // Debounced Switch Y = Electrical Point 257
    // SW1-SW8 = Electrical Points 258-265
    for (int x=0; x <= 11; x++) {
        DLLPoint *p1, *p2, *p3, *p4;
        p1 = [[DLLPoint alloc] initWithIntX:x*5 andY: 1];
        p2 = [[DLLPoint alloc] initWithIntX:x*5 andY: 2];
        p3 = [[DLLPoint alloc] initWithIntX:x*5 andY: 3];
        p4 = [[DLLPoint alloc] initWithIntX:x*5 andY: 4];
        NSArray *switchArray = @[p1, p2, p3, p4];
        NSString *key = [[NSNumber numberWithInt: x + 254] stringValue];
        [self.electricalPointToBoardPointDictionary setValue:switchArray forKey: key];
    }
    
    // Lights A-H = Electrical Points 266-273
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
    [self.electricalPointToBoardPointDictionary setValue: lightArray1 forKey: @"266"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray2 forKey: @"267"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray3 forKey: @"268"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray4 forKey: @"269"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray5 forKey: @"270"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray6 forKey: @"271"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray7 forKey: @"272"];
    [self.electricalPointToBoardPointDictionary setValue: lightArray8 forKey: @"273"];
}

#pragma mark -
#pragma mark component addition methods
- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords
{
    //[self.chipDictionary setValue: [[DLLChip alloc] initWithIdenfifier: partNum] forKey: coords.toString];
    // Casey - This line also crashes the program
}

- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *)endingPoint withColor:(UIColor *)color
{
    
    //add a component to the XML file and to data structure for the active board
    // need internal safety w/ exceptions
}



#pragma mark -
#pragma mark component removal methods
- (DLLAComponent*)removeComponentAtCoordinate:(DLLPoint *)coords //this will return component type -Casey
{
    //not necessarily upper left-need to check 2D array
    //remove an existing component from XML file
    return [[DLLChip alloc] init];
}

- (void)clearBoard
{
    //reset XML to default, clear data structure, and set all cells in board array to NSNull
}

#pragma mark -
#pragma mark board state methods

- (DLLAComponent *)boardStateAt:(DLLPoint *)coords
{
    id component = [[self.breadboardStateArray objectAtIndex: coords.xCoord] objectAtIndex: coords.yCoord];
    NSNull * myNull = [NSNull null];
    
    if(component == myNull)
        return nil;
    else return (DLLAComponent *)component;
}

- (BOOL)cellAt: (DLLPoint *)coords IsAvailableForComponentOfSize: (NSUInteger) size
{
    /*
        Wire size = 1
        ALU size = 24
        All other chips size = 14 or 16, respectively
     */
    
    //reminder: ALU spans double the rows
    NSArray * validChipRows = @[@39, @40, @49, @50];
    // TODO: add correct coordinates for switch slots
    //NSArray * validSwitchSlots  = @[
    //                                [[DLLPoint(20, 10) alloc] init],
    //                                [[DLLPoint(30, 10) alloc] init]
    //                                ];
    
    if(size == 1) // wire
    {
        if ([self boardStateAt: coords]) return NO;
    } else if (size == 24) // ALU
    {
        if(![validChipRows containsObject: [NSNumber numberWithInt: coords.yCoord]])
            return NO;
        
    } else // chip
    {
    
        if(![validChipRows containsObject: [NSNumber numberWithInt: coords.yCoord]])
            return NO;
        
        for(int leftLimit = coords.xCoord; coords.xCoord <= leftLimit + size / 2; coords.xCoord++)
        {
            if([self boardStateAt: coords]) return NO;
        }
    }
    
    return YES;
}

// 2D needs to be 63x25 w/ 63rd row as a 'trash' row, items put here will not be added-mark as always unavailable
@end
