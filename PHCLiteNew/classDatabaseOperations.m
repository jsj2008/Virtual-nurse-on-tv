
//
//  classDatabaseOperations.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 7/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classDatabaseOperations.h"
#import "classUser.h"
#import "commanFunctions.h"
#import "classAudio.h"
#import "classMedicine.h"
#import "commanFunctions.h"
#import "classMedicineIndex.h"
#import "classCompartmentData.h"
#import "classLogm.h"
#import "classCareGiver.h"

@implementation classDatabaseOperations



+(void)checkAndCreateDatabase
{
    
    NSString * databaseName = @"iStripsDataBase.SQLite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString * databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
   NSLog(@"databasepath=%@",databasePath); 
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:databasePath];
  //  NSLog(@"sucess=%d",success);
    
    // if database is already exist return back
	if (success)
        return;
    // else copy our db file to document folder of phone, ths db contains our all tables
	NSString *databasePathFromApp= [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
//	NSLog(@"database path string=%@",databasePathFromApp);
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	//[fileManager release];
    //medicine name
    
    //Adding nurse image.
       //*********ANA
    
    NSString * imgName = @"Ana";
    // covert Medicne image to nsdata
    UIImage *anaNurse=[UIImage imageNamed:@"Ana"];
    NSData* imageData = UIImagePNGRepresentation(anaNurse);
     // get path of document directory to save medicne
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:imgName];
     // and then we write it out
    [imageData writeToFile:databasePath atomically:NO];
    
    //*********MERRY

    imgName = @"Merry";
    // covert Medicne image to nsdata
    anaNurse=[UIImage imageNamed:@"Merry"];
   imageData = UIImagePNGRepresentation(anaNurse);
    
    // get path of document directory to save medicne
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:imgName];
    // and then we write it out
    [imageData writeToFile:databasePath atomically:NO];
    
     //*********Delsy
    imgName = @"Delsy";
    // covert Medicne image to nsdata
    anaNurse=[UIImage imageNamed:@"Delsy"];
    imageData = UIImagePNGRepresentation(anaNurse);
    
    // get path of document directory to save medicne
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:imgName];
    // and then we write it out
    [imageData writeToFile:databasePath atomically:NO];
    
    //*********Martha
    imgName = @"Martha";
    // covert Medicne image to nsdata
    anaNurse=[UIImage imageNamed:@"Martha"];
    imageData = UIImagePNGRepresentation(anaNurse);
    
    // get path of document directory to save medicne
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:imgName];
    // and then we write it out
    [imageData writeToFile:databasePath atomically:NO];
    
    //*********Jeny
    imgName = @"Jeny";
    // covert Medicne image to nsdata
    anaNurse=[UIImage imageNamed:@"Jeny"];
    imageData = UIImagePNGRepresentation(anaNurse);
    
    // get path of document directory to save medicne
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:imgName];
    // and then we write it out
    [imageData writeToFile:databasePath atomically:NO];

    imgName = @"DefaultUser";
    // covert Medicne image to nsdata
    anaNurse=[UIImage imageNamed:@"userImage"];
    imageData = UIImagePNGRepresentation(anaNurse);
    
    // get path of document directory to save medicne
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:imgName];
    // and then we write it out
    [imageData writeToFile:databasePath atomically:NO];
    
}

