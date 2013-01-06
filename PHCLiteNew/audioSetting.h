//
//  audioSetting.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/12/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classAudio.h"
#import "classSetting3.h"
#import "classUser.h"
@interface audioSetting : UITableViewController

{
     IBOutlet UITableView *audioTable;
      IBOutlet UISwitch *switchAudio;
    classUser *aUser;
}
@property(nonatomic,retain)IBOutlet UITableView *audioTable;
@property(nonatomic ,retain) IBOutlet UISwitch *switchAudio;
-(IBAction)audioStatusChanged:(id)sender;
@property(nonatomic,retain)IBOutlet classUser *aUser;
-(void)Save;
@end
