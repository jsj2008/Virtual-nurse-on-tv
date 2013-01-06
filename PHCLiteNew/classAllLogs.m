//
//  classAllLogs.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 9/14/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classAllLogs.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"



@implementation classAllLogs
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
@synthesize flag;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    weightArray=[[NSMutableArray alloc]init];
    glucoseArray=[[NSMutableArray alloc]init];
    sysArray=[[NSMutableArray alloc]init];
    bpDiasArray=[[NSMutableArray alloc]init];
    pulseArray=[[NSMutableArray alloc]init];
    hgArray=[[NSMutableArray alloc]init];
    medArray=[[NSMutableArray alloc]init];
    glycoArray=[[NSMutableArray alloc]init];
    self.btnBarDelete=[[[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(deleteLogMethod) ] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnBarDelete;
    [self todayMethod];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
       [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     
    //[self.tableView reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==10 && buttonIndex==0) // alert for new user added successfully
    {
        
        
        
    }
    else
        if(alertView.tag==10 && buttonIndex==1) // alert for  retry adding user
        {

            [classDatabaseOperations deleteLogs:aUser];
            if ([flag isEqualToString:@"1"]) {
                [self todayMethod];
            }
            if ([flag isEqualToString:@"2"]) {
                [self AllMethod];
            }
            [self.logTable reloadData];

        }
    
}

-(IBAction)buttonTap
{
    if (LogsSegment.selectedSegmentIndex==1) {
        [self AllMethod];
    }
    else if (LogsSegment.selectedSegmentIndex==0)
    {
        [self todayMethod];
    }


}
-(void)deleteLogMethod
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Delete" message:@"Do you want to delete all logs?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag=10;
    [alert show];
    [alert release];
}
-(void)todayMethod
{
    NSDate *picker_date= [NSDate date];
    flag=@"1";
    date.text=@"Date Time";
    //[time setTextAlignment:NSTextAlignmentRight];
    time.text=@"Type";
    
    value.text=@"Value";
    NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
    [dateformator setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate=[dateformator stringFromDate:picker_date];
    [dateformator setDateFormat:@" HH:mm:ss"];
    NSString *currentTime=[dateformator stringFromDate:picker_date];
    NSLog(@"today is.......%@\n",currentDate); //show Date MM/dd/yyyy HH:mm:ss format.
    NSLog(@"today is.......%@\n",currentTime);
    [weightArray removeAllObjects];
    //weightArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations AllLogs:aUser.userId]];

    dataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations AllLogs:aUser.userId]];
    for (int i=0; i<[dataArray count]; i++) {
        NSRange range=[[dataArray objectAtIndex:i] rangeOfString:currentDate];
        if (range.location==NSNotFound) {
            
        }
        else
        {
            [weightArray addObject:[dataArray objectAtIndex:i]];
            
        }
    }
//    [glucoseArray removeAllObjects];
//
//    glucoseDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BG" :aUser.userId]  ];
//    for (int i=0; i<[glucoseDataArray count]; i++) {
//        NSRange range=[[glucoseDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [glucoseArray addObject:[glucoseDataArray objectAtIndex:i]];
//            
//        }
//    }
//    [sysArray removeAllObjects];
//
//    sysDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BP" :aUser.userId]  ];
//    for (int i=0; i<[sysDataArray count]; i++) {
//        NSRange range=[[sysDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [sysArray addObject:[sysDataArray objectAtIndex:i]];
//            
//        }
//    }
//    [bpDiasArray removeAllObjects];
//
////    diaDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BPdia" :aUser.userId]  ];
////    for (int i=0; i<[diaDataArray count]; i++) {
////        NSRange range=[[diaDataArray objectAtIndex:i] rangeOfString:currentDate];
////        if (range.location==NSNotFound) {
////            
////        }
////        else
////        {
////            [bpDiasArray addObject:[diaDataArray objectAtIndex:i]];
////            
////        }
////    }
////    [pulseArray removeAllObjects];
////
////    pulseDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"pulse" :aUser.userId]  ];
////    for (int i=0; i<[pulseDataArray count]; i++) {
////        NSRange range=[[pulseDataArray objectAtIndex:i] rangeOfString:currentDate];
////        if (range.location==NSNotFound) {
////            
////        }
////        else
////        {
////            [pulseArray addObject:[pulseDataArray objectAtIndex:i]];
////            
////        }
////    }
////    
//    [hgArray removeAllObjects];
//    hemoDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"HG" :aUser.userId]  ];
//    for (int i=0; i<[hemoDataArray count]; i++) {
//        NSRange range=[[hemoDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [hgArray addObject:[hemoDataArray objectAtIndex:i]];
//            
//        }
//    }
//    [glycoArray removeAllObjects];
//    glycoDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"HBA1C" :aUser.userId]  ];
//    for (int i=0; i<[glycoDataArray count]; i++) {
//        NSRange range=[[glycoDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [glycoArray addObject:[glycoDataArray objectAtIndex:i]];
//            
//        }
//    }
    [medArray removeAllObjects];
    medDataArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getMedicineData:aUser.userId] ];
    for (int i=0; i<[medDataArray count]; i++) {
        NSRange range=[[medDataArray objectAtIndex:i] rangeOfString:currentDate];
        if (range.location==NSNotFound) {
            
        }
        else
        {
            [medArray addObject:[medDataArray objectAtIndex:i]];
            
        }
    }
    [logTable reloadData];
    NSLog(@"Weight : %@ ",weightArray);
    NSLog(@"Glucose : %@ ",glucoseArray);
    NSLog(@"Hemoglobin : %@ ",hgArray);
    NSLog(@"sys : %@ ",sysArray);
    NSLog(@"Dia : %@",bpDiasArray);
    NSLog(@"Pulse : %@ ",pulseArray);
    NSLog(@"Hemoglobin : %@ ",hgArray);
    NSLog(@"glyco : %@ ",glycoArray);
    NSLog(@"Medical List: %@",medArray);
}