+(NSMutableArray *)getUserList
{
    
    NSMutableArray * arrayOfUsers=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=@"SELECT * FROM user";
    sqlite3_stmt * statement;
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
    
    
    
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // create a new user
                classUser * aUser=[[classUser alloc] init];
                
                // set all detaisl of user
                NSString * userId=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 0)];
                NSString * memberId=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 1)]; 
                NSString * audioStatus1=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 2)];
                
                NSString * phoneNo=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 5)];
                NSString * emailId=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement,6)];
                NSString *fName = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 7)];
                NSString *gender = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 8)];
                NSString *lName = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 9)];
                NSString *password =[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 10)];
                
                NSString * careGiverphoneNo=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 12)];
                NSString * careGiveemailId=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement,11)];
                
                

               
                if([memberId isEqualToString:@"(null)"] || memberId==nil)
                {
                    
                  memberId=@"";  
                    
                }
                
                if([audioStatus1 isEqualToString:@"(null)"])
                 { 
                     audioStatus1=@"YES";
                 }
                
                if([fName isEqualToString:@"(null)"] || fName==nil)
                {
                    
                    fName=nil; 
                }
                
                if([lName isEqualToString:@"(null)"] || lName==nil)
                {
                    lName=nil;
 
                    
                }
                
                if([gender isEqualToString:@"(null)"] || gender==nil)
                {
                   gender=@"M";
 
                    
                }if([phoneNo isEqualToString:@"(null)"] || phoneNo==nil)
                {
                  phoneNo=nil;

                    
                }
                
                if([emailId isEqualToString:@"(null)"] || emailId==nil)
                {
                    emailId=nil;
 
                    
                }
                if([careGiverphoneNo isEqualToString:@"(null)"] || careGiverphoneNo==nil)
                {
                    careGiverphoneNo=nil;
                    
                    
                }
                
                if([careGiveemailId isEqualToString:@"(null)"] || careGiveemailId==nil)/// not give it shoud be giver :-)
                {
                    careGiveemailId=nil;
                    
                    
                }
                
                
                if([password isEqualToString:@"(null)"] || password==nil)
                {
                   password=nil;

                    
                }
               
               
                aUser.userId=[userId intValue];
                aUser.memberId=memberId;
                
                if([audioStatus1 isEqualToString:@"YES"])
                 {
                aUser.audioStatus=YES;
                 }
                else
                {
                    aUser.audioStatus=NO;
                }
                aUser.firstName=fName;
                aUser.lastName=lName;
                aUser.gender=gender;
                aUser.password=password;
                aUser.phoneNo=phoneNo;
                aUser.emailId=emailId;
                aUser.CareGiverPhone=careGiverphoneNo;
                aUser.careGiverEmail=careGiveemailId;
                
                // get medicne image from document folder
                NSString * imgName = [NSString stringWithFormat:@"%@%@",aUser.firstName, aUser.lastName];
                
                
                // get path of document directory to get medicne image
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
                UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
                aUser.userImage=medicineImage;
                
                
                NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
                NSString * audioStatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
                
                
                NSLog(@"%@",audioStatus);
                if([audioStatus isEqualToString:@"on"]|| audioStatus==nil)
                {
                    if(audioStatus ==nil)// in case if audio status is  not already set, set it to on
                    {
                        
                        [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
                        
                    }
                    
                    
                    aUser.audioStatus=YES;
                    
                }
                else
                {
                    aUser.audioStatus=NO;
                    
                    
                }
                
                
                
                [arrayOfUsers addObject:aUser];
                
                [aUser release];
                
            }
            
            
            
        }
        
    }
    
    
    
    // NSLog(@"Total Users %d",[arrayOfUsers count]);
    return [arrayOfUsers autorelease];
}
+(NSMutableArray *)getCareGiverList
{
    NSMutableArray * arrayOfCareGiver=[[[NSMutableArray alloc] init]autorelease];
    
    
    sqlite3 *db;
    
    NSString * qsql=@"SELECT * FROM newCareGiver";
    sqlite3_stmt * statement;
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	const char *dbpath = [databasePath UTF8String];
    
    
    
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // create a new user
                 classCareGiver *classCareGiverObj=[[classCareGiver alloc] init];
                
                // set all detaisl of user
                NSString * userId=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 0)];
                NSString * careGiverPhone=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 2)];
                NSString * careGiverEmailId=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 3)];
                NSString * careGiverName=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 4)];
                                
                
                
                if([userId isEqualToString:@"(null)"] || userId==nil)
                {
                    
                    userId=@"";
                    
                }
                
                if([careGiverPhone isEqualToString:@"(null)"])
                {
                    careGiverPhone=@"YES";
                }
                
                if([careGiverEmailId isEqualToString:@"(null)"] || careGiverEmailId==nil)
                {
                    
                    careGiverEmailId=nil;
                }
                
                if([careGiverName isEqualToString:@"(null)"] || careGiverName==nil)
                {
                    careGiverName=nil;
                    
                    
                }
                
                                
                classCareGiverObj.userId=[userId intValue];
                
//                if([audioStatus isEqualToString:@"YES"])
//                {
//                    aUser.audioStatus=YES;
//                }
//                else
//                {
//                    aUser.audioStatus=NO;
//                }
                classCareGiverObj.Name=careGiverName;
                classCareGiverObj.phoneNo=careGiverPhone;
                classCareGiverObj.emailId=careGiverEmailId;
                               
                // get medicne image from document folder
                NSString * imgName = [NSString stringWithFormat:@"%@",classCareGiverObj.Name];
                
                
                // get path of document directory to get medicne image
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
                UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
                classCareGiverObj.caregiverImage=medicineImage;
                
                [arrayOfCareGiver addObject:classCareGiverObj];
                
                [classCareGiverObj release];
                
            }
            
            
            
        }
        
    }
    return arrayOfCareGiver;
}


+(void)updateUser:(classUser*)userClassObject
{
    
    sqlite3 *db;
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        const char *insert_stmt = [[NSString stringWithFormat:@"update  user set fname='%@', lname='%@', gender='%@' where userid='%d'",userClassObject.firstName,userClassObject.lastName,userClassObject.gender,userClassObject.userId] cStringUsingEncoding:NSUTF8StringEncoding];
		int result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		if ( result == 0)
		{
			//NSLog(@"Record Save successfully");
			
		} 
		else 
		{
			//NSLog(@"Problem in saving records");
		}
		
		
		sqlite3_close(db);
		
	} 
    
    
   // NSLog(@"update  user set fname='%@', lname='%@', gender='%@' where userid='%@'",userClassObject.firstName,userClassObject.lastName,userClassObject.gender,userClassObject.userId);
    
}

+(BOOL)addNewUser:(classUser*)userClassObject
{
    
    sqlite3 *db;
	int result=0;
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        const char *insert_stmt = [[NSString stringWithFormat:@"insert into user (memberid,fname, lname, gender,emailid,phoneno,password) values ('%@','%@','%@','%@','%@','%@','%@')",userClassObject.memberId, userClassObject.firstName,userClassObject.lastName,userClassObject.gender,userClassObject.emailId,userClassObject.phoneNo,userClassObject.password] cStringUsingEncoding:NSUTF8StringEncoding];
        result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		
	} 
	
    sqlite3_close(db);
    
    
    if ( result == 0)
    {
       // NSLog(@"Record Save successfully");
        return  YES;
        
    } 
    else 
    {
        //NSLog(@"Problem in saving records");
        return NO;
    }
    
  //  NSLog(@"%@",[NSString stringWithFormat:@"insert into user (memberid,fname, lname, gender,emailid,phoneno password) values ('%@','%@','%@','%@','%@','%@','%@')",userClassObject.memberId, userClassObject.firstName,userClassObject.lastName,userClassObject.gender,userClassObject.emailId,userClassObject.phoneNo,userClassObject.password]);
    
    
}

