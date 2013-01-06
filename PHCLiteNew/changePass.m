//
//  changePass.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/14/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "changePass.h"
#import "classDatabaseOperations.h"
#import "classUser.h"

@implementation changePass

@synthesize coText;

@synthesize cText;

@synthesize nText;
@synthesize aUser;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
      self.title=@"Change Password";

    self.parentViewController.view.backgroundColor = [UIColor clearColor] ;
    self.parentViewController.view.alpha = 1.0;
    
    //--- set the tableview background as clear to view the backsplash
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];

    NSString *query2=[NSString stringWithFormat:@"select fname from user where userid=%d ",aUser.userId];
    NSString *pass=[classDatabaseOperations getString:query2];  
    NSLog(@"%@",pass);

 
    UIBarButtonItem *btnCancel=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPass) ] autorelease];
    
    self.navigationItem.leftBarButtonItem=btnCancel;
    
  UIBarButtonItem *btnSave=[[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePass) ] autorelease];
    self.navigationItem.rightBarButtonItem=btnSave;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(IBAction)forgetPasswordMethod
{
    
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Enter Email Id"];
    [dialog setMessage:@" "];
    [dialog addButtonWithTitle:@"Cancel"];
    [dialog addButtonWithTitle:@"OK"];
    dialog.tag=1001;
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
    [nameField setBackgroundColor:[UIColor whiteColor]];
    [dialog addSubview:nameField];
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog setTransform: moveUp];
    [dialog show];
    [dialog release];
    [nameField release];
    NSLog(@"Email id %@",aUser.emailId);
    
    
    
}

- (void)viewDidUnload
{
    
    
    [self setTableView:nil];
    [super viewDidUnload];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:17];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text=@"Current Password";
            [cell.contentView addSubview:self.cText];
            cell.accessoryView=cText;
            
            break;
        case 1:
            cell.textLabel.text=@"New Password";
            [cell.contentView addSubview:self.nText];
            cell.accessoryView=nText;
            
            break;
        case 2:
            cell.textLabel.text=@"Confirm Password";
            [cell.contentView addSubview:self.coText];
            cell.accessoryView=coText;
            break;
        case 3:
            cell=forgetPassword;
    }
            return cell;
}

-(void )tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
//    cell.textLabel.backgroundColor=[UIColor clearColor];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row<3)
    {
        
        return 60;
    }
    else
    {
        return 65;
    }
    
    return 0;
    
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
    if (indexPath.row==0) {
        [coText resignFirstResponder];
        [nText resignFirstResponder];
    }
    else  if (indexPath.row==1) {
        [coText resignFirstResponder];
        [cText resignFirstResponder];
    }

    else
        if (indexPath.row==2) {
            [nText resignFirstResponder];
            [cText resignFirstResponder];
        }

   }
- (void)savePass {
    [coText resignFirstResponder];
    [cText resignFirstResponder];
    [nText resignFirstResponder];
    NSString *query2=[NSString stringWithFormat:@"select password from user where userid=%d ",aUser.userId];
    NSString *pass=[classDatabaseOperations getString:query2];  
    NSLog(@"%@",pass);
    NSString *c1Text=cText.text;
    NSLog(@"%@",c1Text);
    NSString *n1Text=nText.text;
    NSLog(@"%@",n1Text);
    NSString *co1Text=coText.text;
    NSLog(@"%@",co1Text);
    if ([c1Text isEqualToString:NULL]) 
       {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You have not entered current password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        }
   
    else if ([n1Text isEqualToString:NULL]) 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You have not entered new password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
  
    else if ([co1Text isEqualToString:NULL]) 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You have not entered new password to confirm" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
  

if ([pass isEqualToString:c1Text]) 
  {
        
        
        if ([n1Text isEqualToString:co1Text]) 
        {
            NSString * query =[[NSString alloc] initWithFormat:@"update user set password='%@' where userId=%d",nText.text,aUser.userId];
            [classDatabaseOperations updateFlags:query];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank you" message:@"Your passwodr changed successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [alert show];
        [alert release];
            
        }
        
   
    else  
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"You have not entered correct match of new password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
       
        
        }
        
        
    }
else
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Your password is invalid" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];    
}
 
}


- (void)cancelPass
{
    
   [self.navigationController popViewControllerAnimated:YES];    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if(alertView.tag==119)
    {
        
        
        if(buttonIndex==0)        {
            
                       
        }
        else if(buttonIndex==1)            
        {
            NSString * query =[[NSString alloc] initWithFormat:@"update user set password='%@' where userId=%d",cText.text,aUser.userId];
            [classDatabaseOperations updateFlags:query];       }
    }
    if(alertView.tag==1001)
    {
        
        
        if(buttonIndex==1)  {
            
            if ([nameField.text isEqualToString:aUser.emailId])
            {
                NSString *query2=[NSString stringWithFormat:@"select password from user where userid=%d ",aUser.userId];
                NSString *pass=[classDatabaseOperations getString:query2];
                NSLog(@"%@",pass);
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Password" message:[NSString stringWithFormat:@"Your Pasword is %@ ", pass] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                [alert release];
                
                
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Not Match" message:@"Email ID not match" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                [alert release];
            }
            
        }
        else if(buttonIndex==0)
        {
            
        }
    }

}
@end
