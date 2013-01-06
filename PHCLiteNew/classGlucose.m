//
//  classGlucose.m
//  PHCLite
//
//  Created by Avi Kulkarni on 8/2/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classGlucose.h"


@implementation classGlucose

@synthesize  glucoseReading;
@synthesize date;
@synthesize tag;


-(void)dealloc
{
           
     date=nil;
     tag=nil;
    
    
    [super dealloc];
}



@end
