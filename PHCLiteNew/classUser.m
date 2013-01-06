//
//  classUser.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 7/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classUser.h"


@implementation classUser
@synthesize  firstName,middleName,lastName,gender,emailId,phoneNo,password,userId,memberId,CareGiverPhone,careGiverEmail;
@synthesize medicineList;
@synthesize audioStatus;
@synthesize language;
@synthesize pwdStatus;
@synthesize userImage;







-(void)dealloc
{
    
    firstName=nil;
    middleName=nil;
    lastName=nil;
    gender=nil;
    emailId=nil;
    phoneNo=nil;
    password=nil;    
    medicineList=nil;
    memberId=nil;
    careGiverEmail=nil;
    CareGiverPhone=nil;
    [super dealloc];
}
@end
