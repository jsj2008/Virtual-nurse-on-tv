//
//  classInform.m
//  PHCLite_New
//
//  Created by Avi Kulkarni on 06/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classInform.h"
#import "classDiffTime.h"
#import "classDatabaseOperations.h"
#import "classUser.h"
#import "classWeeklyInfo.h"
#import "classNotification.h"
#import "classLocalNotificationSettings.h"
@implementation classInform
@synthesize tableView1;
@synthesize switchWeight;
@synthesize switchGlucose;
@synthesize switchBP;
@synthesize switchHeamo;
@synthesize switchHba1c;
@synthesize switchMed;
@synthesize arrayFlags;
@synthesize aUser;
@synthesize timespan;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        arrayName=[[NSMutableArray alloc]initWithObjects:@"Weight",@"Glucose",@"BP",@"Heamoglobin",@"HbA1c",@"Medication", nil];
        Btnsave=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(alertShow)];
        self.navigationItem.rightBarButtonItem=Btnsave;
        
    }
    return self;
}

- (void)dealloc
{
    [tableView1 release];
    [switchWeight release];
    [switchGlucose release];
    [switchBP release];
    [switchHeamo release];
    [switchHba1c release];
    [switchMed release];
    [super dealloc];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    NSLog(@"    Timespan is   %d",timespan);
    
    arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId :timespan]];
    
    if (timespan==1) {
        [morningButton setImage:[UIImage imageNamed:@"morningcurrent.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternoon.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"evening.png"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor orangeColor]];
        [afternoonLabel setTextColor:[UIColor blackColor]];
        [eveningLabel setTextColor:[UIColor blackColor]];
        [nightLabel setTextColor:[UIColor blackColor]];
    }
    if (timespan==2) {
        [morningButton setImage:[UIImage imageNamed:@"morning.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternooncurrent.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"evening.png"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor blackColor]];
        [afternoonLabel setTextColor:[UIColor orangeColor]];
        [eveningLabel setTextColor:[UIColor blackColor]];
        [nightLabel setTextColor:[UIColor blackColor]];
    }
    if (timespan==3) {
        [morningButton setImage:[UIImage imageNamed:@"morning.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternoon.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"eveningcurrent"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor blackColor]];
        [afternoonLabel setTextColor:[UIColor blackColor]];
        [eveningLabel setTextColor:[UIColor orangeColor]];
        [nightLabel setTextColor:[UIColor blackColor]];
    }
    if (timespan==4) {
        [morningButton setImage:[UIImage imageNamed:@"morning.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternoon.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"evening.png"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"nightcurrent.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor blackColor]];
        [afternoonLabel setTextColor:[UIColor blackColor]];
        [eveningLabel setTextColor:[UIColor blackColor]];
        [nightLabel setTextColor:[UIColor orangeColor]];
    }
    switchWeight.on=[[arrayFlags objectAtIndex:1]boolValue];
    switchGlucose.on=[[arrayFlags objectAtIndex:2]boolValue];
    switchBP.on=[[arrayFlags objectAtIndex:3]boolValue];
    switchHeamo.on=[[arrayFlags objectAtIndex:4]boolValue];
    switchHba1c.on=[[arrayFlags objectAtIndex:5]boolValue];
    switchMed.on=[[arrayFlags objectAtIndex:6]boolValue];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableView1:nil];
    [self setSwitchWeight:nil];
    [self setSwitchGlucose:nil];
    [self setSwitchBP:nil];
    [self setSwitchHeamo:nil];
    [self setSwitchHba1c:nil];
    [switchMed release];
    switchMed = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row)
    {
        case 0:
            //[userLabel setText:[arrayName objectAtIndex:0]];
            //cell.textLabel.text=[arrayName objectAtIndex:0];
            cell.textLabel.text=[NSString stringWithFormat:@"            %@",[arrayName objectAtIndex:0]];
            
            [cell.contentView addSubview:self.switchWeight];
            cell.accessoryView=switchWeight;
            UIImageView *userImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weight_icon.png"]];
            [cell.contentView addSubview:userImage];
            [userImage setFrame:CGRectMake(5, 2, 40, 40)];
            [userImage release];
            break;
        case 1:
            //cell.textLabel.text=[arrayName objectAtIndex:1];
            cell.textLabel.text=[NSString stringWithFormat:@"            %@",[arrayName objectAtIndex:1]];
            [cell.contentView addSubview:self.switchGlucose];
            cell.accessoryView=switchGlucose;
            userImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"glucose_icon.png"]];
            [cell.contentView addSubview:userImage];
            [userImage setFrame:CGRectMake(5, 2, 40, 40)];
            [userImage release];
            break;
        case 2:
            //cell.textLabel.text=[arrayName objectAtIndex:2];
            cell.textLabel.text=[NSString stringWithFormat:@"            %@",[arrayName objectAtIndex:2]];
            
            [cell.contentView addSubview:self.switchBP];
            cell.accessoryView=switchBP;
            userImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bpmeter_icon.png"]];
            [cell.contentView addSubview:userImage];
            [userImage setFrame:CGRectMake(5,2, 40, 40)];
            [userImage release];
            break;
        case 3:
            // cell.textLabel.text=[arrayName objectAtIndex:3];
            cell.textLabel.text=[NSString stringWithFormat:@"            %@",[arrayName objectAtIndex:3]];
            
            [cell.contentView addSubview:self.switchHeamo];
            cell.accessoryView=switchHeamo;
            userImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hemoglobin_icon.png"]];
            [cell.contentView addSubview:userImage];
            [userImage setFrame:CGRectMake(5, 2, 40, 40)];
            [userImage release];
            break;
        case 4:
            cell.textLabel.text=[NSString stringWithFormat:@"            %@",[arrayName objectAtIndex:4]];
            [cell.contentView addSubview:self.switchHba1c];
            cell.accessoryView=switchHba1c;
            userImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"glycohemoglobin_icon.png"]];
            [cell.contentView addSubview:userImage];
            [userImage setFrame:CGRectMake(5, 2, 40, 40)];
            [userImage release];
            break;
            
        case 5:
            cell.textLabel.text=[NSString stringWithFormat:@"            %@",[arrayName objectAtIndex:5]];
            [cell.contentView addSubview:self.switchMed];
            cell.accessoryView=switchMed;
            userImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"medication.png"]];
            [cell.contentView addSubview:userImage];
            [userImage setFrame:CGRectMake(15, 2, 20, 40)];
            [userImage release];
            break;
            
            
            
    }
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row ==0)// update user
//    {
//        classNotification * objNotificationSetting=[[classNotification alloc] initWithStyle:UITableViewStyleGrouped];
//        objNotificationSetting.label=@"Weight";
//        objNotificationSetting.aUser=self.aUser;
//        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
//        objNotificationSetting.title=@"Reminder";
//        [self.navigationController pushViewController:objNotificationSetting animated:YES];
//        [objNotificationSetting release];
//
//                
//    }
//    else  if(indexPath.row==1)   // update caregiver info
//    {
//        classNotification * objNotificationSetting=[[classNotification alloc] initWithStyle:UITableViewStyleGrouped];
//        objNotificationSetting.label=@"Glucose";
//        objNotificationSetting.aUser=self.aUser;
//        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
//        objNotificationSetting.title=@"Reminder";
//        [self.navigationController pushViewController:objNotificationSetting animated:YES];
//        [objNotificationSetting release];
//        
//
//     
//   
//    }
//    
//    else if(indexPath.row==2)
//    {
//        classNotification * objNotificationSetting=[[classNotification alloc] initWithStyle:UITableViewStyleGrouped];
//        objNotificationSetting.label=@"Blood Pressure";
//        objNotificationSetting.aUser=self.aUser;
//        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
//        objNotificationSetting.title=@"Reminder";
//        [self.navigationController pushViewController:objNotificationSetting animated:YES];
//        [objNotificationSetting release];
//        
//        
//         }
//    
//    
//    
//    else  if(indexPath.row==3)   
//    {
//        
//        
//        
//        classNotification * objNotificationSetting=[[classNotification alloc] initWithStyle:UITableViewStyleGrouped];
//        objNotificationSetting.label=@"Heamoglobin";
//        objNotificationSetting.aUser=self.aUser;
//        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
//        objNotificationSetting.title=@"Reminder";
//        [self.navigationController pushViewController:objNotificationSetting animated:YES];
//        [objNotificationSetting release];
//        
//        
//    }
//    else if(indexPath.row==4)
//        
//    {
//        
//        classNotification * objNotificationSetting=[[classNotification alloc] initWithStyle:UITableViewStyleGrouped];
//        objNotificationSetting.label=@"Glyco Heamoglobin";
//        objNotificationSetting.aUser=self.aUser;
//        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
//        objNotificationSetting.title=@"Reminder";
//        [self.navigationController pushViewController:objNotificationSetting animated:YES];
//        [objNotificationSetting release];
//        
//}
//    
//    else if(indexPath.row==5)
//        
//    {
//        
//        classNotification * objNotificationSetting=[[classNotification alloc] initWithStyle:UITableViewStyleGrouped];
//        objNotificationSetting.label=@"Medicine";
//        objNotificationSetting.aUser=self.aUser;
//        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
//        objNotificationSetting.title=@"Reminder";
//        [self.navigationController pushViewController:objNotificationSetting animated:YES];
//        [objNotificationSetting release];
//        
//    }
//    
//   

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)buttonTapMethod:(id)sender
{
    UIButton* button= (UIButton*)sender;
    if (button.tag==0) {
        
        timespan=1;
        arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId :timespan]];
        
        [tableView1 reloadData];
        [morningButton setImage:[UIImage imageNamed:@"morningcurrent.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternoon.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"evening.png"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor orangeColor]];
        [afternoonLabel setTextColor:[UIColor blackColor]];
        [eveningLabel setTextColor:[UIColor blackColor]];
        [nightLabel setTextColor:[UIColor blackColor]];
        [tableView1 reloadData];
        
    }
    else if(button.tag==1)
    {
        timespan=2;
        arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId :timespan]];
        
        [tableView1 reloadData];
        [morningButton setImage:[UIImage imageNamed:@"morning.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternooncurrent.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"evening.png"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor blackColor]];
        [afternoonLabel setTextColor:[UIColor orangeColor]];
        [eveningLabel setTextColor:[UIColor blackColor]];
        [nightLabel setTextColor:[UIColor blackColor]];
        [tableView1 reloadData];
    }
    else if(button.tag==2)
    {
        timespan=3;
        arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId :timespan]];
        
        [tableView1 reloadData];
        [morningButton setImage:[UIImage imageNamed:@"morning.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternoon.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"eveningcurrent"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor blackColor]];
        [afternoonLabel setTextColor:[UIColor blackColor]];
        [eveningLabel setTextColor:[UIColor orangeColor]];
        [nightLabel setTextColor:[UIColor blackColor]];
        [tableView1 reloadData];
    }
    else if(button.tag==3)
    {
        timespan=4;
        arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId :timespan]];
        
        [tableView1 reloadData];
        [morningButton setImage:[UIImage imageNamed:@"morning.png"] forState:UIControlStateNormal];
        [afternoonButton setImage:[UIImage imageNamed:@"afternoon.png"] forState:UIControlStateNormal];
        [eveningButton setImage:[UIImage imageNamed:@"evening.png"] forState:UIControlStateNormal];
        [nightButton setImage:[UIImage imageNamed:@"nightcurrent.png"] forState:UIControlStateNormal];
        [morningLabel setTextColor:[UIColor blackColor]];
        [afternoonLabel setTextColor:[UIColor blackColor]];
        [eveningLabel setTextColor:[UIColor blackColor]];
        [nightLabel setTextColor:[UIColor orangeColor]];
        [tableView1 reloadData];
    }
    switchWeight.on=[[arrayFlags objectAtIndex:1]boolValue];
    switchGlucose.on=[[arrayFlags objectAtIndex:2]boolValue];
    switchBP.on=[[arrayFlags objectAtIndex:3]boolValue];
    switchHeamo.on=[[arrayFlags objectAtIndex:4]boolValue];
    switchHba1c.on=[[arrayFlags objectAtIndex:5]boolValue];
    switchMed.on=[[arrayFlags objectAtIndex:6]boolValue];
}
-(void)alertShow
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Tracker Setting" message:@"Do you want to apply this settings?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag=1001;
    [alert show];
    [alert release];
}

