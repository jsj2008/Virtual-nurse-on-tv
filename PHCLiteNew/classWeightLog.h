//
//  classWeightLog.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/12/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
@interface classWeightLog: UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    
    classUser *aUser;
    classAudio *myAudioPlayer;
    IBOutlet UITableView *logTable;
    IBOutlet UILabel *date;
    IBOutlet UILabel *time;
    IBOutlet UILabel *value;
   NSString *strName;
    NSString *logType;
    NSMutableArray *arrayOfData;
    UIBarButtonItem *btnBarDelete;
  IBOutlet  UITableViewCell *headings;
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
@property(nonatomic,retain) NSString * logType;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarDelete;

@end
