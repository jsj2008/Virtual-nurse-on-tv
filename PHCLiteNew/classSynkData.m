//
//  classSynkData.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/9/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classSynkData.h"
#import "classSyncToPhone.h"
#import "classReigisterUser.h"
#import "classSyncToServer.h"
#import "classUser.h"
#import "classAudio.h"
#import "classSyncToServerTaekeMed.h"
#import "classSyncTrackerData.h"
#import "ClassConnectToPanHealth.h"
#import "classDatabaseOperations.h"

UITextField * txtCurrent;

@implementation classSynkData
@synthesize objUser;
@synthesize myAudioPlayer;
@synthesize delegate=_delegate;

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
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;

    self.title=@"Sync";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *strImg1=@"backImage1.png";
    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:strImg1]];
    NSString *strImg=[classDatabaseOperations getNurseImg:objUser.userId];
    NSLog(@"%@image",strImg);
    if ([strImg isEqualToString:@"null"])
    {
        logoView.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        logoView.image=[UIImage imageNamed:strImg];
    }
    
    
    logoView.frame = CGRectMake(270, 0, 43, 43);
    
    
    [self.navigationController.navigationBar addSubview:logoView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self checkUserDidRegistered];

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
        return 2;
        
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
  if(section==0)
   {
           return @"Sync your medicine to server or from server to phone.";
   }
    else
       if(section==1)
    {
      
        
        return @"To get member id & password";
       
   }
    
    return nil;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
   {
       
        return @"Sync your medicine to server or from server to phone.";
        
    }
    else
       if(section==1)
        {
          
           
           return @"To get member id & password";
           
       }
   
    return nil;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:15.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.section==0)
    {
      if(indexPath.row==0)       {
          cell.textLabel.text=@"From Phone To Panhealth Server";
          cell.imageView.image=[UIImage imageNamed:@"sync.png"];
 // cell.detailTextLabel.text=@"Synk your medicine form mobile to server";

           
       }
       else if(indexPath.row==1)
      {          cell.textLabel.text=@"From Panhealth Server to Phone"; 
           cell.imageView.image=[UIImage imageNamed:@"synkDown.png"];
          // cell.detailTextLabel.text=@"Synk your medicine form server to mobile";
           
       }
       else if(indexPath.row==2)
       {
           cell.textLabel.text=@"Sync Logs To Panhealth Server"; 
           cell.imageView.image=[UIImage imageNamed:@"sync.png"];
          // cell.detailTextLabel.text=@"Synk your medicine form server to mobile";
           
       } 

    /*    if(indexPath.row==0)
        {
                cell.textLabel.text=@"Register to Panhealth";
            cell.textLabel.textAlignment=UITextAlignmentCenter;
            cell.imageView.image=[UIImage imageNamed:@"user.png"];
            //cell.detailTextLabel.text=@"To get member id & password used in synking";
            
        }

    }
    else
        if(indexPath.section==1)
        {
            if(indexPath.row==0)
            {
                
                
               
                
                cell.textLabel.text=@"Register to Panhealth";
                cell.textLabel.textAlignment=UITextAlignmentCenter;
                cell.imageView.image=[UIImage imageNamed:@"user.png"];
                //cell.detailTextLabel.text=@"To get member id & password used in synking";
                           
            }
            
            else if(indexPath.row==1)
            {
                cell.textLabel.text=@"Connect to Panhealth";
                cell.textLabel.textAlignment=UITextAlignmentCenter;
                cell.imageView.image=[UIImage imageNamed:@"user.png"];
 
            }
        }
    */
    }
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //if(objUser.memberId!=nil)
    {
    
        if(indexPath.section==0 && indexPath.row==0)        
        {
//            // upload medicines
//            
//            // download medicines
//            classSyncToServer * objSynkToServer=[[classSyncToServer alloc]initWithNibName:@"classSyncToServer" bundle:nil];
//            objSynkToServer.objUser=self.objUser;
//            objSynkToServer.delegate=self;   
//            objSynkToServer.myAudioPlayer=self.myAudioPlayer;
//            UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:objSynkToServer];
//            nav.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
//            [objSynkToServer release];
//            [self presentModalViewController:nav animated:YES];
//            [nav release];
//            
            classReigisterUser * oldUser=[[classReigisterUser alloc] init];
            oldUser.objUser=self.objUser;
            oldUser.delegate=self;
            oldUser.myAudioPlayer=self.myAudioPlayer;
            oldUser.title=@"Sign Up";
            UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:oldUser];
            nav.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
            
            [oldUser release];
            [self presentModalViewController:nav animated:YES];
            [nav release];

            
        }    
        else if(indexPath.section==0 && indexPath.row==1)
        {
            // download medicines
            classSyncToPhone * objSynkFromServer=[[classSyncToPhone alloc]initWithNibName:@"classSyncToPhone" bundle:nil];
            objSynkFromServer.objUser=self.objUser;
            objSynkFromServer.deletate=self;  
            objSynkFromServer.myAudioPlayer=self.myAudioPlayer;
            UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:objSynkFromServer];
            nav.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
            [objSynkFromServer release];
            [self presentModalViewController:nav animated:YES];
            [nav release];
        }
    }