-(void)TouchSave
{
    
    classDiffTime *obj_Time=[[classDiffTime alloc]initWithNibName:@"classDiffTime" bundle:nil];
    
  //  UINavigationController * navC=[[UINavigationController alloc]initWithRootViewController:obj_Time];
    // user.delegate=self;
        if (switchWeight.on==YES)
        {
          wtflag = @"YES";

           // obj_Time.str_weightName=[arrayName objectAtIndex:0];
            
        }
    else
        wtflag=@"NO";
    
   
    if(switchGlucose.on==YES)
    {
           bgflag=@"YES";
        //obj_Time.str_BGName=[arrayName objectAtIndex:1];
    }
    

     else
        bgflag=@"NO";
    
    
   if(switchBP.on==YES)
     {  bpflag=@"YES";
        // obj_Time.str_BPName=[arrayName objectAtIndex:2];
     
     }
    
    
   else
       bpflag=@"NO";
    

    if(switchHeamo.on==YES)
    {
        hgflag=@"YES";
       //  obj_Time.str_HGName=[arrayName objectAtIndex:3];
         
    }
    
    else
        hgflag=@"NO";
    

        
        
        
     if(switchHba1c.on==YES)
     {
         
          hga1cflag=@"YES";
        // obj_Time.str_HG1Name=[arrayName objectAtIndex:4];
         
     }
    
    
     else
         hga1cflag=@"NO";
    if(switchMed.on==YES)
    {
        
        medflag=@"YES";
        // obj_Time.str_HG1Name=[arrayName objectAtIndex:4];
        
    }
    
    
    else
       medflag=@"NO";
    

 
   // [self.navigationController presentModalViewController:navC animated:YES];
    
    
    NSString * query =[[NSString alloc] initWithFormat:@"update vnscripts set wtflag='%@', bgflag='%@', bpflag='%@',hgflag='%@',hga1cflag='%@',medflag='%@' where userId=%d and timespan=%d",wtflag,bgflag,bpflag,hgflag,hga1cflag,medflag,aUser.userId,timespan];
    [classDatabaseOperations updateFlags:query];
    
    [query release];


    
    
   // [self.tableView1 reloadData];
    [obj_Time release];  

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==1001)
    {
        
        if(buttonIndex==1)// for ok
        {
            [self TouchSave];
            
        }
        
    }
    
}
@end
