//
//  classWeightLog.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/12/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classWeightLog.h"
#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
@implementation classWeightLog
@synthesize arrayOfData;
@synthesize aUser;
@synthesize myAudioPlayer;
@synthesize logTable;
@synthesize headings;
@synthesize date;
@synthesize time;
@synthesize value;
@synthesize strName;
@synthesize btnBarDelete;
@synthesize logType;
- (id)initWithStyle:(UITableViewStyle)style
{
    //self = [super initWithStyle:style];
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
  // NSLog(@" \n\n\n\nuser id  in log %d\n\n\n",aUser.userId);
    
    if([strName isEqualToString:@"Weight"])
    {
        
        self.title=@"Weight" ;
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"WG" :aUser.userId]  ];
        logType=@"WG";
    }
    
    else if([strName isEqualToString:@"BloodGlucose"] )
    {
        
        self.title=@"BloodGlucose" ;
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BG" :aUser.userId]  ];
        logType=@"BG";

        
    }
    else if([strName isEqualToString:@"BloodPressure"] )
    {
        
        self.title=@"BloodPressure";
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BPsys" :aUser.userId]  ];
        logType=@"BPsys";

        
    }
    else if([strName isEqualToString:@"BP(Diastolic)"] )
    {
        
        self.title=@"BP(Diastolic)" ;
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BPdia" :aUser.userId]  ];
        logType=@"BPdia";

        
    }
    else if([strName isEqualToString:@"Pulse"] )
    {
        
        self.title=@"Pulse" ;
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"pulse" :aUser.userId]  ];
        NSLog(@"Pulse Rate %@",arrayOfData);
        logType=@"pulse";

    }
    else if([strName isEqualToString:@"Hemoglobin"] )
    {
        
        self.title=@"Hemoglobin" ;
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"HG" :aUser.userId]  ];
        logType=@"HG";

        
    }
    else if([strName isEqualToString:@"GlycoHemoglobin"] )
    {
        
        self.title=@"GlycoHemoglobin" ;
        arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"HBA1C":aUser.userId]  ];
        logType=@"HBA1C";

        
    }
  else
  {
    self.title=@"Medicine"   ;
      arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getMedicineData:aUser.userId] ];
      

      
  }
    
        
    logTable.delegate=self;
    logTable.dataSource=self;
    NSLog(@"%@ ",arrayOfData);
    self.btnBarDelete=[[[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(deleteLogMethod) ] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnBarDelete;
}

- (void)viewDidUnload
{
    self.parentViewController.view.backgroundColor = [UIColor  clearColor];
    self.parentViewController.view.alpha = 1.00;
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [logTable reloadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [logTable reloadData];

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

-(void)deleteLogMethod
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Delete" message:@"Do you want to delete all logs?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag=10;
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==10 && buttonIndex==0) // alert for new user added successfully
    {
        
        
        
    }
    else
        if(alertView.tag==10 && buttonIndex==1) // alert for  retry adding user
        {
            NSLog(@"Log Type :%@",logType);
            //[self deleteMethod:logType];
            [classDatabaseOperations deleteMethodTypes:logType forUser:aUser];
            arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"logType" :aUser.userId]  ];

            [self.logTable reloadData];

        }
    
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
    return [arrayOfData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [logTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
           
        cell.backgroundColor=[UIColor cyanColor];    
        cell.textLabel.text=[arrayOfData objectAtIndex:indexPath.row];  
      
        UILabel *lblDate=[[UILabel alloc ]initWithFrame:CGRectMake(0,0,95,44)];
        lblDate.textAlignment=UITextAlignmentLeft;
        lblDate.backgroundColor=[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.5] ;   
        [lblDate setTag:1];
        [cell.contentView addSubview:lblDate];
        [lblDate release];
        
        UILabel *lblTime=[[UILabel alloc ]initWithFrame:CGRectMake(95,0,113,44)];
        lblTime.textAlignment=UITextAlignmentLeft;
        lblTime.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0.2 alpha:0.5];
        [lblTime setTag:2];
        [cell.contentView addSubview:lblTime];
        [lblTime release];
        
        UILabel *lblValue=[[UILabel alloc ]initWithFrame:CGRectMake(206,0,114,44)];
        lblValue.textAlignment=UITextAlignmentLeft;
        [lblValue setTag:3];
        lblValue.backgroundColor=[UIColor colorWithRed:1 green:0.2 blue:0.8 alpha:0.5];   
        [cell.contentView addSubview:lblValue];
        [lblValue release];
        

    }
    
    // Configure the cell...
   // UILabel *Date=[[UILabel alloc]initWithFrame:CGRectMake(50, 50,50,50) ];
   // [cell.contentView addSubview:Date];
      //  if(indexPath.row % 2==0)
    // cell.textLabel.backgroundColor =[UIColor yellowColor];
    
  
    
     cell.textLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
