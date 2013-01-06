//
//  classRefillingOption.m
//  i_strip
//
//  Created by Avi Kulkarni on 7/20/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classRefillingOption.h"
#import "classUser.h"
#import "classCareGiverInfo.h"
#import "classUser.h"
#import "classAudio.h"

id mySoundId;

@implementation classRefillingOption
@synthesize txtFiledRefill;
@synthesize btnBack;
@synthesize quantityToOrder;
@synthesize strMedicineName;

@synthesize myAudioPlayer;
@synthesize objUser;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
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
    
    
    
    self.txtFiledRefill=[[[UITextField alloc] initWithFrame:CGRectMake(5, 7, 220, 29)] autorelease];
    [self.txtFiledRefill setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txtFiledRefill setPlaceholder:@"Refilling pill quantity e.g. 30"];
    self.txtFiledRefill.font=[UIFont systemFontOfSize:13.0f];
    self.txtFiledRefill.font=[UIFont fontWithName:@"Futura" size:14.0f];
    
    
    
    
    
    self.navigationItem.hidesBackButton=YES;
    
    self.btnBack=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)] autorelease];
    self.navigationItem.leftBarButtonItem=btnBack;
    
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting.png"] style:UIBarButtonItemStylePlain target:self action:@selector(setCareGiverInfo)] autorelease];
    
    
    // set title
    self.title=strMedicineName;
    
    [self checkCareGiverInfo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(objUser.audioStatus==YES)
    {
    [self playAudio];
     
    }
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
    //return 3;
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
// Return the number of rows in the section.    
if(section==0)
{
    
    
    return 1;
}
    else
    {
        
        return 1;
        
    }
    
    return 0;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    if(section==0)
    {
        
        
        return @"Email";
    }
    else if(section==1)
    {
        
        return @"Sms";
        
    }
//    else if(section==2)
//    {
//        
//        return @"Refill Quantity";
//        
//    }
//    
    
    return nil;

    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    
    if(section==0)
    {
        
        
        return @"Send email to order the medicine to Caregiver/Pharmacy or Yourself";
    }
    else if(section==1)
    {
        
        return @"Send sms to order the medicine to Caregiver/Pharmacy or Yourself";
        
    }
//    else if(section==2)
//    {
//        
//        return @"once your order is fullfileld refill the medicine";
//        
//    }
    
    
    return nil;
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:15.0f];
    
    if(indexPath.section==0)
    {
        // Configure the cell...
        switch (indexPath.row)
        {
            case 0:cell.textLabel.text=@"Send Refilling email (Compose)";   
                
                if(objUser.careGiverEmail==nil)
                {
                    cell.detailTextLabel.text=@"Caregiver email not configured";
                    
                }
                else
                {
                    
                    cell.detailTextLabel.text=[NSString stringWithFormat:@"To: %@",objUser.careGiverEmail];
                    
                }
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.imageView.image=[UIImage imageNamed:@"email.png"];
                break;
                
    
                
        }
    }
    
    else if(indexPath.section==1)
    {
        
       cell.textLabel.text=@"Send Refilling sms";     
        
        if(objUser.careGiverEmail==nil)
        {
            cell.detailTextLabel.text=@"Caregiver phone not configured";
            
        }
        else
        {
            
            cell.detailTextLabel.text=[NSString stringWithFormat:@"To: %@",objUser.CareGiverPhone];
            
        }
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image=[UIImage imageNamed:@"sms.png"];

        
    }
        
//    else if(indexPath.section==2)
//    {
//        
//        
//       // cell.textLabel.text=@"Riffil";
//        UIButton * btnLogout=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btnLogout setFrame:CGRectMake(235, 7, 60, 30)];
//        [btnLogout setTitle:@"Refill" forState:UIControlStateNormal];
//        [btnLogout addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
//        btnLogout.titleLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
//        [cell.contentView addSubview:btnLogout];
//        
//
//        
//        [cell.contentView addSubview:self.txtFiledRefill];
//
//        
//    }
//    
    
    
    return cell;
}