+(void)deleteLogs:(classUser *)userClassObject
{
    sqlite3 *db;
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        const char *insert_stmt =[[NSString stringWithFormat:@"delete from healthydata where userid=%d",userClassObject.userId] cStringUsingEncoding:NSUTF8StringEncoding];
		int result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		if ( result == 0)
		{
			//NSLog(@"User deleted successfully");
			
		}
		else
		{
			//NSLog(@"Problem in deleting User");
		}
		
		
		sqlite3_close(db);
		
	}

}
+(void)deleteMethodTypes:(NSString *)logTypes forUser:(classUser *)userClassObject
{
    sqlite3 *db;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
    
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *insert_stmt =[[NSString stringWithFormat:@"delete from healthydata where type='%@' and userid=%d",logTypes,userClassObject.userId] cStringUsingEncoding:NSUTF8StringEncoding];
        int result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
        
        if ( result == 0)
        {
            //NSLog(@"User deleted successfully");
            
        }
        else
        {
            //NSLog(@"Problem in deleting User");
        }
        
        
        sqlite3_close(db);
        
    }
    
}

+(void)deleteUser:(classUser*)userClassObject
{
    
    
    
    sqlite3 *db;
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        const char *insert_stmt =[[NSString stringWithFormat:@"delete from user where userid=%d",userClassObject.userId] cStringUsingEncoding:NSUTF8StringEncoding];
		int result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		if ( result == 0)
		{
			//NSLog(@"User deleted successfully");
			
		} 
		else 
		{
			//NSLog(@"Problem in deleting User");
		}
		
		
		sqlite3_close(db);
		
	} 
	
    
    
}



// this method return id of medicine
+(int)getIdOfMedicine:(NSString *)name forMemberId:(NSString *)memberId
{
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"select medicineid from medicine where medicinename='%@' and memberid=@'%@'",name,memberId];
    
  //  NSLog(@"%@",[NSString stringWithFormat:@"select medicineid from medicine where medicinename='%@' and memberid=%'%@'",name,memberId]);
    sqlite3_stmt * statement;
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
    
    // variable to hold medicine id
    int medicineid=0;
    
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                
                
                medicineid = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]intValue];
                
                
            }
            
            
            
        }
        
    }
    
    
    
    return medicineid;    
    
    
    
}



