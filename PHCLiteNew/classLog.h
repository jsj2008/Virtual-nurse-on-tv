//
//  classLog.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/12/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
@interface classLog : UITableViewController <UITableViewDelegate>
{
    
    classUser *aUser;
    classAudio *myAudioPlayer;
     IBOutlet UITableView *logTable;
    
    NSArray *arrayOfLog;
    
}

@property(nonatomic,retain)classUser *aUser;
@property(nonatomic,retain) classAudio *myAudioPlayer;
@property(nonatomic,retain)IBOutlet UITableView *logTable;
@property(nonatomic,retain) NSArray *arrayOfLog;
@end
