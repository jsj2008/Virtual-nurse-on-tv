//
//  classLocalNotification.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.


#import "classLocalNotification.h"
#import "commanFunctions.h"
#import "classUser.h"
#import "classDatabaseOperations.h"

#define Morning 1
#define Afternoon 2
#define Evening 3
#define Night 4

@implementation classLocalNotification






+(void)setLocalNotificationForUser:(classUser*)objUser
{
    
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

   // NSLog(@"userid:%d and timeSpan:%d",objUser.userId,Morning);
    
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * notificationStatus=[userDefaults objectForKey:[NSString stringWithFormat:@"notificationStatus%d",objUser.userId]];  
    
    
    
    
    NSLog(@" \n\n\nuser in notification   %d\n\n\n    ", objUser.userId);

    if([notificationStatus isEqualToString:@"on"] || notificationStatus ==nil)
    {
    
   // NSLog(@"setting local notification");

    
    // formatter to get date only
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * strTodaysDate=[formatter stringFromDate:[NSDate date]];
    
    //formater to get datetime
    NSDateFormatter * formatter1=[[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd h:mm:ss a"];
    
    
    //--------------------------------------------------------------------------------------------------------------------   
    
    // get total numbers of morning medicine
    int TotalMorningMedicines=[[commanFunctions getMedicineIndexForTimeSpan:Morning forUser:objUser] count];
        
        
        NSMutableArray *arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:objUser.userId :Morning ]];    
       
       NSMutableArray *arrayOfservices= [commanFunctions getIndexOfmsuresForUser:objUser :arrayFlags];
            [arrayFlags release];
        
        
        int services=arrayOfservices.count;
        [arrayOfservices release];
   // NSLog(@"Total Morning Medicine:%d" ,TotalMorningMedicines);
    // if morning medicines are zero there is no need to set notification
    
        
    if(TotalMorningMedicines>0 || services > 0)
    {
        
        if([classLocalNotification chekNotificationAlreadySetForTimeSpan:Morning forUser:objUser]==NO)
        {
            
            // get "time" for morning Notification
            NSString * morningNotificationTime=[classLocalNotification notificaitonTimeForTimeSapn:Morning forUser:objUser];
            
            
            // todays "date and time" for morning Notification
            NSString * morningNotificationDateTime=[NSString stringWithFormat:@"%@ %@",strTodaysDate,morningNotificationTime];;
            NSLog(@"%@             %@ ",strTodaysDate,morningNotificationTime);        
            // create a NSDate object with above dateAndTime For morning notication        
            NSDate * mDateTime=[formatter1 dateFromString:morningNotificationDateTime];
            
            // create and set Local notification for morning time        
            UILocalNotification *objLocalNotification = [[UILocalNotification alloc] init];
            
            
          //  NSLog(@"%@",objLocalNotification);
            // if iOS dose not support local notification return
            if (objLocalNotification == nil)
                return;
            
            // for morning
            objLocalNotification.fireDate = mDateTime;    
            objLocalNotification.timeZone = [NSTimeZone defaultTimeZone];    
            objLocalNotification.alertBody = [NSString stringWithFormat:@"%@ %@ \nTime to take Morning Medicines",objUser.firstName,objUser.lastName];    
            objLocalNotification.alertAction = NSLocalizedString(@"Take Medicine", nil);    
            objLocalNotification.soundName =@"Hello.aiff";
            objLocalNotification.applicationIconBadgeNumber = 1;    
            
            [objLocalNotification setRepeatInterval:NSDayCalendarUnit]; 
            
            // create a NSDIctionary object and add usrid and timeSpan so that late we can identifiy this notification
            NSMutableDictionary * currentUserInfo=[[NSMutableDictionary alloc] init];
            
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d", objUser.userId] forKey:@"userId"];
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d",Morning] forKey:@"timeSpan"];
            
           // NSLog(@"userid:%d and timeSpan:%d",objUser.userId,1);

            objLocalNotification.userInfo=currentUserInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:objLocalNotification];
            [objLocalNotification release];

          //  NSLog(@"mornng=%@ StringDatetime %@",mDateTime,morningNotificationDateTime);
          //  NSLog(@"%@",objLocalNotification);

        }
        else
        {
           // 
           // NSLog(@"Morning Notification is already set");
            
        }
        
    }
    
    //--------------------------------------------------------------------------------------------------------------------   
    
    
    // get total numbers of afternoon medicine
    int TotalAfternoonMedicines=[[commanFunctions getMedicineIndexForTimeSpan:Afternoon forUser:objUser] count];
    
   // NSLog(@"Total Afternoon Medicine:%d" ,TotalAfternoonMedicines);
    // if afternoon medicines are zero there is no need to set notification
        
        NSLog(@"\n\n TotalAfternoon  medicine %d\n\n ",TotalAfternoonMedicines);
        
     arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:objUser.userId :Afternoon ]];    
        
       arrayOfservices= [commanFunctions getIndexOfmsuresForUser:objUser :arrayFlags];
        [arrayFlags release];
        
        
      services=arrayOfservices.count;
        [arrayOfservices release];
        
        
    if(TotalAfternoonMedicines>0  || services >0)
    {
        
        if([classLocalNotification chekNotificationAlreadySetForTimeSpan:Afternoon forUser:objUser]==NO)
        {
            
            // get "time" for afternoon Notification
            NSString * afternoonNotificationTime=[classLocalNotification notificaitonTimeForTimeSapn:Afternoon forUser:objUser];
            
            
            // todays "date and time" for afternoon Notification
            NSString * afternoonNotificationDateTime=[NSString stringWithFormat:@"%@ %@",strTodaysDate,afternoonNotificationTime];;
            
            // create a NSDate object with above dateAndTime For morning notication        
            NSDate * aDateTime=[formatter1 dateFromString:afternoonNotificationDateTime];
            
            // create and set Local notification for morning time        
            UILocalNotification *objLocalNotification = [[UILocalNotification alloc] init];
            
            
        //    NSLog(@"%@",objLocalNotification);
            // if iOS dose not support local notification return
            if (objLocalNotification == nil)
                return;
            
            // for morning
            objLocalNotification.fireDate = aDateTime;    
            objLocalNotification.timeZone = [NSTimeZone defaultTimeZone];    
            objLocalNotification.alertBody = [NSString stringWithFormat:@"%@ %@ \nTime to take afternoon Medicines",objUser.firstName,objUser.lastName];    
            objLocalNotification.alertAction = NSLocalizedString(@"Take Medicine", nil);    
            objLocalNotification.soundName = UILocalNotificationDefaultSoundName;    
            objLocalNotification.applicationIconBadgeNumber = 1;    
            [objLocalNotification setRepeatInterval:NSDayCalendarUnit]; 
            
            // create a NSDIctionary object and add usrid and timeSpan so that late we can identifiy this notification
            NSMutableDictionary * currentUserInfo=[[NSMutableDictionary alloc] init];
            
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d", objUser.userId] forKey:@"userId"];
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d",Afternoon] forKey:@"timeSpan"];
            
          //  NSLog(@"userid:%d and timeSpan:%d",objUser.userId,2);
            
            objLocalNotification.userInfo=currentUserInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:objLocalNotification];
            [objLocalNotification release];

          //  NSLog(@"afternoon=%@ StringDatetime %@",aDateTime,afternoonNotificationDateTime);
          //  NSLog(@"%@",objLocalNotification);
            
        }
        else
        {
            
          //  NSLog(@"afternoon Notification is already set");
            
        }
        
    }
    
    //--------------------------------------------------------------------------------------------------------------------   
    
    // get total numbers of evening medicine
    int TotalEveningMedicines=[[commanFunctions getMedicineIndexForTimeSpan:Evening forUser:objUser] count];
    
        
        
        
        arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:objUser.userId :Evening ]];    
        
        arrayOfservices= [commanFunctions getIndexOfmsuresForUser:objUser :arrayFlags];
        [arrayFlags release];
        
        
        services=arrayOfservices.count;
        [arrayOfservices release];
        
        
        
