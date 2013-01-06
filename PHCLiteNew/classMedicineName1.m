//
//  classMedicineName1.m
//  i_StripsPro
//
//  Created by Avi Kulkarni on 7/10/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMedicineName1.h"
#import "classMedicine.h"
#import "classAudio.h"
#import "classUser.h"

@implementation classMedicineName1
@synthesize imgInfo;
@synthesize barBtnCancel;
@synthesize barBtnSearch;
@synthesize btnBarDone;
@synthesize txtMedicineName;
@synthesize webViewMedicineInfo;
@synthesize barBtnnext;
@synthesize barBtnBack;
@synthesize objMedicine;

@synthesize myAudioPlayer;
@synthesize objUser;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        

    }
    return self;
}

- (void)dealloc
{
    [barBtnCancel release];
    [barBtnSearch release];
    [btnBarDone release];
    [txtMedicineName release];
    [webViewMedicineInfo release];
    [barBtnnext release];
    [barBtnBack release];
    [imgInfo release];
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
 
    
    
    //set medicine name if already exist
    self.txtMedicineName.text=self.objMedicine.medicineName;
    
    [self playAudio];
}

- (void)viewDidUnload
{
    [self setBarBtnCancel:nil];
    [self setBarBtnSearch:nil];
    [self setBtnBarDone:nil];
    [self setTxtMedicineName:nil];
    [self setWebViewMedicineInfo:nil];
    [self setBarBtnnext:nil];
    [self setBarBtnBack:nil];
    [self setImgInfo:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cencel:(id)sender 
{
    [self.txtMedicineName resignFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)search:(id)sender
{
 // array to hold sound file names
    NSMutableArray * array=[[NSMutableArray alloc] init];

    
    // hide keyboard
    [self.txtMedicineName resignFirstResponder];
    
    
    self.txtMedicineName.text=[ self.txtMedicineName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];    
    if([ self.txtMedicineName.text length]>=3)
    {
        
        NSString *urlAddress =[NSString stringWithFormat:@"http://en.m.wikipedia.org/wiki?search=%@", self.txtMedicineName.text];
        
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
        
        
        //Load the request in the UIWebView.
        [self.webViewMedicineInfo loadRequest:requestObj];
        
        [array addObject:@"searching"];
        if(objUser.audioStatus==YES)
        {

        [myAudioPlayer playAudios:array ];
        }        
        
    }
    else
    {
        
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Search term needs to be at least 3 characters in length." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
                
    }
    
    [array release];

}

- (IBAction)done:(id)sender
{
    
    // hide keyboard
    [self.txtMedicineName resignFirstResponder];
    
    // validate medicine name and save in objMedicine
    if([self validate:txtMedicineName.text])
    {
       self.objMedicine.medicineName=self.txtMedicineName.text;
       [self dismissModalViewControllerAnimated:YES];
        
        
    }
    else
    {
        [self playAudio];        
    }
    
}

-(BOOL)validate:(NSString*)value
{
    
   if(value!=nil && [value length]!=0)
   {
       
       return YES;
       
   }
    
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Invalid Medicine name" message:@"Please enter valid medicine name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    return NO;
}


- (IBAction)next:(id)sender
{
    // hide keyboard
    [self.txtMedicineName resignFirstResponder];

    [self.webViewMedicineInfo goForward];
}

- (IBAction)back:(id)sender 
{
    // hide keyboard
    [self.txtMedicineName resignFirstResponder];

    [self.webViewMedicineInfo goBack];

    
}


// web view delegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
    //start activiti indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.view.userInteractionEnabled=NO;
    
    UIView * viewWithActIndicator=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    viewWithActIndicator.tag=100;
    viewWithActIndicator.alpha=0.5f;
    viewWithActIndicator.backgroundColor=[UIColor blackColor];
    
    UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 256, 37, 37)];        
    indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    [indicator startAnimating];
    [viewWithActIndicator addSubview:indicator];
    
    [indicator release];
    
    UILabel * lblLoading=[[UILabel alloc] initWithFrame:CGRectMake(143, 291, 80, 21)];
    lblLoading.text=@"Loading...";
    lblLoading.font=[UIFont fontWithName:@"Futura" size:14.0f];
    lblLoading.textColor=[UIColor whiteColor];
    lblLoading.backgroundColor=[UIColor clearColor];
    
    [viewWithActIndicator addSubview:lblLoading];
    [lblLoading release];
    
    [self.view addSubview:viewWithActIndicator];
    [viewWithActIndicator release];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //stop activity indicator
    imgInfo.hidden=YES;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.view.userInteractionEnabled=YES;
    
    UIView * myview=[self.view viewWithTag:100];
    [myview removeFromSuperview];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    // remove the activity indicator 
    UIView * myview=[self.view viewWithTag:100];
    [myview removeFromSuperview];
    
    //stop activity indicator and show alert message with erro message
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertView *alerterror=[[UIAlertView alloc]initWithTitle:@"Unable to connect to internet" message:@"Please try again later."delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];	
	[alerterror show];	
	[alerterror release];
    
    self.view.userInteractionEnabled=YES;
    
}

-(void)playAudio
{
    
    if(objUser.audioStatus==YES)
    {
//if(objUser.language==1)
//{
    NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"pleaseEnterMedicineName", nil];
    [myAudioPlayer playAudios:array];
    [array release];
//}
//        else if(objUser.language==2)
//        {
//            
//            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2EnterMedName", nil];
//            [myAudioPlayer playAudios:array];
//            [array release];
//
//            
//            
//        }
            
  
    }
    
}



@end
