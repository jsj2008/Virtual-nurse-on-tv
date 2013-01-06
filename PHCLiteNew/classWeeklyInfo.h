//
//  classWeeklyInfo.h
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 19/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"

@interface classWeeklyInfo : UIViewController 
{
    
    UITableView *tableviewWeek;
    UIView *BackSideView;
    UIPickerView *PickerTab;
    NSString *label;
    NSArray *array_Weekname,*arrayHours;
    NSMutableArray *arrayMinute,*arrayName;
    UIPickerView *PickerWeek;
    classUser *aUser;
    
    
}
@property (nonatomic, retain) IBOutlet UITableView *tableviewWeek;
@property (nonatomic, retain) IBOutlet UIView *BackSideView;
@property (nonatomic, retain) IBOutlet UIPickerView *PickerTab;
@property(nonatomic,retain)NSArray *array_Weekname,*arrayHours;
@property(nonatomic,retain)NSMutableArray *aarayMinute,*arrayName;
@property (nonatomic, retain) IBOutlet UIPickerView *PickerWeek;
@property(nonatomic,retain)classUser *aUser;
@property(nonatomic,retain)NSString *label;
-(void)Save;
-(void)Cancel;
@end