+(BOOL)addNewMedicine:(classMedicine *)medicineClassObject forMemberId:(NSString *)memberId
{
    
    sqlite3 *db;
	int result;
    int count=0;
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        
        
        // addd medicine in medicine table
        const char *insert_stmt = [[NSString stringWithFormat:@"insert into medicine (medicinename,medicinetotalpillquantity, medicinefrequency,reorderlevel,medicinecomments,memberid) values ('%@',%.1f,%d,%d,'%@','%@')",medicineClassObject.medicineName,medicineClassObject.totalPillQuantity,medicineClassObject.medicineDosesFrequency,medicineClassObject.reorderLevel,medicineClassObject.medicineComments,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
        
       // NSLog(@"%@",[NSString stringWithFormat:@"insert into medicine (medicinename,totalquantity, frequency,reorderlevel,medicinecomments,memberid) values ('%@',%.1f,%d,%d,'%@','%@')",medicineClassObject.medicineName,medicineClassObject.totalPillQuantity,medicineClassObject.medicineDosesFrequency,medicineClassObject.reorderLevel,medicineClassObject.medicineComments,memberId] ) ;
        
        
		 result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
        sqlite3_close(db);

    } 
    else 
    {
       // NSLog(@"Problem in saving Medicine");
        
        return NO;
    }
    
    
    
		if ( result == 0)
		{
			//NSLog(@"Meidicine Saved successfully");
            
            int medicineId=[classDatabaseOperations getIdOfMedicine:medicineClassObject.medicineName forMemberId:memberId];
            
            
            //---now add medicne time and quantity details in  medicinetimedetails table-----     
            for(classMedicineTime * objMedicineTime in medicineClassObject.medicineTimes)
            {
                
                if(objMedicineTime.times !=nil)
                {
                    
                    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
                    {
                        
                        const char *insert_stmt1 = [[NSString stringWithFormat:@"insert into medicinetimedetails (medicineid,medicinetime,medicinepillquantitytotake,doseNumber,memberid) values (%d,'%@',%.1f,%d,'%@')",medicineId,objMedicineTime.times,objMedicineTime.pillQuantity,objMedicineTime.doseNumber,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
                      //  NSLog(@"%@",[NSString stringWithFormat:@"insert into medicinetimedetails (medicineid,medicinetime,medicinepillquantitytotake,doseNumber,memberid) values (%d,'%@',%.1f,%d,'%@')",medicineId,objMedicineTime.time,objMedicineTime.pillQuantity,objMedicineTime.doseNumber,memberId]);
                        
                        result = sqlite3_exec(db, insert_stmt1, NULL, NULL, nil);
                        
                        //close database
                         sqlite3_close(db);
                        
                        if ( result == 0)
                        {
                           // NSLog(@"Medicine details saved successfully");
                            
                            count++;
                            
                        }                
                        
                        
                    }
                }
                
            }
            
            
        } // end of if
        
           
			
		
		
               
        
	return YES;	    
    
}

+(NSMutableArray *)getMedicineListForUser:(classUser *)currentUser
{
    
    //NSLog(@"Medicine list loded");
    
    NSMutableArray * arrayOfMedicines=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM medicine where userid=%d",currentUser.userId];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // create a new user
                classMedicine * aMedicine=[[classMedicine alloc] init];
                
                // set all detaisl of medicine
                NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString * medicineName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                NSString * medicineFrequency=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString * medicineTotalPillQuantity=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                NSString * reorderLevel=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 1)];
                NSString * medicineComments=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 2)];
                
                aMedicine.medicineSequenceId=[medicineId intValue];
                aMedicine.medicineName=medicineName;
                aMedicine.medicineDosesFrequency=[medicineFrequency intValue];
                aMedicine.totalPillQuantity=[medicineTotalPillQuantity floatValue];
                aMedicine.reorderLevel=[reorderLevel intValue];
                
             //   NSLog(@"Comments length :%d",[medicineComments length] );
                
                if([medicineComments isEqualToString:@"(null)"] || medicineComments==nil||[medicineComments length]<=0)
                {
                    
                    medicineComments=@"No Comments";  
                    
                }
                
                aMedicine.medicineComments= medicineComments;
                
         // get medicne image from document folder                
                NSString * imgName = [NSString stringWithFormat:@"%@%@%@",aMedicine.medicineName,currentUser.firstName,currentUser.lastName];
               
                
                // get path of document directory to get medicne image
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
                UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];                
                aMedicine.medicineImage=medicineImage;                                
                
             // get audio file name, this audio file name need to be implemented, not used anywhere
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *path = [documentsDirectory stringByAppendingPathComponent:[aMedicine.medicineName lowercaseString]];
                
               
                
               // NSLog(@"%@",audioFilePath);
                if([fileManager fileExistsAtPath:path]==YES)
                {
                   
                    aMedicine.audioFileName=aMedicine.medicineName;
                }
                
               
                
                [arrayOfMedicines addObject:aMedicine];
                
                [aMedicine release];
            }
            
            
            
        }
        
    }
    
    sqlite3_close(db);
    
    // now get medicin time and quantity   
    for(int i=0;i<[arrayOfMedicines count]; i++)
    {
        classMedicine * objMedicine=[arrayOfMedicines objectAtIndex:i];
        
       // objMedicine.medicineTimes=[[[NSMutableArray alloc] init] autorelease];
        
        NSString * qsql1=[NSString stringWithFormat:@"SELECT * FROM medicinetimedetails where userid=%d and medicineid=%d",currentUser.userId,objMedicine.medicineSequenceId];
        
       // NSLog(@"%@",qsql1);
        if(sqlite3_open(dbpath , &db) == SQLITE_OK)
        {
            
            
            //
            int index=0;
            classMedicineTime * medicineTimeAndQuantity;
            
            if(sqlite3_prepare_v2(db,[qsql1 UTF8String], -1, &statement, NULL)==SQLITE_OK)
            {
                
                while (sqlite3_step(statement)==SQLITE_ROW)
                {
                    // get next object that continn medicine time,quantity to take and dosenumber
                    medicineTimeAndQuantity=[objMedicine.medicineTimes objectAtIndex:index];
                    
                    // get all detaisl of medicine
                    NSString * medicineTime=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                    NSString * medicinePillQuantity=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                    NSString * doseNumber=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    
                    // set values                    
                    medicineTimeAndQuantity.times=medicineTime;
                    medicineTimeAndQuantity.timeSpan=[commanFunctions convertIntTimeSpanToString:[commanFunctions getTimeSpanOfTime:medicineTime]];
                    medicineTimeAndQuantity.pillQuantity=[medicinePillQuantity floatValue];
                    medicineTimeAndQuantity.doseNumber=[doseNumber intValue];
                    
                    
                    // increment the index so that we can getnext medicinetime object,
                    index++;
                    
                }
                
                
                
               // NSLog(@"TimesArray length:%d",[objMedicine.medicineTimes count]);
                
                
                
            }
            
        }
        
        sqlite3_close(db);

    }
    
    
   
    
    NSLog(@"Added");
    for(int i=0;i<arrayOfMedicines.count;i++)
    {
        NSLog(@"%@",[arrayOfMedicines objectAtIndex:i]);
    }

    
    return [arrayOfMedicines autorelease];
}


