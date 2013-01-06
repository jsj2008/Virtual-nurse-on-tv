 //
//  commanFunctions.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/5/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "commanFunctions.h"
#import "classDatabaseOperations.h"
#import "classMedicineIndex.h"
#import  "classMedicine.h"

@implementation commanFunctions







+(int)timeSpanInInteger
{
    
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];   
    
    
    // current Time
    NSString * currentDate=[dateFormatter stringFromDate:[NSDate date]];
    
    // date formater for full datetime
    NSDateFormatter * dateTimeFormatter=[[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];   
    
    // morning,afternoon,evening,night start and end time wieth todays date
    
    NSDate * morningStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 0:00:01",currentDate]];
    NSDate * morningEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 11:59:59",currentDate]];
    
    NSDate * afternoonStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 12:00:00",currentDate]];
    NSDate * afternoonEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 16:59:59",currentDate]];
    
    NSDate * eveningStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 17:00:00",currentDate]];
    NSDate * eveningEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 19:59:59",currentDate]];
    
    
    NSDate * nightStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 20:00:00",currentDate]];
    NSDate * nightEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 23:00:00",currentDate]];
    
    [dateFormatter release];
    [dateTimeFormatter release];
    
    if([morningStartTime compare:[NSDate date]]==NSOrderedAscending  && [morningEndTime compare:[NSDate date]]==NSOrderedDescending )
    {
        
        return 1;
        
        
    }
    
    
    else if([afternoonStartTime compare:[NSDate date]]==NSOrderedAscending  && [afternoonEndTime compare:[NSDate date]]==NSOrderedDescending )
    {
        
        return 2;
        
        
    }
    
    
    
    else if([eveningStartTime compare:[NSDate date]]==NSOrderedAscending && [eveningEndTime compare:[NSDate date]]==NSOrderedDescending)
    {
        
        return 3; 
        
    }
    
    
    
    else if([nightStartTime compare:[NSDate date]]==NSOrderedAscending && [nightEndTime compare:[NSDate date]]==NSOrderedDescending)
    {
        
        
        return 4;
        
    }
    
    
    
    
    return 0;    
    
    
}


+(NSString *)timeSpanInString
{
    
    switch ([self timeSpanInInteger])
    {
        case 1: return @"Morning";
            
            break;
            
            
        case 2:return @"Afternoon";
            
            break;
            
            
        case 3:return @"Evening";
            
            break;
            
            
        case 4: return @"Night";
            
            break;
            
            
    }
    
    
    return @"- - - - ";
}

+(NSString *)convertIntTimeSpanToString:(int)timeSpan
{
    
    switch (timeSpan)
    {
        case 1: return @"Morning";
            
            break;
            
            
        case 2:return @"Afternoon";
            
            break;
            
            
        case 3:return @"Evening";
            
            break;
            
            
        case 4: return @"Night";
            
            break;
            
            
    }
    
    
    return @"- - - - ";
}

/*

+(NSMutableArray *)genrateMedicineListForTime:(int)timeSpan fromMedicineList:(NSMutableArray*)medicineList
{
  //  NSMutableArray *medArray=[NSMutableArray alloc];
    
    
    
    
    
    
    
    
}

*/
+(BOOL)checkIsValidName:(NSString *)value andErrorMessage:(NSString*)message;
{
    
    
    
    
    
    NSCharacterSet  * charset=[NSCharacterSet characterSetWithCharactersInString:@"1234567890@!#$%^&*()_-+=`~<>{}[]|;:,.'" ];
    
    // check whether value contains any numric or special charachters values
    NSRange rang=[ value rangeOfCharacterFromSet:charset];	
    
    
    if(rang.location==NSNotFound && [value length]!=0)
    {
        
        return YES;
        
        
    }
    
    
    // show alert and then retun no
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    
    return NO; 
    
}

+(BOOL)checkIsValidEmail:(NSString *)value andErrorMessage:(NSString*)message
{
    
    BOOL isValidEmail=YES; // default value is YES
    
    if([value length]>0)   // if not empty email then chek whether it is valid or not
    {
        NSString *email = [value lowercaseString]; // convert email address to lowercase string
        NSString *emailRegEx =
        @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        
        NSPredicate *regExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        // if return NO then email is invalid
        isValidEmail = [regExPredicate evaluateWithObject:email];
        
        
    }
    else 
    {
    
        isValidEmail=NO;
        
                
    }
    
    // show alert if emailis invalid
    if(isValidEmail==NO)
    {
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];

        
    }
    
    return isValidEmail;    
    
}

+(BOOL)checkIsValidPhoneNumber:(NSString *)value andErrorMessage:(NSString*)message
{
    
    
    //set default YES
    BOOL isValidPhoneNumber=YES;
    
    
    // if phone no's length is >than 0 then chek whether it is valid or not
    if([value length]>0)
	{
		
		// charachter set of nubers
		NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];		
        
        //charachters form out phone number
		NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:value];
		
        // if any charachter is not number the this will turnt NO
		isValidPhoneNumber = [alphaNums isSupersetOfSet:inStringSet];		
		
				
    } 
    else // if empty phone set to invalid
    {
        
        
        isValidPhoneNumber=NO;
        
        
    }

    
    // if ph is invalid show alert
    if(isValidPhoneNumber==NO)
    {
        
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];     
        
        
        
    }
    
    
    // finally return resutl
    
    return  isValidPhoneNumber;  

      
    
}


