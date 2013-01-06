//
//  classLanguage.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 16/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classLanguage.h"
#import "classUser.h"
#import "classAudio.h"
#import "classDatabaseOperations.h"

@implementation classLanguage

@synthesize swhGujarati,swhEnglish,swhAudioSat,swhMarathi;
@synthesize objUser;
@synthesize myAudioPlayer;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    self.title=@"AudioStatus";
    
    
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
      self.title=@"Audio Settings";
    [super viewDidLoad];
    [[self tableView] setBackgroundView:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]autorelease]];

    if(objUser.audioStatus==YES)
    { 
        if(objUser.language==1)
        {
            
            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"audioStatus", nil];
            [self.myAudioPlayer playAudios:array];
            [array release];
        }
    else if(objUser.language==2)
    {
        
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"12", nil];
        [self.myAudioPlayer playAudios:array];
       [array release];
        
        
        
    }
        
    }

    
       
    self.swhGujarati=[[[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 94, 30)]autorelease];
    //swhSpaish.on=NO;
    [self.swhGujarati addTarget:self action:@selector(GujaratiOnOffAudio:) forControlEvents:UIControlEventValueChanged];

    self.swhEnglish=[[[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 94, 30)]autorelease];
    //swhEnglish.on=YES;
    [self.swhEnglish addTarget:self action:@selector(englishOnOffAudio:) forControlEvents:UIControlEventValueChanged];
    self.swhAudioSat=[[[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 94, 30)]autorelease];
    [self.swhAudioSat addTarget:self action:@selector(trunOnOffAudio:) forControlEvents:UIControlEventValueChanged];
    [self getAudioStatus];
    [self getLangStatus];

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    if (indexPath.section==0) {
    
        cell.textLabel.text=@"Audio";
        
        [cell.contentView addSubview:self.swhAudioSat];
    }
    
    if (indexPath.section==01) {
        
        cell.textLabel.text=@"English Voice";
        
        [cell.contentView addSubview:self.swhEnglish];
    }
    
    if (indexPath.section==2) {
        
        cell.textLabel.text=@"Marathi Voice";
        
        [cell.contentView addSubview:self.swhGujarati];
    }

    cell.accessoryType=UITableViewCellAccessoryNone;    
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

-(void)trunOnOffAudio:(id)sender
{
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    UISwitch* notificationSwitch=sender;
    
    if(notificationSwitch.on==YES)
    {
        //  set value "on" for notificationStatus in userDefauts 
        [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"audioStatus%d",objUser.userId]];
        [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];

        self.objUser.audioStatus=YES;
        {
            if(objUser.language==1)
            {
            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"audioTurnedOn", nil];
            [self.myAudioPlayer playAudios:array];
            [array release];
            }
            else if(objUser.language==2 )
            {
                
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"38", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
            }
                
            
        }
        
    }
    else if(notificationSwitch.on==NO)
        
    {
        // also set value on for notificationStatus in userDefauts 
        [userDefaults setObject:@"off" forKey:[NSString stringWithFormat:@"audioStatus%d",objUser.userId]];
        
        
        self.objUser.audioStatus=NO;
        {
            if(objUser.language==1)
            {
            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"audioTurnedOff", nil];
            [self.myAudioPlayer playAudios:array];
            [array release];
            }
            else if(objUser.language==2 )
            {
                
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"36", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
            }

        }
        
    }
}         




-(void)GujaratiOnOffAudio:(id)sender
{
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];

    UISwitch* notificationSwitch=sender;
    if(notificationSwitch.on==YES)
    {
        objUser.language=2;
        swhEnglish.on=NO;
        
        NSString *query=[NSString stringWithFormat:@"update user set audiosatus=2 where userid=%d",objUser.userId];
        int lang=[classDatabaseOperations add:query];
         NSLog(@"Engon%d",lang);

        [userDefaults setObject:@"2" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        if(objUser.audioStatus==YES)      {
                       
                
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"38", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
        
        }
        
    }
    else if(notificationSwitch.on==NO)
    {
          swhEnglish.on=YES;
        [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        objUser.language=1;

       if(objUser.audioStatus==YES)        {
            
                
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"ispeakenglish", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
            
            
        }

        
    }
    
    
    
    
}

-(void)englishOnOffAudio:(id)sender
{
    
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    UISwitch* notificationSwitch=sender;
    if(notificationSwitch.on==YES)
    {
        
        swhGujarati.on=NO;
        objUser.language=1;
        
        NSString *query=[NSString stringWithFormat:@"update user set audiosatus=1 where userid=%d",objUser.userId];
        int lang=[classDatabaseOperations add:query];
        NSLog(@"Engon%d",lang);
        [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        NSString *str=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        NSLog(@"%@",str);
        NSMutableArray *array=[[NSMutableArray alloc]init];

       if(objUser.audioStatus==YES)
        {
            
            [array addObject:@"ispeakenglish"];
            
                [self.myAudioPlayer playAudios:array];
            
            
        }

        [array release];
  
        
    }
    else if(notificationSwitch.on==NO)
    {
        swhGujarati.on=YES;
        objUser.language=2;
      
        [userDefaults setObject:@"2" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        NSString *str=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        NSLog(@"%@",str);
          if(objUser.audioStatus==YES)
        {
            
                
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"38", nil];
                [self.myAudioPlayer playAudios:array];
            [array release];

            
        }
        

        
    }


    
    
}



-(NSString *)getAudioStatus
{
    
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults]; 
    
    // get current status of notification, current notification can be nil or either on or off
    NSString * audioStatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",objUser.userId]];  
    
    if([audioStatus isEqualToString:@"on"] || audioStatus ==nil )
    {
        self.swhAudioSat.on=YES;
        
        if(audioStatus ==nil)// in case if audio status is  not already set, set it to on
        {
            
            [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"audioStatus%d",objUser.userId]];
            
        }
        
        
        
        
        return @"On";
    }
    
    
    else  if([audioStatus isEqualToString:@"off"])
        
    {
        
        self.swhAudioSat.on=NO;
        
    }
    
    
    
    return @"Off" ;
    
}
-(void)getLangStatus
{
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults]; 

    NSString * langSelected=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
  
    
    
      if([langSelected isEqualToString:@"1"]|| langSelected ==nil)
    {
        
        self.swhEnglish.on=YES;
        if(langSelected ==nil)// in case if audio status is  not already set, set it to on
        {
            self.swhEnglish.on=YES;


      //  [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        
        }
        
        
        
    }
    else if([langSelected isEqualToString:@"2"])
    {
        
        self.swhGujarati.on=YES;
        
       // [userDefaults setObject:@"2" forKey:[NSString stringWithFormat:@"languageselected%d",objUser.userId]];
        
        
        
        
    }

}


@end