+(BOOL)deleteMedicineWithId:(int)medicineId forMemberId:(NSString *)memberId
{
    
    
    
    sqlite3 *db;
	int result=0;
    
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        const char *insert_stmt =[[NSString stringWithFormat:@"delete from medicine where medicineid=%d and memberid='%@'",medicineId,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
		 result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
        //NSLog(@"%@",[NSString stringWithFormat:@"delete from medicine where medicineid=%d and memberid='%@'",medicineId,memberId]);
        
		
	} 
	
    sqlite3_close(db);
    
    
    // if medicine deleted successcully delete its details too
    if(result==0)
    {
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            const char *insert_stmt =[[NSString stringWithFormat:@"delete from medicinetimedetails where medicineid=%d and memberid='%@'",medicineId,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
            result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
            
            //NSLog(@"%@",[NSString stringWithFormat:@"delete from medicinetimedetails where medicineid=%d and memberid='%@'",medicineId,memberId]);
        } 
       else
       {
           
           result=1;
       }
        
         sqlite3_close(db);
    }
    
    
    if(result==0)
    {
        
        return  YES;
        
    }
    
    return NO;
    
}

+(void)updateMedicine:(classMedicine*)upadatedMedicine forMemberId:(NSString * )memberId;
{
    
    sqlite3 *db;
	int result=0;
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{

        const char *insert_stmt = [[NSString stringWithFormat:@"update medicine set medicinename='%@' , medicinefrequency=%d, medicinetotalpillquantity=%.1f, reorderlevel=%d, medicinecomments='%@' where medicineid=%d and memberid='%@'",upadatedMedicine.medicineName,upadatedMedicine.medicineDosesFrequency,upadatedMedicine.totalPillQuantity,upadatedMedicine.reorderLevel,upadatedMedicine.medicineComments, upadatedMedicine.medicineSequenceId,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@",[NSString stringWithFormat:@"update medicine set medicinename='%@' , medicinefrequency=%d, medicinetotalpillquantity=%.1f where medicineid=%d and memberid='%@'",upadatedMedicine.medicineName,upadatedMedicine.medicineDosesFrequency,upadatedMedicine.totalPillQuantity,upadatedMedicine.medicineSequenceId,memberId]);
		 result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		sqlite3_close(db);
        
        
       
	} 
    
    if(result==0)
    {
        
        
        
        
        
        
    }
    
    
    
    
    
}


+(BOOL)checkMedicineExistOrNot:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId
{
       sqlite3 *db;
        
        NSString * qsql=[NSString stringWithFormat:@"select count() from dailylog where medicineid=%d and memberid='%@' and doseNumber=%d",medicineId,memberId,doseNumber];
        
       // NSLog(@"%@",[NSString stringWithFormat:@""]);
        sqlite3_stmt * statement;
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
        
        const char *dbpath = [databasePath UTF8String];
        
        // variable to hold medicine id
        int count=0;
        
        if(sqlite3_open(dbpath , &db) == SQLITE_OK)
        {
            
            
            //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
            
            if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
            {
                
                while (sqlite3_step(statement)==SQLITE_ROW)
                {
                    
                    
                    count = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]intValue];
                    
                    
                }
                
                
                
            }
            
        }
        
        
    sqlite3_close(db);    
 
       
        
        
     if(count!=0) // medicine exist
     {
         return YES;
     }
    
    

         return NO;
    
   
}

+(BOOL)addLogForMedicine:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId byQyantity:(float)quantity
{
     sqlite3 *db;
    
    // medicine does not exist in dailylog dtabase then add it in log table
    if(![classDatabaseOperations checkMedicineExistOrNot:medicineId forDoseNumber:doseNumber forMemberId:memberId])
    {
        int result;
        
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];	
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];           
            
            // current Time
            NSString * currentDate=[dateFormatter stringFromDate:[NSDate date]];
            
            [dateFormatter release];
            
            // addd medicine in medicine table
            const char *insert_stmt = [[NSString stringWithFormat:@"insert into dailylog (medicineid,doseNumber,quantitytaken,date,memberid) values (%d,%d,%.1f, '%@', '%@')",medicineId,doseNumber,quantity,currentDate,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
            
                      
            
            result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
            
            sqlite3_close(db);
            
        } 
        else 
        {
           // NSLog(@"Problem in saving log");
            
            return NO;
        }
        

        if(result!=0)
        {
            
            
            return NO;
        }
        
        
    }
    else // update quantiy taken
    {
        
       [classDatabaseOperations updateQuantityTakenForMedicine:medicineId forDoseNumber:doseNumber forMemberId:memberId byQyantity:quantity];
        
    }
    
    
    return YES;
}


+(float)getSumOfQuantityTaken:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId
{
   
    sqlite3 *db;
    
    
    NSString * qsql=[NSString stringWithFormat:@"select sum(quantitytaken) from dailylog where medicineid=%d and doseNumber=%d and memberid='%@'",medicineId,doseNumber,memberId];
    
  //  NSLog(@"%@",[NSString stringWithFormat:@""]);
    sqlite3_stmt * statement;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
    
    const char *dbpath = [databasePath UTF8String];
    
    // variable to hold medicine id
    float sum=0;
    
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                
                sum=[[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 0)] floatValue];
                
               // sum =[[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]floatValue];
                
                
            }
            
            
            
        }
        
    }
    
   
    
    return sum;   
}

+(BOOL)updateQuantityTakenForMedicine:(int)medicineId forDoseNumber:(int)doseNumber forMemberId:(NSString*)memberId byQyantity:(float)quantity;
{
    
    
    sqlite3 *db;
    
   
        int result;
        
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];	
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            //getQuantity
            float oldQuantity=[classDatabaseOperations getSumOfQuantityTaken:medicineId forDoseNumber:doseNumber forMemberId:memberId];
            float updatedQuantity=oldQuantity+quantity;
            
            // addd medicine in medicine table
            const char *insert_stmt = [[NSString stringWithFormat:@"update dailylog set quantityTaken=%.1f where medicineid=%d and doseNumber=%d and memberid='%@'",updatedQuantity,medicineId,doseNumber,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
            
            
            
            result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
            
            sqlite3_close(db);
            
        } 
        else 
        {
            //NSLog(@"Problem in updateing quantity Medicine");
            
            return NO;
        }
        
        
        if(result!=0)
        {
            
            
            return NO;
        }
        
       
    
    return YES;// updated successfully  
    
}


