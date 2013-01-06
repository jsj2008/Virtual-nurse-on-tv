//
//  classDiffTime.m
//  PHCLite_New
//
//  Created by Avi Kulkarni on 06/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classDiffTime.h"
#import "classdailyInf.h"
#import "classWeeklyInfo.h"
#import "classMonthlyDetails.h"

@implementation classDiffTime
@synthesize tableViewNew;
@synthesize SwitchButton;
@synthesize lblName;
@synthesize strName;
@synthesize BtnSwitch;
@synthesize str_Name2;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        array_name=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
        
        BtnSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(190, 10, 70, 50)];
        [BtnSwitch addTarget:self action:@selector(selectSwitchBtn) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void)dealloc
{
   
    [lblName release];
    
    [SwitchButton release];
   
    [tableViewNew release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;
    
    UIBarButtonItem *barSave=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(Save)];
    self.navigationItem.rightBarButtonItem=barSave;
    [barSave release];
    [barCancle release];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        return 1;
    }
  else if (section==1)
   {
       if (BtnSwitch.on==YES)
       {
            return 4;
          
       }
       else
       {
           return 0;
        
       }
       
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 45;
    
    }
    else if(indexPath.section==1)
    {
        return 45;
    
    }
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:17];
     
    if(indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text=strName;
                [cell.contentView addSubview:BtnSwitch];
                break;
        }        
        
    }
    else if(indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:
                 cell.textLabel.text=@"Daily";
                break;
            case 1:
                cell.textLabel.text=@"Weekly";
                break;
            case 2:
                cell.textLabel.text=@"Monthly";
                break;
            case 3:
                cell.textLabel.text=@"Quarterly";
                break;
                
            default:
                break;
        }
    
    }
    
            
    // Configure the cell...
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section==1)
    {
        if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
            
            
        }
        else if(indexPath.row==0)
        {
        
          cell.accessoryType=UITableViewCellAccessoryCheckmark;
            classdailyInf *obj_Time=[[classdailyInf alloc]initWithNibName:@"classdailyInf" bundle:nil];
            UINavigationController * navC=[[UINavigationController alloc]initWithRootViewController:obj_Time];
            // user.delegate=self;
            [self presentModalViewController:navC animated:YES];
            [obj_Time release];
            [navC release];
        }
        else if(indexPath.row==1)
        {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            classWeeklyInfo *obj_Weekly=[[classWeeklyInfo alloc]initWithNibName:@"classWeeklyInfo" bundle:nil];
            UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:obj_Weekly];
            [self presentModalViewController:nav1 animated:YES];
            [obj_Weekly release];
            [nav1 release];

        
        }
        else if(indexPath.row==2)
        {
            classMonthlyDetails *obj_monthly=[[classMonthlyDetails alloc]initWithNibName:@"classMonthlyDetails" bundle:nil];
            UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:obj_monthly];
            [self presentModalViewController:nav1 animated:YES];
            [obj_monthly release];
            [nav1 release];

        
        }
    }
    
}
-(void)Save
{
    [self.navigationController popViewControllerAnimated:YES];
   

}
  // else if (indexPath.section==1)
  //  {
           
        
//               
//        if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
//        {
//            cell.accessoryType=UITableViewCellAccessoryNone;
//            
//            
//        }
//        else
//        {
//            
//            cell.accessoryType=UITableViewCellAccessoryCheckmark;
//            
//        }
//
//        
//            

  
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//      
//    if (indexPath.section==0)
//    {  
//        if (cell.accessoryType==UITableViewCellAccessoryCheckmark)
//        {
//            cell.accessoryType=UITableViewCellAccessoryNone;
//        }
//         else
//         {
//             cell.accessoryType=UITableViewCellAccessoryCheckmark;
//            
//             
//         }
//      
//        
//    }
//    
//}
//



-(void)selectSwitchBtn
{
    if(BtnSwitch.on==YES)
    {
    
        NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:1];
        
        [self.tableViewNew reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
        
    
    }
    else
    {
        NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:1];
        
        [self.tableViewNew reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
     
    }



}

//-(void)cancle
//{
//    [self dismissModalViewControllerAnimated:YES];
//
//}
-(void)cancle
{
    [delegate selectCancle];


}
- (void)viewDidUnload {
    [self setSwitchButton:nil];
   
    [self setTableViewNew:nil];
    [super viewDidUnload];
}
@end