-(void)AllMethod
{
    flag=@"2";
    date.text=@"Date Time";
   // [time setTextAlignment:NSTextAlignmentRight];
    time.text=@"Type";

    value.text=@"Value";
    NSDate *picker_date= [NSDate date];
    NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
    [dateformator setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate=[dateformator stringFromDate:picker_date];
    [dateformator setDateFormat:@" HH:mm:ss"];
    NSString *currentTime=[dateformator stringFromDate:picker_date];
    NSLog(@"today is.......%@\n",currentDate); //show Date MM/dd/yyyy HH:mm:ss format.
    NSLog(@"today is.......%@\n",currentTime);
    
    [weightArray removeAllObjects];
    [glucoseArray removeAllObjects];
    [sysArray removeAllObjects];
    [bpDiasArray removeAllObjects];
    [pulseArray removeAllObjects];
    [hgArray removeAllObjects];
    [glycoArray removeAllObjects];
    [medArray removeAllObjects];
    
    weightArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations AllLogs:aUser.userId]];
//    for (int i=0; i<[dataArray count]; i++) {
//        NSRange range=[[dataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [weightArray addObject:[dataArray objectAtIndex:i]];
//            
//        }
//    }
    
  //  glucoseArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BG" :aUser.userId]  ];
//    for (int i=0; i<[glucoseDataArray count]; i++) {
//        NSRange range=[[glucoseDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [glucoseArray addObject:[glucoseDataArray objectAtIndex:i]];
//            
//        }
//    }
    
   // sysArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BPsys" :aUser.userId]  ];
//    for (int i=0; i<[sysDataArray count]; i++) {
//        NSRange range=[[sysDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [sysArray addObject:[sysDataArray objectAtIndex:i]];
//            
//        }
//    }
  //  bpDiasArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"BPdia" :aUser.userId]  ];
//    for (int i=0; i<[diaDataArray count]; i++) {
//        NSRange range=[[diaDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [bpDiasArray addObject:[diaDataArray objectAtIndex:i]];
//            
//        }
//    }
  //  pulseArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"pulse" :aUser.userId]  ];