+(BOOL)updateTotalPillQuantityForMedicine:(int)medicineId newPillQuantity:(float)totalQuantity forMemberId:(NSString *)memberId
{
    
    
    sqlite3 *db;    
        int result;
        
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];	
        NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            
            // addd medicine in medicine table
            const char *insert_stmt = [[NSString stringWithFormat:@"update medicine set medicinetotalpillquantity=%.1f where medicineid=%d and memberid='%@'",totalQuantity,medicineId,memberId] cStringUsingEncoding:NSUTF8StringEncoding];
            
            
            
            result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
            
            sqlite3_close(db);
            
        } 
        else 
        {
            //NSLog(@"Problem in updateing quantity Medicine");
            
            return NO;
        }
        
        
        if(result!=0)
        {
            
            
            return NO;
        }

    
    return YES;// updated successfully     
    
    
}

+(void)updateDailyLog
{
    
    
    
    sqlite3 *db;    
    
    // get todays date
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];   
    
    
    // current Time
    NSString * currentDate=[dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter release];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];	
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        
        // addd medicine in medicine table
        const char *insert_stmt = [[NSString stringWithFormat:@"update dailylog set date='%@', quantitytaken=0 where date  != '%@'",currentDate,currentDate] cStringUsingEncoding:NSUTF8StringEncoding];
        
        
        
         sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
        
        sqlite3_close(db);
        
    } 
       
    
    
}



+(int)add:(NSString *)queryString
{
    int result=0;    
    sqlite3 *db;
	
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        const char *insert_stmt = [queryString cStringUsingEncoding:NSUTF8StringEncoding];
        result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		NSLog(@"added  ");
	} 
	
    sqlite3_close(db);    
    
   
   // NSLog(@"%@",queryString);
    
    return result;
}

+(float)get:(NSString *)queryString
{
    
    
    sqlite3 *db;
    float result=0;
    
    NSString * qsql=queryString;
    
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
        
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                
                
                result = [[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 0)]floatValue];
                //NSLog(@"%.1f",result);
                
            }
            
            
            
        }
        
    }
    
  
    sqlite3_close(db);    


    return result;
    
    
}

+(NSMutableArray *)getFlags: (int )userid :(int ) timespan
{
    
    //NSLog(@"Medicine list loded");
    
    NSMutableArray * arrayOfFlags=[[[NSMutableArray alloc] initWithObjects: nil]autorelease];
    
    
    sqlite3 *db;
    
    const char * qsql=[[NSString stringWithFormat:@"SELECT * FROM vnscripts where userid=%d and timespan= %d",userid,timespan]cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_stmt * statement;    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];	
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
    const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,qsql,-1,&statement,NULL)==SQLITE_OK)
        {
            
            
            
            if (sqlite3_step(statement)==SQLITE_ROW)
            {
              
                  
                    NSString *userId=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
                    NSString * wtflag=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                    NSString * bgflag=[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 2)];
                    NSString * bpflag=[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 3)];
                    NSString * hgflag=[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 4)];
                    NSString * hga1cflag=[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 5)];
                  NSString * medflag=[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 6)];
                     [arrayOfFlags addObject:userId];
                    [arrayOfFlags addObject:wtflag];
                    [arrayOfFlags addObject:bgflag];
                    [arrayOfFlags addObject:bpflag];
                    [arrayOfFlags addObject:hgflag];
                    [arrayOfFlags addObject:hga1cflag];
              [arrayOfFlags addObject:medflag];
               
                while (sqlite3_step(statement)==SQLITE_ROW)
                { }
                
               // }
                NSLog(@"count of array %d", arrayOfFlags.count);
                int     i=0;
                while ( i < arrayOfFlags.count) {
                    
                    NSLog(@"\n%@ ,\t%d\n",[arrayOfFlags objectAtIndex:i],i );
                    i++;
                }
                
            }
        }
    }
    sqlite3_close(db);
    
    return arrayOfFlags;
}

 




+(void)updateFlags:(NSString *)queryString
{
    
    sqlite3 *db;
    const char *qsql=[queryString cStringUsingEncoding:NSUTF8StringEncoding];
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
	
	
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
        
      /*  const char *insert_stmt = [[NSString stringWithFormat:@"update vnscrips set wtflag='%@' , bgflag=%d,bpflag=%.1f, hgflag=%d, hga1cflag='%@' where userid='%@'",upadatedMedicine.medicineName,upadatedMedicine.medicineDosesFrequency,upadatedMedicine.totalPillQuantity,upadatedMedicine.reorderLevel,upadatedMedicine.medicineComments, upadatedMedicine.medicineSequenceId,userId] cStringUsingEncoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@",[NSString stringWithFormat:@"update medicine set medicinename='%@' , medicinefrequency=%d, medicinetotalpillquantity=%.1f where medicineid=%d and memberid='%@'",upadatedMedicine.medicineName,upadatedMedicine.medicineDosesFrequency,upadatedMedicine.totalPillQuantity,upadatedMedicine.medicineSequenceId,memberId]);
       */ 
          sqlite3_exec(db, qsql, NULL, NULL, nil);
 
        
		sqlite3_close(db);
        
        
        
	}
    
}

