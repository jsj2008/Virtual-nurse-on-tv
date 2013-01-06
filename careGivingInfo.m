//
//  careGivingInfo.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/9/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "careGivingInfo.h"
#import "classDatabaseOperations.h"

@implementation careGivingInfo
@synthesize image;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;
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
    
    
    switch (indexPath.row)
    {
        case 0:
            
            cell.textLabel.text=@"Merry";
            cell.imageView.image=[UIImage imageNamed:@"backImage1.png"];
           break;
            
        case 1:
            
            cell.textLabel.text=@"Delsy";
            cell.imageView.image=[UIImage imageNamed:@"backImage2.png"];
            
            break;
            
            
        case 2:
            
            cell.textLabel.text=@"Ana";  
            //cell.detailTextLabel.text=@"For reminders";            
            cell.imageView.image=[UIImage imageNamed:@"backImage3.png"];
            
            
            break;
            
        case 3:
            
            cell.textLabel.text=@"Martha";  
            //cell.detailTextLabel.text=@"For reminders";            
            cell.imageView.image=[UIImage imageNamed:@"backImage4.png"];
            
            
            break;
        case 4:
            
            cell.textLabel.text=@"Jeny";  
            //cell.detailTextLabel.text=@"For reminders";            
            cell.imageView.image=[UIImage imageNamed:@"backImage5.png"];
            
            
            break;

            
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        NSString *img=@"backImage1.png";  
        NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
        NSLog(@"%@image",strImg);
        if ([strImg isEqualToString:@"null"]) 
        {
            NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@')",aUser.userId,img];
            int m=[classDatabaseOperations add:queryStrin];
            NSLog(@"%d",m);
  
        }
        else{
            NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='%@' where userId='%d'",img,aUser.userId];
            [classDatabaseOperations updateFlags:queryString];
           
        } 

        

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Merry as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
   else if(indexPath.row==1)
    {
        NSString *img=@"backImage2.png";  
        
        NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
        NSLog(@"%@image",strImg);
        if ([strImg isEqualToString:@"null"]) 
        {
            NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@')",aUser.userId,img];
            int m=[classDatabaseOperations add:queryStrin];
            NSLog(@"%d",m);
            
        }
        else{
            NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='%@' where userId='%d'",img,aUser.userId];
            [classDatabaseOperations updateFlags:queryString];
            
        } 
        
        

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Delsy as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
   else if(indexPath.row==2)
   {
       NSString *img=@"backImage3.png";  
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSLog(@"%@image",strImg);
       if ([strImg isEqualToString:@"null"]) 
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@')",aUser.userId,img];
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='%@' where userId='%d'",img,aUser.userId];
           [classDatabaseOperations updateFlags:queryString];
           
       } 
       
       
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Ana as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release];


   }

   else if(indexPath.row==3)
   {
       NSString *img=@"backImage4.png";  
       
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSLog(@"%@image",strImg);
       if ([strImg isEqualToString:@"null"]) 
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@')",aUser.userId,img];
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='%@' where userId='%d'",img,aUser.userId];
           [classDatabaseOperations updateFlags:queryString];
           
       } 
       
       

       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Martha as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release];
       
   }

   else if(indexPath.row==4)
   {
       NSString *img=@"backImage5.png";  
       
       NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
       NSLog(@"%@image",strImg);
       if ([strImg isEqualToString:@"null"]) 
       {
           NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@')",aUser.userId,img];
           int m=[classDatabaseOperations add:queryStrin];
           NSLog(@"%d",m);
           
       }
       else{
           NSString *queryString=[NSString stringWithFormat: @"update careGive set careImg='%@' where userId='%d'",img,aUser.userId];
           [classDatabaseOperations updateFlags:queryString];
           
       } 
       
       
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You have choosen Jeny as your nurse" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [alert show];
       [alert release]; 
       
   }

}

@end