+(classMedicine *)createCopyOfMedicine:(classMedicine * )aMedicine
{
 
    
    classMedicine * objTempMedicine=[[classMedicine alloc] init];
    
    //copy sequenc id    
    objTempMedicine.medicineSequenceId=aMedicine.medicineSequenceId;
    
    // copy name
    objTempMedicine.medicineName=[aMedicine.medicineName copy];
    
    // copy frequency 
    objTempMedicine.medicineDosesFrequency=aMedicine.medicineDosesFrequency;
    
    //copy total Quantity
    objTempMedicine.totalPillQuantity=aMedicine.totalPillQuantity;
    
    //copy reorder level
    objTempMedicine.reorderLevel=aMedicine.reorderLevel;
    
    // medicine comments
    objTempMedicine.medicineComments=aMedicine.medicineComments;
    
    //copy image
    objTempMedicine.medicineImage=[aMedicine.medicineImage copy];
    
    
    // copy all 6 objects data, since medicine can have 6 times
    for(int i=0; i<=5;i++)
    {
        // get time object one bye one
        classMedicineTime * objTime=[objTempMedicine.medicineTimes objectAtIndex:i] ;
        
            //set dose number
            //does no. is already set whie creating objec in its initializer method
        
            // copy time one by one -time is in string e.g. 09:03:30 PM
            objTime.times=[[[aMedicine .medicineTimes objectAtIndex:i] times]copy];
            
            // copy pill quantity to take on above timings one by one
            objTime.pillQuantity=[[aMedicine.medicineTimes objectAtIndex:i] pillQuantity];
            
        
    }
    
    
    
    
    return [objTempMedicine autorelease];
    

}

+(id)checkIsValidName:(NSString *)name: (NSString *)andErrorMessage
{
    return self;
}


+(NSMutableArray *)getMedicineIndexForTimeSpan:(int)timeSpan forUser:(classUser*)currentUser
{
    
    NSMutableArray * arrayIndex=[[NSMutableArray alloc] init];
  //  NSMutableArray * allMedicines=[classDatabaseOperations getMedicineListForUser:currentUser];
    NSMutableArray * allMedicines=currentUser.medicineList;
    
    
        NSLog(@"\n\n user id is .... %d in medicine list \n",currentUser.userId);    
    NSLog(@"\n\n no of medicine %d",allMedicines.count);
    
    int i=0;
    while (i < allMedicines.count)
    {
        
        classMedicine *medicine=[allMedicines objectAtIndex:i];
    NSLog(@"\n medicine for user is  %@ ",medicine.medicineName);
        i++;
        
    }    
       for(classMedicine * objMedicine in allMedicines)
       {
           
           
           for(classMedicineTime * objTime in objMedicine.medicineTimes)
           {
               //NSLog(@"medicine times count: %d",[objMedicine.medicineTimes count]);
               
              if(objTime.times !=nil)
              {
                  
                  if([commanFunctions getTimeSpanOfTime:objTime.times]==timeSpan || timeSpan==5)// 2nd condition is used in case user need to see all medicines
                  {
                      NSLog(@"Medicine Time %@",objTime.times);

                  
                  classMedicineIndex * objIndex=[[[classMedicineIndex alloc] init] autorelease];
                  
                  // in each object of index save current medicine id and its dose number
                  objIndex.medicineId=objMedicine.medicineSequenceId;
                  objIndex.doseNumber=objTime.doseNumber;
                  
                  // add this indexObject in arrayIndex
                  [arrayIndex addObject:objIndex];
                      
                  // NSLog(@"medId:%d doseNo:%d",objIndex.medicineId,objIndex.doseNumber);
                      
                      
                  }
                  
              }
               
               
           }
           
           
           
       }
    
    
    
    
    return [arrayIndex autorelease];
}