+(int)addData:queryString
{   
    int result =0;
    
    sqlite3 *db;
   // NSString queryString=[NSString stringWithFormat:@"insert into healthydata values(%d,%d,%@,%@,%@,%@,%d,%d,%d)",]
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	
	const char *dbpath = [databasePath UTF8String];
    
    
    
	if (sqlite3_open(dbpath, &db) == SQLITE_OK)
	{
       const char *insert_stmt = [queryString cStringUsingEncoding:NSUTF8StringEncoding];
        result = sqlite3_exec(db, insert_stmt, NULL, NULL, nil);
		
		NSLog(@"added  ");
	} 
	
    sqlite3_close(db);    
    
    
    // NSLog(@"%@",queryString);
    
    return result;

    
    
    
}





+(NSMutableArray *)getMedicineList
{
    
    //NSLog(@"Medicine list loded");
    
    NSMutableArray * arrayOfMedicines=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT medicinename,medicineid FROM medicine where userid=%d",1];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                           // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString * medicineName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                                             
                
                    [arrayOfMedicines addObject:medicineName];
                
                           }
        } 
            
    }      
        
    return [arrayOfMedicines autorelease];
}



/*


+(NSMutableArray *)getData:(NSString *)type
{   
    
    NSMutableArray * arrayOfLog=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM healthydata where type='%@'",type];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *date=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *time =[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                NSString *value=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                
                NSString *record=[NSString stringWithFormat:@"%@        %@             %@",date,time,value ];
                
                [arrayOfLog addObject:record];
                
            }
        } 
        
    }      
    
    return [arrayOfLog autorelease];
    
    
}*/

+(NSMutableArray *)AllLogs:(int)userid
{
    NSMutableArray * arrayOfLog=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM healthydata where userid= %d",userid];
    sqlite3_stmt * statement;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *date=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *value=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
//                NSString *time=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                NSString *type=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];

                NSString *record=[NSString stringWithFormat:@"%@     %@      %@",date,type,value ];
                
                [arrayOfLog addObject:record];
                
            }
        }
        
    }
    
    return [arrayOfLog autorelease];
}

+(NSMutableArray *)getData:(NSString *)type :(int)userid
{   
    
    NSMutableArray * arrayOfLog=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM healthydata where type='%@' and userid= %d",type,userid];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *date=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *value=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                
                NSString *record=[NSString stringWithFormat:@"  %@              %@",date,value ];
                
                [arrayOfLog addObject:record];
                
            }
        } 
        
    }      
    
    return [arrayOfLog autorelease];
    
    
}



+(NSMutableArray *)getBPData:(NSString *)type :(int)userid
{
    
    NSMutableArray * arrayOfLog=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM healthydata where type='%@' and userid= %d",type,userid];
    sqlite3_stmt * statement;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                //NSString *date=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *value=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                
                NSString *record=[NSString stringWithFormat:@" %@",value ];
                
                [arrayOfLog addObject:record];
                
            }
        }
        
    }
    
    return [arrayOfLog autorelease];
    
    
}


+(NSMutableArray *)getBayMedicineListForUser:(int)userid:(int)bayno
{
    
    //NSLog(@"Medicine list loded");
    
    NSMutableArray * arrayOfMedicines=[[[NSMutableArray alloc] init]autorelease];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"select medicinename,medqty,state,medicineid from takemedicine where bayno= %d and userid= %d ",bayno,userid];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    NSLog(@"%@",qsql);
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // create a new user
                classCompartmentData *aMedicine=[[classCompartmentData alloc]init];
                
                // set all detaisl of medicine
                
                NSString * medicineName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                NSString * medicineTotalPillQuantity=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString * medicineState=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString * medid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                aMedicine.bayMedName=medicineName;
                
                aMedicine.bayMedQty=[medicineTotalPillQuantity floatValue];
                
                aMedicine.state=[medicineState intValue];
                
                aMedicine.medicineID=[medid intValue];
                
                
                
                
                
                [arrayOfMedicines addObject:aMedicine];
                
                [aMedicine release];
            }
            
            
            
        }
        
    }
    
    return arrayOfMedicines ;
    
}


+(NSMutableArray *)getStatus:(NSString *)type :(int)userid
{   
    
    NSMutableArray * arrayOfStatus=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM medicinestatus where medicinestatus='%@' and userid= %d",type,userid];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *medicinename=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                [arrayOfStatus addObject:medicinename];
                
            }
        } 
        
    }      
    NSLog(@"getdetail");
    for (int i=0;i<arrayOfStatus.count; i++) {
        NSLog(@"%@",[arrayOfStatus objectAtIndex:i]);
    }
    return [arrayOfStatus autorelease];
    
    
}



