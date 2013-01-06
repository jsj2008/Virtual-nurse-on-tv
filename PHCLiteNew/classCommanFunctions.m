//
//  classCommanFunctions.m
//  i_Strips2
//
//  Created by Avi Kulkarni on 6/8/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classCommanFunctions.h"


@implementation classCommanFunctions

+(int)getTimeSpanOfTime:(NSString *)time;
{
    
    //NSLog(@"time=%@",time);
    
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


+(NSString *)genrateFormatedMemberId:(NSString*)memberId
{

    NSMutableArray * array=[[NSMutableArray alloc]initWithObjects:@"A",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    
    int arrayLength=[array count];
    arrayLength--;
    
    int memberIdLength=[memberId length];
    memberIdLength--;
    
    for(int i=memberIdLength; i>=0; i--)
    {        
        NSString * aChar=[NSString stringWithFormat:@"%c",[memberId characterAtIndex:i]];
        
        if(![aChar isEqualToString:@"A"] && ![aChar isEqualToString:@"a"] )
        {
            [array replaceObjectAtIndex:arrayLength withObject:aChar];
        }
        arrayLength--;
    }
    
    [array autorelease];
    
    NSLog(@"%@",[array componentsJoinedByString:@""]);
    return [array componentsJoinedByString:@""];


}
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
    NSDate * nightEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 23:59:59",currentDate]];
    
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

+(NSArray*)marathiAudioMethod:(int )component1:(int )component2:(int )component3
{
    NSLog(@"comp1=%d comp2=%d comp3=%d ",component1,component2,component3);
    NSMutableArray * array=[[[NSMutableArray alloc] init]autorelease];
    NSMutableArray *unitArray=[[[NSMutableArray alloc]initWithObjects:@"1.0",@"1.1",@"1.2",@"1.3",@"1.4",@"1.5",@"1.6",@"1.7",@"1.8",@"1.9", nil]autorelease];
    NSMutableArray *twentyArray=[[[NSMutableArray alloc]initWithObjects:@"1.10",@"1.11",@"1.12",@"1.13",@"1.14",@"1.15",@"1.16",@"1.17",@"1.18",@"1.19", nil]autorelease];
    NSMutableArray *thirtyArray=[[[NSMutableArray alloc]initWithObjects:@"1.20",@"1.21",@"1.22",@"1.23",@"1.24",@"1.25",@"1.26",@"1.27",@"1.28",@"1.29", nil]autorelease];
    NSMutableArray *fourtyArray=[[[NSMutableArray alloc]initWithObjects:@"1.30",@"1.31",@"1.32",@"1.33",@"1.34",@"1.35",@"1.36",@"1.37",@"1.38",@"1.39", nil]autorelease];
    NSMutableArray *fiftyArray=[[[NSMutableArray alloc]initWithObjects:@"1.40",@"1.41",@"1.42",@"1.43",@"1.44",@"1.45",@"1.46",@"1.47",@"1.48",@"1.49", nil]autorelease];
    NSMutableArray *sixtyArray=[[[NSMutableArray alloc]initWithObjects:@"1.50",@"1.51",@"1.52",@"1.53",@"1.54",@"1.55",@"1.56",@"1.57",@"1.58",@"1.59", nil]autorelease];
    NSMutableArray *seventyArray=[[[NSMutableArray alloc]initWithObjects:@"1.60",@"1.61",@"1.62",@"1.63",@"1.64",@"1.65",@"1.66",@"1.67",@"1.68",@"1.69", nil]autorelease];
    NSMutableArray *eightyArray=[[[NSMutableArray alloc]initWithObjects:@"1.70",@"1.71",@"1.72",@"1.73",@"1.74",@"1.75",@"1.76",@"1.77",@"1.78",@"1.79", nil]autorelease];
     NSMutableArray *nintyArray=[[[NSMutableArray alloc]initWithObjects:@"1.80",@"1.81",@"1.82",@"1.83",@"1.84",@"1.85",@"1.86",@"1.87",@"1.88",@"1.89", nil]autorelease];
    NSMutableArray *hundredArray=[[[NSMutableArray alloc]initWithObjects:@"1.90",@"1.91",@"1.92",@"1.93",@"1.94",@"1.95",@"1.96",@"1.97",@"1.98",@"1.99", nil]autorelease];
     NSMutableArray *tensArray=[[[NSMutableArray alloc]initWithObjects:@"1.0",@"1.10",@"1.20",@"1.30",@"1.40",@"1.50",@"1.60",@"1.70",@"1.80",@"1.90",@"1.100", nil]autorelease];
     NSMutableArray *hundredsArray=[[[NSMutableArray alloc]initWithObjects:@"1.100",@"1.101",@"1.102",@"1.103",@"1.104",@"1.105",@"1.106",@"1.107",@"1.108",@"1.109",@"1.110", nil]autorelease];
    if (component1>0) {
        if (component1==1 && component2==0 && component3==0) {
            [array addObject:@"1.100"];
        }
        [array addObject:[hundredsArray objectAtIndex:component1]];
        
      }
    if (component2==0 && component3>0 ) {
        [array addObject:[unitArray objectAtIndex:component3]];
    }
    if (component2==1 && component3>0 ) {
        [array addObject:[twentyArray objectAtIndex:component3]];
    }
    if (component2==2 && component3>0 ) {
        [array addObject:[thirtyArray objectAtIndex:component3]];
    }
    if (component2==3 && component3>0 ) {
        [array addObject:[fourtyArray objectAtIndex:component3]];
    }
    if (component2==4 && component3>0 ) {
        [array addObject:[fiftyArray objectAtIndex:component3]];
    }
    if (component2==5&& component3>0 ) {
        [array addObject:[sixtyArray objectAtIndex:component3]];
    }
    if (component2==6 && component3>0 ) {
        [array addObject:[seventyArray objectAtIndex:component3]];
    }
    if (component2==7 && component3>0 ) {
        [array addObject:[eightyArray objectAtIndex:component3]];
    }
    if (component2==8 && component3>0 ) {
        [array addObject:[nintyArray objectAtIndex:component3]];
    }
    if (component2==9 && component3>0 ) {
        [array addObject:[hundredArray objectAtIndex:component3]];
    }
    if (component2>0 && component3==0 ) {
        [array addObject:[tensArray objectAtIndex:component2]];
    }
       return array;
}



@end
