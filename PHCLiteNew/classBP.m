//
//  classBP.m
//  PHCLite
//
//  Created by Avi Kulkarni on 05/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classBP.h"


@implementation classBP
@synthesize SystolicReading;
@synthesize date;
@synthesize DiastolicReading;
@synthesize PulseReading;
@synthesize BPReading;

-(void)dealloc
{
    date=nil;
    
    [super dealloc];
 
}

@end
