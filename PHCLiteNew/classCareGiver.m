//
//  classCareGiver.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 9/10/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classCareGiver.h"

@implementation classCareGiver
@synthesize Name,emailId,phoneNo,userId;
//@synthesize medicineList;
@synthesize caregiverImage;
-(void)dealloc
{
    
    Name=nil;
     emailId=nil;
    phoneNo=nil;
    
    [super dealloc];
}

@end
