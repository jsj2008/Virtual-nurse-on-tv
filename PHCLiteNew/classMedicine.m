//
//  classMedicine.m
//  istrips_bpsi
//
//  Created by Avi Kulkarni on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "classMedicine.h"
#import "classMedicineTime.h"


@implementation classMedicine

@synthesize medicineName,medicineComments;
@synthesize  medicineSequenceId,medicineDosesFrequency;
@synthesize medicineTimes;
@synthesize totalPillQuantity;
@synthesize reorderLevel;
@synthesize doseNumber;
@synthesize medicineImage;
@synthesize audioFileName;



- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
        // now allocate memory, this array will hold classMedicinetime objects, these objet holds time and quantiy
        self.medicineTimes=[[[NSMutableArray alloc] init] autorelease];
        
        
        // create and set 6 objects, since medicine can have 6 times
        for(int i=0; i<=5;i++)
        {
            // create object of classmedicinetime which holds time and quantiy
            classMedicineTime * objTime=[[classMedicineTime alloc] init];
            
            
                // set  dose Number            
                objTime.doseNumber=i+1; 
                
                // initialize
                objTime.times=nil;
                
                // initialize
                objTime.pillQuantity=0;                
            
            
            [self.medicineTimes addObject:objTime];
            
            [objTime release];
        }
        
        
        
    }
    return self;
}



- (void)dealloc 
{
	
	medicineName =nil;
	medicineComments=nil;
    medicineTimes=nil;
	medicineImage=nil;	
	audioFileName=nil;
	
    [super dealloc];
	
	
	
	
}

@end
