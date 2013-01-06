//
//  classDatabaseOperations.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 7/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classCareGiver.h"
#import "remindMed.h"
@class classUser;
@interface classDatabaseOperations : NSObject 
{
    
   // NSMutableArray *arrayO
    
    
}


+(void)checkAndCreateDatabase;
+(NSMutableArray *)getUserList;
+(NSMutableArray *)getCareGiverList;
+(void)deleteLogs:(classUser *)userClassObject;

+(void)updateUser:(classUser*)userClassObject;
+(BOOL)addNewUser:(classUser*)userClassObject;
+(void)deleteUser:(classUser*)userClassObject;
+(int)getLanuageStatus:(int)objUser;

//------------- medicine related database functions------
+(BOOL)addNewMedicine:(classMedicine *)medicineClassObject forMemberId:(NSString *)memberId;
+(BOOL)deleteMedicineWithId:(int)medicineId forMemberId:(NSString *)memberId;

+(int)getIdOfMedicine:(NSString *)name forMemberId:(NSString *)memberId;
+(NSMutableArray *)getMedicineListForUser:(classUser *)currentUser;

+(void)deleteMethodTypes:(NSString *)logTypes forUser:(classUser *)userClassObject;

+(void)updateMedicine:(classMedicine*)upadatedMedicine forMemberId:(NSString * )memberId;


+(BOOL)checkMedicineExistOrNot:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId;
+(BOOL)updateQuantityTakenForMedicine:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId byQyantity:(float)quantity;
+(BOOL)addLogForMedicine:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId byQyantity:(float)quantity;
+(float)getSumOfQuantityTaken:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId;
+(BOOL)updateTotalPillQuantityForMedicine:(int)medicineId newPillQuantity:(float)totalQuantity forMemberId:(NSString *)memberId;
+(NSMutableArray *)getBayMedicineListForUser:(int)userid:(int)bayno;
+(void)updateDailyLog;
//+(NSMutableArray *)getAllLogsForMember:(int)userId ;
+(int)add:(NSString *)queryString;
//+(int)getMedicineId:(NSString *)medicineName userId:(NSString *)userId;
+(float)get:(NSString *)queryString ;
//+(NSMutableArray *)getFlags;
+(void)updateFlags:(NSString *)queryString;
+(int)addData:queryString;
+(NSMutableArray *)getMedicineList;
+(NSString *)getNurseImg:(int)userid;
+(NSMutableArray *)getData:(NSString *)type :(int)userid;
+(NSMutableArray *)getFlags: (int )userid :(int ) timespan;
+(NSMutableArray *)getStatus:(NSString *)type :(int)userid;
+(NSMutableArray *)chkStatus:(int)medicineid :(int)userid:(NSString *)medicinetime;
+(NSString *)getString:(NSString *)queryString;
+(NSMutableArray *)getMedicineData:(int)userid;
+(NSMutableArray *)generateMedicineListForTime:(NSMutableArray*)medicineList:(classUser *)currentUser;
+(NSMutableArray *)getBPData:(NSString *)type :(int)userid;
+(NSMutableArray *)AllLogs:(int)userid;

@end
