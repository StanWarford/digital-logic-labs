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
@property (strong, nonatomic) NSMutableArray *breadboardStateArray;
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
            for(int j = 0; j < numRows; j++)
            {
                boardColumns = [[NSMutableArray alloc] initWithCapacity: numRows];
                [boardColumns insertObject: myNull atIndex: j];
            }
            
            [self.breadboardStateArray insertObject: boardColumns atIndex: i];
        }
    }
    
    return self;
}

#pragma mark -
#pragma mark component addition methods
- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords
{
    
    //add a component to data structure for the active board
    // need internal safety w/ exceptions
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
    //reset XML to default, clear data structure, and set all cells in board array to EMPTY
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
