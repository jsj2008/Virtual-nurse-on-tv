//
//  classDeleteMember.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 9/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classDeleteMember.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"

int selectedIndex;


@implementation classDeleteMember
@synthesize delegate=_delegate;
@synthesize arrayOfUsers;
@synthesize myAudioPlayer;

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
    

    
    // show cancel button
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel) ] autorelease];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    [[self tableView] setBackgroundView:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]autorelease]];

    self.title=@"Delete";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
  

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.arrayOfUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UILabel *idLabel,*userLabel;
    const NSInteger DATE_LABEL_TAG = 1001;
    const NSInteger AmtLAbbelTag=1002;
    
    idLabel=[[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 180, 50)]autorelease];
    userLabel=[[[UILabel alloc]initWithFrame:CGRectMake(60,0, 125, 40)]autorelease];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        idLabel.backgroundColor = [UIColor clearColor];
        idLabel.tag=AmtLAbbelTag;
        idLabel.textColor = [UIColor grayColor];
        idLabel.font = [UIFont systemFontOfSize:12.0f];
        idLabel.textAlignment=UITextAlignmentLeft;
        [cell.contentView addSubview:idLabel];
        
        userLabel.tag=DATE_LABEL_TAG;
        userLabel.backgroundColor = [UIColor clearColor];
        userLabel.font = [UIFont systemFontOfSize:15.0f];
        [cell.contentView addSubview:userLabel];
        

    }
    
    // Configure the cell...
    
    //set comman font for all cell for futura  

          
        classUser * aUser=[self.arrayOfUsers objectAtIndex:indexPath.row];
        
        //set user data here      
        
        if([aUser.memberId isEqualToString:@""])
        {
           idLabel.text=@"Not registered with Panhealth";
            userLabel.text=[NSString stringWithFormat:@"%@ %@",aUser.firstName,aUser.lastName ];
            NSString * imgName = [NSString stringWithFormat:@"%@%@",aUser.firstName, aUser.lastName];
            // get path of document directory to get medicne image
            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
            NSString *documentsDir = [documentPaths objectAtIndex:0];
            NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
            UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
            UIImageView *userImage=[[UIImageView alloc]initWithImage:medicineImage];
            [userImage setFrame:CGRectMake(5, 5, 40, 40)];
            [cell.contentView addSubview:userImage];
            [userImage release];

        }
        else
        {
            
            idLabel.text=[NSString stringWithFormat:@"Panhealth Id: %@",aUser.memberId];
            userLabel.text=[NSString stringWithFormat:@"%@ %@",aUser.firstName,aUser.lastName ];
            NSString * imgName = [NSString stringWithFormat:@"%@%@",aUser.firstName, aUser.lastName];
            // get path of document directory to get medicne image
            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
            NSString *documentsDir = [documentPaths objectAtIndex:0];
            NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
            UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
            UIImageView *userImage=[[UIImageView alloc]initWithImage:medicineImage];
            [userImage setFrame:CGRectMake(5, 5, 40, 40)];
            [cell.contentView addSubview:userImage];
            [userImage release];
        }
//[idLabel release];
//    [userLabel release];
    
    
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
    


    selectedIndex=indexPath.row;
    
    UIActionSheet * action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Member" otherButtonTitles:nil, nil];
    
    
    [action showInView:self.view.window];
    [action release];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(buttonIndex==0)// delete member
    {
        
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Are you sure?\ndelete member?" message:@"Deleting member will delete all its data" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        alert.tag=158;
        [alert show];
        [alert release];
        NSMutableArray * array=[[[NSMutableArray alloc] init]autorelease];
        [array addObject:@"warning"];
        [self.myAudioPlayer playAudios:array];
        
    }
    else if(buttonIndex==0)
    {
        
        // cancel
        
        
    }
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==158)
    {
        
        if(buttonIndex==1)
        {
            
            //delete selected member
            
            [self deleteSelectedMember];
            
        }
        
        
        
    }
    
    
    
}


-(void)cancel
{
    
    
    
    [self.delegate cancelDeletingMember];
    
    
}

-(void)deleteSelectedMember
{
    
    
    
    // delete user    
    
    classUser * aUser=[self.arrayOfUsers objectAtIndex:selectedIndex];
    
    NSString * queryString=[NSString stringWithFormat:@"delete from user where userid=%d",aUser.userId];
    
    if([classDatabaseOperations add:queryString]==0)
    {
        
        NSLog(@" user  deleted  ");

        
        // now delete medicines
        [self deleteMedicines];
    }
    
    
    
    
}



-(void)deleteMedicines
{
    
    
    // delete user    
    
    classUser * aUser=[self.arrayOfUsers objectAtIndex:selectedIndex];
    
    NSString * queryString=[NSString stringWithFormat:@"delete from medicine where userid=%d",aUser.userId];
    
    if([classDatabaseOperations add:queryString]==0)
    {
        
        NSLog(@" user medicine deleted  ");

        
        NSString * queryString=[NSString stringWithFormat:@"delete from medicinetimedetails where userid=%d",aUser.userId];
        
        if([classDatabaseOperations add:queryString]==0)
        {
            NSLog(@" medicine time details deleted ");

            
            // since medicine and all its details are deleted delte its log too
            
            
            [self.arrayOfUsers removeObjectAtIndex:selectedIndex];
            
            NSIndexSet * index=[NSIndexSet indexSetWithIndex:0];            
            [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationFade];
            
            [self.delegate doneDeletingMember];
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"Arrow"];
            [self.myAudioPlayer playAudios:array];
            [array release];

            
        }
    
    
    }
    
    
}


@end
