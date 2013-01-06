//
//  careGivingInfo.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/9/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "careGivingInfo.h"
#import "classDatabaseOperations.h"
#import "classCareGiverInfo.h"

@implementation careGivingInfo
@synthesize image;
@synthesize aUser;
@synthesize classCareGiverObj;

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
    i=0;
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(methodAddNewMember)] autorelease];
    [self methodGetCareGiverListFromDatabase];
    NSLog(@"Array : %@",arrayOfCarGiver);
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    i=0;
      self.title=@"Add Care Giver";

    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(methodAddNewMember)] autorelease];
    arrayOfCarGiver=[classDatabaseOperations getCareGiverList];
    NSLog(@"Array : %@",arrayOfCarGiver);
    NSLog(@"ARRAY COUNT %d",[arrayOfCarGiver count]);
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
    arrayOfCarGiver=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getCareGiverList]];
    NSLog(@"Array : %@",arrayOfCarGiver);
    NSLog(@"ARRAY COUNT %d",[arrayOfCarGiver count]);
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
-(void)methodGetCareGiverListFromDatabase
{
    
    arrayOfCarGiver=[classDatabaseOperations getCareGiverList];
    [self.tableView reloadData];
    
    
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row<5)
    {
        
        return 70;
    }
    else
    {
        return 55;
    }
    
    return 0;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString *str=@"5";
    int j=[arrayOfCarGiver count]+ [str intValue];
    return j;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    if (indexPath.section<5) {
        

        switch (indexPath.section)
        {

            case 0:
                
                cell.textLabel.text=@"Merry";
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"Merry"];
                NSData *myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
                cell.imageView.image=[UIImage imageWithData:myData];
                break;
                
            case 1:
                
                cell.textLabel.text=@"Delsy";
                documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                documentsDir = [documentPaths objectAtIndex:0];
                databasePath = [documentsDir stringByAppendingPathComponent:@"Delsy"];
                 myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
                cell.imageView.image=[UIImage imageWithData:myData];
                break;
                
                
            case 2:
                
                cell.textLabel.text=@"Ana";
                documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                documentsDir = [documentPaths objectAtIndex:0];
                databasePath = [documentsDir stringByAppendingPathComponent:@"Ana"];
                myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
                cell.imageView.image=[UIImage imageWithData:myData];
                break;
                
            case 3:
                
                cell.textLabel.text=@"Martha";
                documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                documentsDir = [documentPaths objectAtIndex:0];
                databasePath = [documentsDir stringByAppendingPathComponent:@"Martha"];
                myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
                cell.imageView.image=[UIImage imageWithData:myData];
                
                break;
            case 4:
                
                cell.textLabel.text=@"Jeny";
                documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                documentsDir = [documentPaths objectAtIndex:0];
                databasePath = [documentsDir stringByAppendingPathComponent:@"Jeny"];
                myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
                cell.imageView.image=[UIImage imageWithData:myData];
                
                break;
                
                
        }
        return cell;
    }
    else {
        
        if(i<[arrayOfCarGiver count])
        {
            classCareGiverObj=[arrayOfCarGiver objectAtIndex:i];
            NSString * imgName = [NSString stringWithFormat:@"%@",classCareGiverObj.Name];
            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
            NSString *documentsDir = [documentPaths objectAtIndex:0];
            NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
            UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
            UIImageView *userImage=[[UIImageView alloc]initWithImage:medicineImage];
            [userImage  setFrame:CGRectMake(5, 5, 40, 40)];

            cell.textLabel.text=classCareGiverObj.Name;
            [cell.contentView addSubview:userImage];
            [userImage release];
            
        }
        i=i+1;
        return cell;
        
    }
    
    return cell;
  
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
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
        NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
        NSLog(@"%@image",strImg);
        if ([strImg isEqualToString:@"null"]) 
        {
            NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','Merry','12345','merry@gmail.com','Merry')",aUser.userId];
            int m=[classDatabaseOperations add:queryStrin];
            NSLog(@"%d",m);
  
        }
        else{
            NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='Merry',careGiverPhone='12345',careGiverEmail='merry@gmail.com',name='Merry' where userId='%d'",aUser.userId];
            NSLog(@"Query String %@",queryString);
            [classDatabaseOperations updateFlags:queryString];
           
        } 

        

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Merry as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
   else if(indexPath.section==1)
    {
        
        NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
        NSLog(@"%@image",strImg);
        if ([strImg isEqualToString:@"null"]) 
        {
            NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','Delsy','12345','delsy@gmail.com','Delsy')",aUser.userId];
            int m=[classDatabaseOperations add:queryStrin];
            NSLog(@"%d",m);
            
        }
        else{
            NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='Delsy',careGiverPhone='12345',careGiverEmail='delsy@gmail.com',name='Delsy' where userId='%d'",aUser.userId];
            NSLog(@"Query String %@",queryString);

            [classDatabaseOperations updateFlags:queryString];
            
        } 
        
        

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Delsy as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
   else if(indexPath.section==2)
   {
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSLog(@"%@image",strImg);
       if ([strImg isEqualToString:@"null"]) 
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','Ana','12345','ana@gmail.com','Ana')",aUser.userId];
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='Ana',careGiverPhone='12345',careGiverEmail='ana@gmail.com',name='Ana' where userId='%d'",aUser.userId];
           NSLog(@"Query String %@",queryString);

           [classDatabaseOperations updateFlags:queryString];
           
       } 
       
       
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Ana as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release];


   }

   else if(indexPath.section==3)
   {
       
       
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSLog(@"%@image",strImg);
       if ([strImg isEqualToString:@"null"]) 
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','Martha','12345','martha@gmail.com','Martha')",aUser.userId];
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='Martha',careGiverPhone='12345',careGiverEmail='martha@gmail.com',name='Martha' where userId='%d'",aUser.userId];
           NSLog(@"Query String %@",queryString);

           [classDatabaseOperations updateFlags:queryString];
           
       } 
       
       

       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Martha as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release];
       
   }

   else if(indexPath.section==4)
   {
       
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSLog(@"%@image",strImg);
       if ([strImg isEqualToString:@"null"]) 
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','Jeny','12345','jeny@gmail.com','Jeny')",aUser.userId];
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='Jeny',careGiverPhone='12345',careGiverEmail='jeny@gmail.com',name='Jeny' where userId='%d'",aUser.userId];
           NSLog(@"Query String %@",queryString);

           [classDatabaseOperations updateFlags:queryString];
           
       } 
       
       
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Jeny as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release]; 
       
   }
   else
   {
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSString *img=[NSString stringWithFormat:@"%@",classCareGiverObj.Name];
       NSLog(@"%@image",img);
       NSLog(@"%@strImg",strImg);
       
       NSLog(@"User ID %d",aUser.userId);
       
       if ([strImg isEqualToString:@"null"])
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@','%@','%@','%@')",aUser.userId,img,classCareGiverObj.phoneNo,classCareGiverObj.emailId,classCareGiverObj.Name];
           NSLog(@"query String %@",queryStrin);
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='%@', careGiverPhone='%@',careGiverEmail='%@',name='%@' where userId='%d'",img,classCareGiverObj.phoneNo,classCareGiverObj.emailId,classCareGiverObj.Name,aUser.userId];
           NSLog(@"query String %@",queryString);
           
           [classDatabaseOperations updateFlags:queryString];
           
       }
       
       settingObj.nurseImage.image=[UIImage imageNamed:strImg];
       NSString *str=[NSString stringWithFormat:@"You have choosen %@ as your nurse",classCareGiverObj.Name];
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:str delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release];
       
   }


}
-(void)methodAddNewMember
{
    
    
    classCareGiverInfo * objclassCareGiverInfo=[[classCareGiverInfo alloc] initWithNibName:@"classCareGiverInfo" bundle:nil];
    objclassCareGiverInfo.tabBarItem.title=@"New Member";
    objclassCareGiverInfo.tabBarItem.image=[UIImage imageNamed:@"userImage"];
    [self.navigationController pushViewController:objclassCareGiverInfo animated:YES];
    [objclassCareGiverInfo release];
    
    
}

@end