//  NSLog(@"Total evening Medicine:%d" ,TotalEveningMedicines);
    // if evening medicines are zero there is no need to set notification
    if(TotalEveningMedicines>0 || services > 0)
    {
        
        if([classLocalNotification chekNotificationAlreadySetForTimeSpan:Evening forUser:objUser]==NO)
        {
            
            // get "time" for evening Notification
            NSString * eveningNotificationTime=[classLocalNotification notificaitonTimeForTimeSapn:Evening forUser:objUser];
            
            
            // todays "date and time" for morning Notification
            NSString * eveningNotificationDateTime=[NSString stringWithFormat:@"%@ %@",strTodaysDate,eveningNotificationTime];;
            
            // create a NSDate object with above dateAndTime For evening notication        
            NSDate * eDateTime=[formatter1 dateFromString:eveningNotificationDateTime];
            
            // create and set Local notification for evening time        
            UILocalNotification *objLocalNotification = [[UILocalNotification alloc] init];
            
            
           // NSLog(@"%@",objLocalNotification);
            // if iOS dose not support local notification return
            if (objLocalNotification == nil)
                return;
            
            // for evening
            objLocalNotification.fireDate = eDateTime;    
            objLocalNotification.timeZone = [NSTimeZone defaultTimeZone];    
            objLocalNotification.alertBody = [NSString stringWithFormat:@"%@ %@ \nTime to take Evening Medicines",objUser.firstName,objUser.lastName];    
            objLocalNotification.alertAction = NSLocalizedString(@"Take Medicine", nil);    
            objLocalNotification.soundName = UILocalNotificationDefaultSoundName;    
            objLocalNotification.applicationIconBadgeNumber = 1;    
            [objLocalNotification setRepeatInterval:NSDayCalendarUnit]; 
            
            // create a NSDIctionary object and add usrid and timeSpan so that late we can identifiy this notification
            NSMutableDictionary * currentUserInfo=[[NSMutableDictionary alloc] init];
          //  [currentUserInfo ]
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d", objUser.userId] forKey:@"userId"];
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d",Evening] forKey:@"timeSpan"];
           // [currentUserInfo ]
           // NSLog(@"userid:%d and timeSpan:%d",objUser.userId,3);
            
            objLocalNotification.userInfo=currentUserInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:objLocalNotification];
            [objLocalNotification release];

          //  NSLog(@"evening=%@ StringDatetime %@",eDateTime,eveningNotificationDateTime);
          //  NSLog(@"%@",objLocalNotification);
            
        }
        else
        {
          
           // NSLog(@"evening Notification is already set");
            
        }
    }
    
    //--------------------------------------------------------------------------------------------------------------------   
    

    // get total numbers of night medicine
    int TotalNightMedicines=[[commanFunctions getMedicineIndexForTimeSpan:Night forUser:objUser] count];
   // NSLog(@"\n %d       ")
  //  NSLog(@"Total night Medicine:%d" ,TotalNightMedicines);
    // if night medicines are zero there is no need to set notification
        
        
        
        arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:objUser.userId :Night ]];    
        
        arrayOfservices= [commanFunctions getIndexOfmsuresForUser:objUser :arrayFlags];
        [arrayFlags release];
        
        
        services=arrayOfservices.count;
        [arrayOfservices release];
        
        
        
    if(TotalNightMedicines>0  || services  > 0)
    {
        
        if([classLocalNotification chekNotificationAlreadySetForTimeSpan:Night forUser:objUser]==NO)
        {
            
            // get "time" for night Notification
            NSString * nightNotificationTime=[classLocalNotification notificaitonTimeForTimeSapn:Night forUser:objUser];
            
            
            // todays "date and time" for night Notification
            NSString * nightNotificationDateTime=[NSString stringWithFormat:@"%@ %@",strTodaysDate,nightNotificationTime];;
            
            // create a NSDate object with above dateAndTime For night notication        
            NSDate * nDateTime=[formatter1 dateFromString:nightNotificationDateTime];
            
            // create and set Local notification for night time        
            UILocalNotification *objLocalNotification = [[UILocalNotification alloc] init];
            
            
           // NSLog(@"%@",objLocalNotification);
            // if iOS dose not support local notification return
            if (objLocalNotification == nil)
                return;
            
            // for evening
            objLocalNotification.fireDate = nDateTime;    
            objLocalNotification.timeZone = [NSTimeZone defaultTimeZone];    
            objLocalNotification.alertBody = [NSString stringWithFormat:@"%@ %@ \nTime to take night Medicines",objUser.firstName,objUser.lastName];    
            objLocalNotification.alertAction = NSLocalizedString(@"Take Medicine", nil);    
            objLocalNotification.soundName = UILocalNotificationDefaultSoundName;    
            objLocalNotification.applicationIconBadgeNumber = 1;    
            [objLocalNotification setRepeatInterval:NSDayCalendarUnit]; 
            
            // create a NSDIctionary object and add usrid and timeSpan so that late we can identifiy this notification
            NSMutableDictionary * currentUserInfo=[[NSMutableDictionary alloc] init];
            
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d", objUser.userId] forKey:@"userId"];
            [currentUserInfo setObject:[NSString stringWithFormat:@"%d",Night] forKey:@"timeSpan"];
            
            //NSLog(@"userid:%d and timeSpan:%d",objUser.userId,4);
            
            objLocalNotification.userInfo=currentUserInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:objLocalNotification];
            
            [objLocalNotification release];
            
          //  NSLog(@"night=%@ StringDatetime %@",nDateTime,nightNotificationDateTime);
           // NSLog(@"%@",objLocalNotification);
          //  
        }
        else
        {
            
            //NSLog(@"night Notification is already set");
            
        }
        
    }

    
     [formatter release];
     [formatter1 release];
    }
}