//    for (int i=0; i<[pulseDataArray count]; i++) {
//        NSRange range=[[pulseDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [pulseArray addObject:[pulseDataArray objectAtIndex:i]];
//            
//        }
//    }
    
    
    
 //   hgArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"HG" :aUser.userId]  ];
//    for (int i=0; i<[hemoDataArray count]; i++) {
//        NSRange range=[[hemoDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [hgArray addObject:[hemoDataArray objectAtIndex:i]];
//            
//        }
//    }
    
  //  glycoArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"HBA1C" :aUser.userId]  ];
//    for (int i=0; i<[glycoDataArray count]; i++) {
//        NSRange range=[[glycoDataArray objectAtIndex:i] rangeOfString:currentDate];
//        if (range.location==NSNotFound) {
//            
//        }
//        else
//        {
//            [glycoArray addObject:[glycoDataArray objectAtIndex:i]];
//            
//        }
//    }
    medArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getMedicineData:aUser.userId] ];

    NSLog(@"Weight : %@ ",weightArray);
//    NSLog(@"Glucose : %@ ",glucoseArray);
//    NSLog(@"Hemoglobin : %@ ",hgArray);
//    NSLog(@"sys : %@ ",sysArray);
//    NSLog(@"Dia : %@",bpDiasArray);
//    NSLog(@"Pulse : %@ ",pulseArray);
//    NSLog(@"Hemoglobin : %@ ",hgArray);
//    NSLog(@"glyco : %@ ",glycoArray);
//    NSLog(@"Medical List : %@ ",medArray);
    [logTable reloadData];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
        return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0)
        return [weightArray count];
    else if (section==1)
            return [medArray count];
  
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if ([flag isEqualToString:@"1"])
//    {
//    if (section==0)
//    {
//        if ([weightArray count]>0)
//        return @"Weight";
//        if ([weightArray count]==0)
//            return @"";
//    }
//    else if (section==1)
//    {
//        if ([glucoseArray count]>0)
//        return @"Glucose";
//        if ([glucoseArray count]==0)
//            return @"";
//    }
//    else if (section==2)
//    {
//        if ([sysArray count]>0)
//        return @"BloodPressure";
//        if ([sysArray count]==0)
//            return @"";
//    }
//       else if (section==3)
//    {
//        if ([hgArray count]>0)
//        return @"Hemoglobin";
//        if ([hgArray count]==0)
//            return @"";
//    }
//    else if (section==4)
//    {
//        if ([glycoArray count]>0)
//        return @"GlycoHemoglobin";
//        if ([glycoArray count]==0)
//            return @"";
//    }
//    else if (section==5)
//    {
//        if ([medArray count]>0)
//            return @"Medical";
//        if ([medArray count]==0)
//            return @"";
//    }
//    }
    return @"";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [logTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    if (indexPath.section==0) {
        
        
        
        cell.textLabel.text=[weightArray objectAtIndex:indexPath.row];
        NSLog(@"text  %@",cell.textLabel.text);
    }
    else if (indexPath.section==0) {
        
        
        
        cell.textLabel.text=[medArray objectAtIndex:indexPath.row];
        NSLog(@"text  %@",cell.textLabel.text);
    }

    
//    if (indexPath.section==1) {
//        
//        
//        cell.textLabel.text=[glucoseArray objectAtIndex:indexPath.row];
//        
//    }
//    if (indexPath.section==2) {
//        
//        
//        cell.textLabel.text=[sysArray objectAtIndex:indexPath.row];
//        NSLog(@"text  %@",cell.textLabel.text);
//    }
//     if (indexPath.section==3) {
//        
//        
//        cell.textLabel.text=[hgArray objectAtIndex:indexPath.row];
//        NSLog(@"text  %@",cell.textLabel.text);
//        
//          }
//    if (indexPath.section==4) {
//        
//        
//        cell.textLabel.text=[glycoArray objectAtIndex:indexPath.row];
//        NSLog(@"text  %@",cell.textLabel.text);
//        
//         }
    if (indexPath.section==1) {
        
        
        cell.textLabel.text=[medArray objectAtIndex:indexPath.row];
        NSLog(@"text  %@",cell.textLabel.text);
        
    }
    
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
