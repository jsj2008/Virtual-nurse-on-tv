//
//  classInform.h
//  PHCLite_New
//
//  Created by Avi Kulkarni on 06/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classDatabaseOperations.h"

@class classUser;

@interface classInform : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    classUser *aUser;
    IBOutlet UIButton *morningButton,*afternoonButton,*eveningButton,*nightButton;
    IBOutlet  UILabel *morningLabel,*afternoonLabel,*eveningLabel,*nightLabel;

    NSMutableArray *arrayFlags;   
    UITableView *tableView1;
    UISwitch *switchWeight;
    UISwitch *switchGlucose;
    UISwitch *switchBP;
    UISwitch *switchHeamo;
    UISwitch *switchHba1c;
   
    IBOutlet UISwitch *switchMed;
    NSMutableArray *arrayName;
    UIBarButtonItem *Btnsave;
    
    int timespan;
    
    NSString  *wtflag;
    NSString *bpflag;
    NSString *bgflag;
    NSString * hgflag;
    NSString * hga1cflag;
    NSString  *medflag;

    
    
    
}
@property (nonatomic, retain) IBOutlet UITableView *tableView1;
@property (nonatomic, retain) IBOutlet UISwitch *switchWeight;
@property (nonatomic, retain) IBOutlet UISwitch *switchGlucose;
@property (nonatomic, retain) IBOutlet UISwitch *switchBP;
@property (nonatomic, retain) IBOutlet UISwitch *switchHeamo;
@property (nonatomic, retain) IBOutlet UISwitch *switchHba1c;
   @property  int timespan;
@property(nonatomic,retain)IBOutlet UISwitch *switchMed;
@property(nonatomic,retain)NSMutableArray *arrayFlags;
 @property(nonatomic,retain)  classUser *aUser;
-(void)TouchSave;
-(IBAction)buttonTapMethod:(id)sender;

@end