+(NSString *)notificaitonTimeForTimeSapn:(int)timeSpan forUser:(classUser *)objUser
{
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    
    switch (timeSpan)
    {
        case 1:
            
        {
            //get time for morningNotificaiton, here we append userId to identify current user's morning notification time
            NSString * morningNotificationTime=[userDefaults objectForKey:[NSString stringWithFormat:@"morningNotificationTime%d",objUser.userId]];
            
            // if this is nil then set default time
            if(morningNotificationTime==nil)
            {
                // set default time
                [userDefaults setObject:@"09:30:00 AM" forKey:[NSString stringWithFormat:@"morningNotificationTime%d",objUser.userId]];
                
                // return default time
                return  @"09:30:00 AM";
                
            }
            else
            {
                return morningNotificationTime;
            }

        }     
            break;
            
        case 2:
            
        {
            //get time for afternoonNotificaiton, here we append userId to identify current user's afternoon notification time
            NSString * afternoonNotificationTime=[userDefaults objectForKey:[NSString stringWithFormat:@"afternoonNotificationTime%d",objUser.userId]];
            
            // if this is nil then set default time
            if(afternoonNotificationTime==nil)
            {
                // set default time
                [userDefaults setObject:@"12:30:00 PM" forKey:[NSString stringWithFormat:@"afternoonNotificationTime%d",objUser.userId]];
                
                // return default time
                return  @"12:30:00 PM";
                
            }
            else
            {
                return afternoonNotificationTime;
            }
            
        }     
            break;
            
        case 3:
            
        {
            //get time for afternoonNotification, here we append userId to identify current user's afternoon notification time
            NSString * eveningNotificationTime=[userDefaults objectForKey:[NSString stringWithFormat:@"eveningNotificationTime%d",objUser.userId]];
            
            // if this is nil then set default time
            if(eveningNotificationTime==nil)
            {
                // set default time
                [userDefaults setObject:@"05:30:00 PM" forKey:[NSString stringWithFormat:@"eveningNotificationTime%d",objUser.userId]];
                
                // return default time
                return  @"05:30:00 PM";
                
            }
            else
            {
                return eveningNotificationTime;
            }
            
        }     
            break;
            
        case 4:
            
        {
            //get time for nightNotificaiton, here we append userId to identify current user's night notification time
            NSString * nightNotificationTime=[userDefaults objectForKey:[NSString stringWithFormat:@"nightNotificationTime%d",objUser.userId]];
            
            // if this is nil then set default time
            if(nightNotificationTime==nil)
            {
                // set default time
                [userDefaults setObject:@"09:30:00 PM" forKey:[NSString stringWithFormat:@"nightNotificationTime%d",objUser.userId]];
                
                // return default time
                return  @"09:30:00 PM";
                
            }
            else
            {
                return nightNotificationTime;
            }
            
        }     
            break;
            
       
    }
    
    return nil;
}