//    else
//    {
//        
//        
//        [self checkUserDidRegistered];
//        
//        
//        
//    }
     if(indexPath.section==1 && indexPath.row==0)        
    {
        // register member
        
        if([objUser.memberId isEqualToString:@"NULL"] || [objUser.memberId length]==0)
            
        {
        classReigisterUser * oldUser=[[classReigisterUser alloc] init];
        oldUser.objUser=self.objUser;
        oldUser.delegate=self;
        oldUser.myAudioPlayer=self.myAudioPlayer;
        oldUser.title=@"Sign Up";
        UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:oldUser];
            nav.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
        [oldUser release];
        [self presentModalViewController:nav animated:YES];
        [nav release];

        }
        
        else
        {
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Existing MemberID !" message:@" You are already registered to the panhealth" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.tag=100;
            [alert show];
            
            [alert release];
            
        }

        
    }
     else if(indexPath.section==0 && indexPath.row==2)
     {
         // download medicines
         classSyncTrackerData * objSynkToServer1=[[classSyncTrackerData alloc]initWithNibName:@"classSyncTrackerData" bundle:nil];    
         objSynkToServer1.objUser=self.objUser;
       //  objSynkToServer1.delegate=self;
         objSynkToServer1.myAudioPlayer=self.myAudioPlayer;
         UINavigationController * nav1=[[UINavigationController alloc] initWithRootViewController:objSynkToServer1];
         nav1.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
         [objSynkToServer1 release];
         [self presentModalViewController:nav1 animated:YES];
         [nav1 release];
         
         
     }
      else if(indexPath.section==1 && indexPath.row==1)  
      {
          ClassConnectToPanHealth * objConnPan=[[ClassConnectToPanHealth alloc]initWithNibName:@"ClassConnectToPanHealth" bundle:nil];    
          objConnPan.objUser=self.objUser;
          objConnPan.delegate=self;   
          objConnPan.myAudioPlayer=self.myAudioPlayer;
          UINavigationController * nav1=[[UINavigationController alloc] initWithRootViewController:objConnPan];
          nav1.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];

          [objConnPan release];
          [self presentModalViewController:nav1 animated:YES];
          [nav1 release];

      }
}


-(void)medicineDownloadingComplete
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate methodSyncComplete];
 
    
}

-(void)medicineDownloadingCancel
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}


-(void)newUserAddingDidCancel
{
    
    [self dismissModalViewControllerAnimated:YES];

    
    
}

-(void)newUserAddingDidComplete
{
    
    [self dismissModalViewControllerAnimated:YES];

    
    
}

-(void)syncToServerDidCancelTakMed
{
    [self dismissModalViewControllerAnimated:YES];

}
-(void)syncToServerDidCancel
{
    
    [self dismissModalViewControllerAnimated:YES];

    
}
-(void)syncToServerDidComplete
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    //[self.delegate methodSyncComplete];
    
}

-(void)userUpdatingDidCancel
{
    
    [self dismissModalViewControllerAnimated:YES];
 
    
}


-(void)userUpdatingDidComplete
{
    
    
    [self dismissModalViewControllerAnimated:YES];

    
}
-(void)ConnToPanHealthDidCancelTakMed
{
    [self dismissModalViewControllerAnimated:YES];

}


-(void)checkUserDidRegistered
{
  //  NSLog(@"memberid:%@",objUser.memberId);
    
    if([objUser.memberId isEqualToString:@"NULL"]||[objUser.memberId length]==0)
        
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Panhealth Member id Required !" message:@"A Panhealth member id and password is required in order to complete syncing process please tap continue to get your member id and password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Register", @"Existing User",nil];
        alert.tag=168;
        [alert show];
        
        [alert release];
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"panhealthMemberIdRequired"];
        
                [self.myAudioPlayer playAudios:array];
                [array release];
            }
            else if(objUser.language==2)
            {
                
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"2panhealthMemberIdRequired"];
                
                [self.myAudioPlayer playAudios:array];
                [array release];
                
                
            }
        }
    }
    else
    {
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
            
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"syncToServerOrFromServerToPhone"];
        
        [self.myAudioPlayer playAudios:array];
        [array release]; 
            }
            
            else if(objUser.language==2)
            {
                
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"2syncToServerOrFromServerToPhone"];
                
                [self.myAudioPlayer playAudios:array];
                [array release]; 
            }

            
            
            
        }
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==168)
    {
        
        if(buttonIndex==1)
        {
            
            
            
            
            classReigisterUser * oldUser=[[classReigisterUser alloc] init];
            oldUser.objUser=self.objUser;
            oldUser.delegate=self;
            oldUser.title=@"Sign Up";
            UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:oldUser];
            nav.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
            
            [oldUser release];
            [self presentModalViewController:nav animated:YES];
            [nav release];
            
            
            
        }
        
        
        if(buttonIndex==0)
        {
            
            
           /// [self dismissModalViewControllerAnimated:YES];    
        }
        
        
        if(buttonIndex==2)
        {
            
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Existing User !" message:@"Please Select Syncing Options " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            alert.tag=169;
            [alert show];
            
            [alert release];

            
            
        }
        
    }
    
}




-(void)syncToServerDidCompleteTakMed
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    //[self.delegate methodSyncComplete];
    
}
-(void)ConnToPanHealthDidCompleteTakMed
{
    [self dismissModalViewControllerAnimated:YES]; 
}







@end