+(NSMutableArray *)chkStatus:(int)medicineid :(int)userid :(NSString *)medicinetime
{   
    
    NSMutableArray * arrayOfStatus=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
  //  NSLog(@"medicineId: %d UserId:%d medicinetime:%@",medicineid,userid,medicinetime);
    NSString * qsql=[[NSString alloc]init];

      qsql=[NSString stringWithFormat:@"SELECT * FROM medicinestatus where medicineid='%d' and userid= '%d' and medicinetime='%@'",medicineid,userid,medicinetime];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *medicinename=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                [arrayOfStatus addObject:medicinename];
                
            }
        } 
        
    }      
    NSLog(@"getdetail");
    for (int i=0;i<arrayOfStatus.count; i++) {
        NSLog(@"status array %@",[arrayOfStatus objectAtIndex:i]);
    }
    return [arrayOfStatus autorelease];
    
    
}

+(NSString *)getString:(NSString *)queryString
{
    
    
    sqlite3 *db;
    NSString *result=[[[NSString alloc]init]autorelease];
    
    NSString * qsql=queryString;
    
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                
                
                result = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 0)];
                //NSLog(@"%.1f",result);
                
            }
            
            
            
        }
        
    }
    
    
    sqlite3_close(db);    
    
    
    return result;
    
    
}


+(NSMutableArray *)getMedicineData:(int)userid
{   
    
    NSMutableArray * arrayOfLog=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM medicinestatus where userid= %d",userid];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *name=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                float qty =[[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 7)]floatValue];               
                NSString *time=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 8)];
                NSString *status=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 5)];
                NSLog(@"Date Time : %@",time);

              NSString *record=[NSString stringWithFormat:@"%@   %@      %@",time,name,status ];
                [arrayOfLog addObject:record];
                NSLog(@"%f",qty);

            }
        }
        
    }      
    
    return [arrayOfLog autorelease];
    
    
}

+(NSMutableArray *)generateMedicineListForTime:(NSMutableArray *)medicineList:(classUser *)currentUser
{
 
    
    NSMutableArray * arrayOfMedicines=[[NSMutableArray alloc] init];
    
    
    sqlite3 *db;
    for (int i=0;i<medicineList.count;i++)
    {
        classMedicineIndex *indexM=[medicineList objectAtIndex:i];
        
    NSString * qsql=[NSString stringWithFormat:@"SELECT * FROM medicine where medicineid= %d",indexM.medicineId];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        
        
        //    int x=sqlite3_prepare_v2(db,[qsql cStringUsingEncoding:NSUTF8StringEncoding], -1, &statement, nil);
        
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                // create a new user
                classMedicine * aMedicine=[[classMedicine alloc] init];
                
                // set all detaisl of medicine
                NSString * medicineId=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString * medicineName=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                NSString * medicineFrequency=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString * medicineTotalPillQuantity=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                NSString * reorderLevel=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 1)];
                NSString * medicineComments=[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 2)];
                
                aMedicine.medicineSequenceId=[medicineId intValue];
                aMedicine.medicineName=medicineName;
                aMedicine.medicineDosesFrequency=[medicineFrequency intValue];
                aMedicine.totalPillQuantity=[medicineTotalPillQuantity floatValue];
                aMedicine.reorderLevel=[reorderLevel intValue];
                     //   NSLog(@"Comments length :%d",[medicineComments length] );
                
                if([medicineComments isEqualToString:@"(null)"] || medicineComments==nil||[medicineComments length]<=0)
                {
                    
                    medicineComments=@"No Comments";  
                    
                }
                
                aMedicine.medicineComments= medicineComments;
                
                // get medicne image from document folder                
                NSString * imgName = [NSString stringWithFormat:@"%@%@%@",aMedicine.medicineName,currentUser.firstName,currentUser.lastName];
                
                
                // get path of document directory to get medicne image
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
                UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];                
                aMedicine.medicineImage=medicineImage;                                
                
                // get audio file name, this audio file name need to be implemented, not used anywhere
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *path = [documentsDirectory stringByAppendingPathComponent:[aMedicine.medicineName lowercaseString]];
                
                
                
                // NSLog(@"%@",audioFilePath);
                if([fileManager fileExistsAtPath:path]==YES)
                {
                    
                    aMedicine.audioFileName=aMedicine.medicineName;
                }
                
                
                
                [arrayOfMedicines addObject:aMedicine];
                
                [aMedicine release];
            }
            
            
            
        }
        
    }
        
}
    sqlite3_close(db);
    
    for (int j=0; j<arrayOfMedicines.count; j++) {
        NSLog(@"hi");
    }
    
    return [arrayOfMedicines autorelease];   
    
    
    
}

+(int)getLanuageStatus:(int)objUser
{
    // classUser *objUser=[[classUser alloc]init];
    NSString *query=[NSString stringWithFormat:@"select audiostatus from user where userid=%d ",objUser];
    int language= [classDatabaseOperations get:query];
    return language;
    
}

+(NSString *)getNurseImg:(int)userid
{   
    int count=0;
    NSString *medicinename;   
    sqlite3 *db;
    
    NSString * qsql=[NSString stringWithFormat:@"SELECT careImg FROM careGive where userId= %d",userid];
    sqlite3_stmt * statement;    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];	
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"iStripsDataBase.SQLite"];	
	const char *dbpath = [databasePath UTF8String];
    
    
    // 1st get all medicines
    if(sqlite3_open(dbpath , &db) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(db,[qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                
                medicinename=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
                count++;
            }
        } 
        
    }
    if (count==0) {
        NSString *null=@"null";
        return null;
    }
    else{
        NSLog(@"%@",medicinename);
        return medicinename;
    }  
    
}






 
@end
