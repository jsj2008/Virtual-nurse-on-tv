//
//  commanFunctions.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/5/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classUser.h"

@interface commanFunctions : NSObject 
{
    
}

+(NSString *)timeSpanInString;
+(int)timeSpanInInteger;

//+(NSMutableArray *)genrateMedicineListForTime:(int)timeSpan fromMedicineList:(NSMutableArray*)medicineList;

//+(BOOL)checkIsValidName:(NSString *)value andErrorMessage:(NSString*)message;

+(BOOL)checkIsValidEmail:(NSString *)value andErrorMessage:(NSString*)message;

+(BOOL)checkIsValidPhoneNumber:(NSString *)value andErrorMessage:(NSString*)message;

+(BOOL)checkIsValidName:(NSString *)value andErrorMessage:(NSString*)message;

+(classMedicine *)createCopyOfMedicine:(classMedicine * )aMedicine;


+(NSMutableArray *)getMedicineIndexForTimeSpan:(int)timeSpan forUser:(classUser*)currentUser;

+(int)getTimeSpanOfTime:(NSString *)time;

+(NSString *)convertIntTimeSpanToString:(int)timeSpan;

+(NSMutableArray *)getLogsForMode:(int)mode forMember:(NSString *)memberId;
+(NSString *)genrateMemberId:(NSString *) memberId;
+(NSString*)genrateMemberIdSmall:(NSString *) memberId;
+(NSMutableArray *) getIndexOfmsuresForUser:(classUser *)currentUser :(NSMutableArray *)flags ;

@end