+(int)getTimeSpanOfTime:(NSString *)time;
{
NSLog(@"time=%@",time);
 
   // formater to get date only   
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];   
    
    // formater to get date time in 12 hour formate
    NSDateFormatter * dateFormatter12=[[NSDateFormatter alloc] init];
    [dateFormatter12 setDateFormat:@"yyyy:MM:dd h:mm:SS a"];   
    
    // formattter to get date time  in 24 hour formate 
    NSDateFormatter * dateTimeFormatter24=[[NSDateFormatter alloc] init];
    [dateTimeFormatter24 setDateFormat:@"yyyy:MM:dd HH:mm:ss"];   
    
    // get current Date in string
    NSString * strCurrentDate=[dateFormatter stringFromDate:[NSDate date]];
  
    // current date in string with given time   
    NSString *strCurrentDateWithGivenTime=[NSString stringWithFormat:@"%@ %@",strCurrentDate,time];   
    
   // convert above string in actual date time- this time will be in 12 hour format
    NSDate * currentDate12=[dateFormatter12 dateFromString:strCurrentDateWithGivenTime];
    
    // convert this 12 hour foramate date time in string-
    NSString *str=[dateTimeFormatter24 stringFromDate:currentDate12];
    
    
    // finally aging convet this string DateTime to actuall 24 hour date time
    NSDate * currentDate24=[dateTimeFormatter24 dateFromString:str];
    
    
    
    // morning,afternoon,evening,night start and end time wieth todays date
    
    NSDate * morningStartTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 0:00:01",strCurrentDate]];
    NSDate * morningEndTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 11:59:59",strCurrentDate]];
    
    NSDate * afternoonStartTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 12:00:00",strCurrentDate]];
    NSDate * afternoonEndTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 16:59:59",strCurrentDate]];
    
    NSDate * eveningStartTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 17:00:00",strCurrentDate]];
    NSDate * eveningEndTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 19:59:59",strCurrentDate]];
    
    
    NSDate * nightStartTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 20:00:00",strCurrentDate]];
    NSDate * nightEndTime=[dateTimeFormatter24 dateFromString:[NSString stringWithFormat:@"%@ 23:00:00",strCurrentDate]];
    
    [dateFormatter release];
    [dateFormatter12 release];
    [dateTimeFormatter24 release];
    
    if(([morningStartTime compare:currentDate24]==NSOrderedAscending || [morningStartTime compare:currentDate24]==NSOrderedSame)  && ([morningEndTime compare:currentDate24]==NSOrderedDescending || [morningStartTime compare:currentDate24]==NSOrderedSame) )
    {
        
        return 1;
        
        
    }
    
    
    else if(([afternoonStartTime compare:currentDate24]==NSOrderedAscending ||[afternoonStartTime compare:currentDate24]==NSOrderedAscending ) && ([afternoonEndTime compare:currentDate24]==NSOrderedDescending||[afternoonEndTime compare:currentDate24]==NSOrderedDescending) )
    {
        
        return 2;
        
        
    }
    
        
    else if(([eveningStartTime compare:currentDate24]==NSOrderedAscending ||  [eveningStartTime compare:currentDate24]==NSOrderedSame) && ([eveningEndTime compare:currentDate24]==NSOrderedDescending ||  [eveningStartTime compare:currentDate24]==NSOrderedSame))
    {
        
        return 3; 
        
    }
    
    
    
    else if(([nightStartTime compare:currentDate24]==NSOrderedAscending ||[nightStartTime compare:currentDate24]==NSOrderedAscending) && ([nightEndTime compare:currentDate24]==NSOrderedDescending|| [nightStartTime compare:currentDate24]==NSOrderedAscending))
    {
        
        
        return 4;
        
    }
    
    
    
  //  NSLog(@"%@",eveningStartTime);
  //  NSLog(@"%@",eveningEndTime);
    
   //NSLog(@"%d",[eveningStartTime compare:currentDate24]);
   // NSLog(@"%d",[eveningEndTime compare:currentDate24]);
    

    
    
    return 0;    
    

    
}
    
+(NSMutableArray *)getLogsForMode:(int)mode forMember:(NSString *)memberId;
{
    
    
    if(mode==1)//today
    {
        
        
    }
    else if(mode==2)// last 7 days
    {
        
        
    }
    else if(mode==3)// last 14 days
    {
        
        
    }
    else if(mode==4)// 30 days
    {
        
        
    }
    else if(mode==5)// 100 days
    {
        
        
    }

    return nil;
    
}



+(NSString *)genrateMemberId:(NSString *) memberId
{
	NSAutoreleasePool * pool=[[NSAutoreleasePool alloc]init];
    
    
	NSMutableString *strNewMemberId=[[NSMutableString alloc]init];
	NSString * subStringOfGivenMemberId=[memberId substringFromIndex:1];
	
	
    for(int i=0;i<12-[subStringOfGivenMemberId length];i++)
    {
        
        if(i==0)// append A
        {
            [strNewMemberId appendString: [[NSString stringWithFormat:@"%c",[memberId characterAtIndex:0]] uppercaseString]];
        }
        else
        {
            [strNewMemberId appendString: @"0"];
        }
    }
    
    [strNewMemberId appendString:subStringOfGivenMemberId];
	[pool drain];
	NSString *str=[strNewMemberId substringFromIndex:0];
	[strNewMemberId release];
	
	//
	
	return str;	
	
}


+(NSString*)genrateMemberIdSmall:(NSString *) memberId
{
    
    
    
    
    
    
    
    
    
 
    return nil;
}


+(NSMutableArray *) getIndexOfmsuresForUser:(classUser *)currentUser :(NSMutableArray *)flags  
{
    NSMutableArray *arrayOfIndex=[[[NSMutableArray alloc]init ]autorelease];
    
    for( NSString *flag in flags )
    {
        if([flag isEqualToString:@"YES"])
            [arrayOfIndex addObject:flag];
        
    }
    
    return arrayOfIndex;
}






@end