-(void)setCareGiverInfo
{
    
    classCareGiverInfo * objCareGiverInfo=[[classCareGiverInfo alloc] initWithNibName:@"classCareGiverInfo" bundle:nil];
    
    UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objCareGiverInfo];
    objCareGiverInfo.delegate=self;
    objCareGiverInfo.objUser=self.objUser;
    objCareGiverInfo.title=@"Caregiver info";
    objCareGiverInfo.myAudioPlayer=self.myAudioPlayer;
    NSLog(@" configure usrid%d",objUser.userId);
    
    
    [self presentModalViewController:navC animated:YES];
 
    [objCareGiverInfo release];
    [navC release];
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
    
       
    
    
    if(indexPath.section==0)
    {
        
        
        if(indexPath.row==0)
        {
            
            // 1 for email
//            objQuantityTaker.modeOfRequest=1;
            
            [self send];
        }
                
    }
    
    
    
    else if(indexPath.section==1)
    {
        if(indexPath.row==0)
        {
            
            
            // 1 for sms
//            objQuantityTaker.modeOfRequest=2;
            [self sendInAppSMS:nil];
        }
    
    }
    
    
//     objQuantityTaker.delegate=self;
//    [self.navigationController pushViewController:objQuantityTaker animated:YES];
//    //objQuantityTaker.delegate=self;
//   // [self presentModalViewController:objQuantityTaker animated:YES];
//    
//    [objQuantityTaker release];
    
}


-(void)send
{
	
	/*MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject: [NSString stringWithFormat:@"Refilling request for %@",strMedicineName]];
    [controller setSubject: [NSString stringWithFormat:@"Refilling request for %@",strMedicineName]];
	[controller setSubject: [NSString stringWithFormat:@"Refilling request for %@",strMedicineName]];

    NSArray * arrayOfRecipient=[[NSArray alloc] initWithObjects:self.objUser.careGiverEmail,objUser.emailId ,nil];
    
    [controller setToRecipients:arrayOfRecipient];
    [arrayOfRecipient release];
    
	[controller setMessageBody:@"Refilling request message" isHTML:NO]; 
	if (controller) 
	{
		[self presentModalViewController:controller animated:YES];
	}
	[controller release];*/
	
	
	
	
}


-(void) sendInAppSMS:(id) sender
{
	/*MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = [NSString stringWithFormat:@"Refilling request for %@",strMedicineName];
		controller.recipients = [NSArray arrayWithObjects:objUser.CareGiverPhone,objUser.phoneNo, nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	}*/
}

/*- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) 
    {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
        {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iStrips Lite" message:@"Error occured while sendig sms"
														   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
        }
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) 
	{
		//NSLog(@"Emails sent!");
	}
	[self dismissModalViewControllerAnimated:YES];
}

*/
-(void)SoundId:(id)soundId{
    
    
    
    mySoundId=soundId;
    
}

-(void)back
{
    [myAudioPlayer stopAudio];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(void)dismissQuantityTaker
{
    
      [self dismissModalViewControllerAnimated:YES];    
    
    
    //[self send];
    
    
}


-(void)playAudio
{
    

if(objUser.careGiverEmail==nil && objUser.CareGiverPhone==nil)
{
    
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"confitureCareGiverInfo"];
    [myAudioPlayer playAudios:array];
    [array release];
    
}
    else
    {
    
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"selectOptions"];
    [myAudioPlayer playAudios:array];
    [array release];
        
    }
    
    
    
}

-(void)checkCareGiverInfo
{
    
    
    if(objUser.careGiverEmail==nil && objUser.CareGiverPhone==nil)
    {
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Configure  information" message:@"You have not yet configured your caregiver/pharmacy email id and phone number to which you would like to send request to reorder your medicine" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Configure", nil];
        
        alert.tag=150;
        [alert show];
        [alert release];
        
    }
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==150)
    {
        
        if(buttonIndex==1)
        {
            
            classCareGiverInfo * objCareGiverInfo=[[classCareGiverInfo alloc] initWithNibName:@"classCareGiverInfo" bundle:nil];
            
            UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objCareGiverInfo];
            [objCareGiverInfo release];
            objCareGiverInfo.delegate=self;
            objCareGiverInfo.objUser=self.objUser;
            NSLog(@" configure usrid%d",objUser.userId);

            
            [self presentModalViewController:navC animated:YES];
            [navC release];
            
            
        }
        else
        {
            
            if(objUser.audioStatus==YES)
            {
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"selectOptions"];
            [myAudioPlayer playAudios:array];
            [array release];
            }
            
            
        }
        
    }
    
    
    
}

-(void)careGiverInfoEnteringCancel
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)careGiverInfoEnteringComelete
{
    
    [self dismissModalViewControllerAnimated:YES];

    
    
}

@end