+(void)resetNotificaitonTimeForTimeSapn:(int)timeSpan newTime:(NSString *)newTime forUser:(classUser *)objUser
{
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    switch (timeSpan)
    {
        case 1:[userDefaults setObject:newTime forKey:[NSString stringWithFormat:@"morningNotificationTime%d",objUser.userId]];

            break; 
            
        case 2:[userDefaults setObject:newTime forKey:[NSString stringWithFormat:@"afternoonNotificationTime%d",objUser.userId]];
            
            break; 
            
        case 3:[userDefaults setObject:newTime forKey:[NSString stringWithFormat:@"eveningNotificationTime%d",objUser.userId]];
            
            break; 
            
        case 4:[userDefaults setObject:newTime forKey:[NSString stringWithFormat:@"nightNotificationTime%d",objUser.userId]];
            
            break; 
       
    }


}



+(BOOL)chekNotificationAlreadySetForTimeSpan:(int)timeSpan forUser:(classUser *)objUser
{
    
    
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
  //  NSLog(@"%d",[eventArray count]);
    
    int timeSpan1=-1;   
    int userId=-1;
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *currentUserInfo = oneEvent.userInfo;
        
        userId=[[currentUserInfo valueForKey:@"userId"] intValue];   
        
        timeSpan1=[[currentUserInfo valueForKey:@"timeSpan"] intValue];
        
        
        
        if (userId ==objUser.userId && timeSpan1==timeSpan)
        {
            
            break;            
        }
    }
    
    
    if (userId ==objUser.userId && timeSpan1==timeSpan)
    {
        
        return YES;
        
    }
    
    return NO;
    
    
}




+(void)cancelNotificationForTimeSpan:(int)timeSpan forUser:(classUser *)objUser
{
   // NSLog(@"canceling local notification");

    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
  //  NSLog(@"%d",[eventArray count]);
    
    int userId;
    int timeSpan1;
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *currentUserInfo = oneEvent.userInfo;
        
         userId =[[currentUserInfo valueForKey:@"userId"] intValue];
         timeSpan1=[[currentUserInfo valueForKey:@"timeSpan"] intValue];
        
     //   NSLog(@"userid:%d and timeSpan:%d",userId,timeSpan1);
        
        if (userId ==objUser.userId && timeSpan1==timeSpan)
        {
            
            [app cancelLocalNotification:oneEvent];
            break;
            
        }
    }
    
    
}




@end
