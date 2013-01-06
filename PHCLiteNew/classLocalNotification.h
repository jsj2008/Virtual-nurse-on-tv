//
//  classLocalNotification.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class classUser;
@interface classLocalNotification : NSObject<UIApplicationDelegate>
{
   
    
    
    
    
    
}


+(void)setLocalNotificationForUser:(classUser *)objUser;
+(NSString *)notificaitonTimeForTimeSapn:(int)timeSpan forUser:(classUser *)objUser;
+(BOOL)chekNotificationAlreadySetForTimeSpan:(int)timeSpan forUser:(classUser *)objUser;
+(void)cancelNotificationForTimeSpan:(int)timeSpan forUser:(classUser *)objUser;

@end
