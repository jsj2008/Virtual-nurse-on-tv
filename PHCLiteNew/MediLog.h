//
//  MediLog.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/3/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"

@interface MediLog : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    
    classUser *aUser;
    classAudio *myAudioPlayer;
    IBOutlet UITableView *logTable;
    IBOutlet UILabel *name;
    IBOutlet UILabel *time;
    IBOutlet UILabel *quantity;
    IBOutlet UILabel *status;
    NSString *strName;
    NSMutableArray *arrayOfData;
    
    IBOutlet  UITableViewCell *headings;
}

@property(nonatomic,retain)classUser *aUser;
@property(nonatomic,retain) classAudio *myAudioPlayer;
@property(nonatomic,retain)IBOutlet UITableView *logTable;
@property(nonatomic,retain) NSMutableArray *arrayOfData;
@property(nonatomic,retain)IBOutlet UITableViewCell *headings;
@property(nonatomic,retain)IBOutlet UILabel *quantity;
@property(nonatomic,retain)IBOutlet UILabel *name;
@property(nonatomic,retain)IBOutlet UILabel *time;
@property(nonatomic,retain)IBOutlet UILabel *status;
@property(nonatomic,retain) NSString * strName;
-(void)Back;


@end
