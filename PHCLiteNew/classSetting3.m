//
//  classSetting3.m
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 16/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//
///#import "classTracker.h"
#import "classSetting3.h"
#import "classInform.h"
#import "audioSetting.h"
#import "editProfile.h"
#import "changePass.h"
#import "careGivingInfo.h"
#import "classUser.h"
#import "classLocalNotificationSettings.h"
#import "classRemind.h"
#import "classHome.h"
#import "classSynkData.h"
#import "classRecordView.h"
#import "classPicture.h"
#import "classLanguage.h"
@implementation classSetting3
@synthesize arrayFlags;
@synthesize aUser;
@synthesize nurseImage;
@synthesize imagepath;
@synthesize editFlag;
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
    
    
    
    
    //NSLog(@"  \n\n\n cluser userid in setting is  %d", clUser.userId);
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;

    self.title=@"Setting";
    // self.title=@"Synk";
    self.tabBarItem.title=@"Setting";
    self.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
    
    NSLog(@"\n\n\nuser id in setting is %d",aUser.userId);
    
    self.parentViewController.view.backgroundColor = [UIColor clearColor] ;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;

    
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

-(void)newUserAddingDidComplete
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void)newUserAddingDidCancel
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:17.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
 
   
    switch (indexPath.row)
    {
        case 0:
            
            cell.textLabel.text=@"   Edit Profile";
    
            cell.imageView.frame=CGRectMake(10, 0, 45,40);
            break;
            
        case 1:
            
            cell.textLabel.text=@"   Change Password";
            
            break;
            
            
        case 2:
            
           cell.textLabel.text=@"   Audio Settings";  
              
            break;
        
        case 3:
            
            cell.textLabel.text=@"   Tracker Settings";
            
            break;
        case 4:
              cell.textLabel.text=@"   Notification";  
            break;
            
        case 5 :
            cell.textLabel.text=@"   Add Care Giver ";
            break;
        case 6 :
            cell.textLabel.text=@"   Update Care Giver Image";
            break;
        case 7:
            cell.textLabel.text=@"   Register to Panhealth";

    }  
    
    
    
         
    // Configure the cell...
    
    return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    
    if(indexPath.row==0)
    {
        editProfile *profile=[[editProfile alloc]initWithNibName:@"editProfile" bundle:nil];
        NSLog(@"auser %@ ",aUser);
          profile.aUser=aUser;
        profile.delegate=self;
        NSLog(@"profile.auser %@ ",aUser);
    
        [self.navigationController pushViewController:profile animated:YES];
        
    }
    if(indexPath.row== 1)
    {
       changePass *password=[[changePass alloc]initWithNibName:@"changePass" bundle:nil];
        password.aUser=aUser;
        [self.navigationController pushViewController:password animated:YES];
        

    }
    else if(indexPath.row==2)
    {
        classLanguage * objLang =[[classLanguage alloc]initWithStyle:UITableViewStyleGrouped];
        objLang.objUser=aUser;
        objLang.myAudioPlayer=self.myAudioPlayer;
        [self.navigationController pushViewController:objLang animated:YES];
        
        [objLang release];
        
    }

    else if(indexPath.row==3)
     {
      
         classInform *obj=[[classInform alloc]initWithNibName:@"classInform"  bundle:nil ];
         obj.aUser=aUser;
         obj.timespan=1;
         
         [self.navigationController pushViewController:obj  animated:YES];
         [obj release];

    }
//  else  if (indexPath.row ==4)
//    {
//        audioSetting *audio=[[audioSetting alloc]initWithStyle:UITableViewStyleGrouped];
//        audio.aUser=self.aUser;
//        [self.navigationController pushViewController:audio animated:YES];
//         
//         [audio release];
//    }
    
    else if(indexPath.row ==4)
    {
        classLocalNotificationSettings *notification=[[classLocalNotificationSettings alloc]initWithNibName:@"classLocalNotificationSettings" bundle:nil] ;
        notification.label=@"Medicine";
        notification.objUser=aUser;

        [self.navigationController pushViewController:notification animated:YES];
        [notification release];
    }
    else if(indexPath.row==5)
        {
            careGivingInfo *obj_inf=[[careGivingInfo alloc]initWithNibName:@"careGivingInfo" bundle:nil];
            obj_inf.aUser=aUser;
            [self.navigationController pushViewController:obj_inf animated:YES];
            [obj_inf release];
            
        }
    else if(indexPath.row==6)
    {
        classPicture * takePicture=[[classPicture alloc] init];
        
        takePicture.isCareGiverMode  = YES;
        takePicture.objUser=aUser;
        [self.navigationController pushViewController:takePicture animated:YES];
        [takePicture release];


    }
    else if(indexPath.row==7)
    {

        classReigisterUser * oldUser=[[classReigisterUser alloc] init];
        oldUser.objUser=aUser;
        oldUser.delegate=self;
        oldUser.myAudioPlayer=self.myAudioPlayer;
        oldUser.title=@"Sign Up";
        [self.navigationController pushViewController:oldUser animated:YES];
        
        [oldUser release];

    }

}

-(void)userUpdatingDidComplete
{
    [self.tableView reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)userUpdatingDidCancel
{
    
}
@end

