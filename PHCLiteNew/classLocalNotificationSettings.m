//
//  classLocalNotificationSettings.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/30/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classLocalNotificationSettings.h"
#import "classLocalNotification.h"
#import "classUser.h"
#import "classNotificaitonTimePicker.h"
#import "classAudio.h"

@implementation classLocalNotificationSettings
@synthesize cellNotification;
@synthesize lblReminderStatus;
@synthesize switchOnOff;
@synthesize objUser;
@synthesize label;
@synthesize myAudioPlayer;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [cellNotification release];
    [switchOnOff release];
    [lblReminderStatus release];
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

    
    //1st initialize our switch  and label  
    UISwitch * tempSwith=[[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 94, 30)];
    [tempSwith addTarget:self action:@selector(trunOnOffNotification:) forControlEvents:UIControlEventValueChanged];
    self.switchOnOff=tempSwith ;    
    [tempSwith release];
    
    UILabel * tempLebel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    tempLebel.text=[[NSString alloc]initWithFormat:@"%@ time Reminder:",label];

   // tempLebel.text=@"Medicine time Reminder:";
    tempLebel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    self.lblReminderStatus=tempLebel;
    [self.lblReminderStatus setBackgroundColor:[UIColor clearColor]];
    [tempLebel release];
    // and then get notification status
    [self getCurretnNotificationStatus];
    
    if(objUser.audioStatus==YES)
    {
        if(objUser.language==1)
        {
    NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"medicineTimeReminder", nil];
    [self.myAudioPlayer playAudios:array];
    [array release];
        }
        else if(objUser.language==2)
            
            {
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2medicinetimeRemider", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];

            }

    }

    
    
    NSLog(@" \n\n\nuser in notification setting is  %d\n\n\n    ", objUser.userId);

    
    
    
}

- (void)viewDidUnload
{
    [self setCellNotification:nil];
    [self setSwitchOnOff:nil];
    [self setLblReminderStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if(section==0)
    {
        
        return 1;
    }
    else if(section==1)
    {
        
        return 4;
        
    }
    
    return 0;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section==0)
    {
        
        return 55;
    }
    else if(indexPath.section==1)
    {
        
        return 60;
        
    }
    
    return 0;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
    
    
    if(indexPath.section==1)
    {
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row)
        {
            case 0: cell.textLabel.text=@"Morning";
                    cell.detailTextLabel.text=[NSString stringWithFormat:@"Reminder time:%@",[classLocalNotification notificaitonTimeForTimeSapn:1 forUser:self.objUser]];
                
                break;
                
            case 1: cell.textLabel.text=@"Afternoon";
                cell.detailTextLabel.text=[NSString stringWithFormat:@"Reminder time:%@",[classLocalNotification notificaitonTimeForTimeSapn:2 forUser:self.objUser]];

                
                break;

            case 2: cell.textLabel.text=@"Evening";
                cell.detailTextLabel.text=[NSString stringWithFormat:@"Reminder time:%@",[classLocalNotification notificaitonTimeForTimeSapn:3 forUser:self.objUser]];

                
                break;

                
            case 3: cell.textLabel.text=@"Night";
                cell.detailTextLabel.text=[NSString stringWithFormat:@"Reminder time:%@",[classLocalNotification notificaitonTimeForTimeSapn:4 forUser:self.objUser]];

                
                break;

            
        }
      
        
        return cell;       
        
    }
    else if(indexPath.section==0)
    {
        
        [cell.contentView addSubview:self.switchOnOff];
        [cell.contentView addSubview:self.lblReminderStatus];
        cell.accessoryType=UITableViewCellAccessoryNone;

        return cell;       

        
    }
    return  cell;// useless to hide warning only
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    classNotificaitonTimePicker * objTimePicker=[[classNotificaitonTimePicker alloc] initWithNibName:@"classNotificaitonTimePicker" bundle:nil];
    objTimePicker.objUser=self.objUser;
    objTimePicker.delegate=self;
    objTimePicker.myAudioPlayer=self.myAudioPlayer;
    
    if(indexPath.section==1)
    {
        
        if(indexPath.row==0)
        {
            
            objTimePicker.TimeSpan=1;
            

            
        }
        else
            if(indexPath.row==1)
            {
                
                objTimePicker.TimeSpan=2;

                
            }
            else
                if(indexPath.row==2)
                {
                    
                    objTimePicker.TimeSpan=3;

                    
                }
                else
                    if(indexPath.row==3)
                    {
                        
                        objTimePicker.TimeSpan=4;

                        
                    }
        
        
        UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objTimePicker];
        [self presentModalViewController:navC animated:YES];
        
    }
    [objTimePicker release];

    
    
}

- (void)trunOnOffNotification:(id)sender
{
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:objUser.userId  forKey:[NSString stringWithFormat: @"notificationUser%d",objUser.userId]];
   [ userDefaults setInteger:objUser.userId forKey:@"userId"];
    
    
    
         NSLog(@"\n\n notification set for user %d", objUser.userId) ;
    

    UISwitch* notificationSwitch=sender;
    
    if(notificationSwitch.on==YES)
    {
        //  set value "on" for notificationStatus in userDefauts 
        [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"notificationStatus%d",objUser.userId]];
        
        
        //also schedule reminders of this user
        [classLocalNotification setLocalNotificationForUser:objUser];
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"medicineTimeReminderTurnedon", nil];
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
        else if(objUser.language==2)
        {
            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2MedTimeREmON", nil];
            [self.myAudioPlayer playAudios:array];
            [array release];

            
        }
            
        }
    }
    else if(notificationSwitch.on==NO)
        
    {
        
        // also set value on for notificationStatus in userDefauts 
        [userDefaults setObject:@"off" forKey:[NSString stringWithFormat:@"notificationStatus%d",objUser.userId]];
        
        
        //also cancel scheduled reminders of this user
        [classLocalNotification cancelNotificationForTimeSpan:1 forUser:objUser];
        [classLocalNotification cancelNotificationForTimeSpan:2 forUser:objUser];
        [classLocalNotification cancelNotificationForTimeSpan:3 forUser:objUser];
        [classLocalNotification cancelNotificationForTimeSpan:4 forUser:objUser];
        
        if(objUser.audioStatus==YES)
        {if(objUser.language==1){
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"medicineReminderTurnedOff", nil];
        [self.myAudioPlayer playAudios:array];
        [array release];
        }
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2MedTimeREmOff", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
                
                
            }

        }
    }
    
}


-(void)getCurretnNotificationStatus
{
    // get userdefaults instance
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults]; 
    
    // get current status of notification, current notification can be nil or either on or off
    NSString * notificationStatus=[userDefaults objectForKey:[NSString stringWithFormat:@"notificationStatus%d",objUser.userId]];  
    
    
    if([notificationStatus isEqualToString:@"on"] || notificationStatus ==nil)
    {
        self.switchOnOff.on=YES;
        
        if(notificationStatus ==nil)// in case if notificaton status is  not already set, set it to on
        {
            
            [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"notificationStatus%d",objUser.userId]];
                   }
        
        
    }
    else  if([notificationStatus isEqualToString:@"off"])

    {
        
        self.switchOnOff.on=NO;
    
    }
    
    
    
}


-(void)timeSelectionDidCancel
{
    
    [self dismissModalViewControllerAnimated:YES];

    
    
    
}


-(void)timeSelectionDidComplete
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
    
}


@end
