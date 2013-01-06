//
//  classAllLogs.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 9/14/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
@interface classAllLogs : UIViewController
{
classUser *aUser;
classAudio *myAudioPlayer;
IBOutlet UIImageView *logsSelected;
IBOutlet UITableView *logTable;
IBOutlet UILabel *date;
IBOutlet UILabel *time;
IBOutlet UILabel *value;
IBOutlet UISegmentedControl *LogsSegment;
NSString *strName;
NSMutableArray *weightArray;
NSMutableArray *glucoseArray;
NSMutableArray *hemiglobinArray;
NSMutableArray *glycohemoglobinArray;
NSMutableArray *bpDiasArray,*pulseArray,*sysArray,*hgArray,*glycoArray,*glucoseDataArray;
    NSMutableArray *medArray,*medDataArray;
NSMutableArray *medicalArray;
    NSMutableArray *dataArray,*glucoseData,*hemoDataArray,*glycoDataArray,*sysDataArray,*diaDataArray,*pulseDataArray;
IBOutlet  UITableViewCell *headings;
    UIBarButtonItem *btnBarDelete;
    NSString *flag;
}
@property(nonatomic,retain)classUser *aUser;
@property(nonatomic,retain) classAudio *myAudioPlayer;
@property(nonatomic,retain)IBOutlet UITableView *logTable;
@property(nonatomic,retain) NSMutableArray *arrayOfData;
@property(nonatomic,retain)IBOutlet UITableViewCell *headings;
@property(nonatomic,retain)IBOutlet UILabel *date;
@property(nonatomic,retain)IBOutlet UILabel *time;
@property(nonatomic,retain)IBOutlet UILabel *value;
@property(nonatomic,retain) NSString * strName;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarDelete;
@property(nonatomic,retain)NSString *flag;
-(IBAction)buttonTap;
-(void)todayMethod;
-(void)AllMethod;

@end
