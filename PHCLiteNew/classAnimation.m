//
//  aniomation.m
//  animation
//
//  Created by Avinash Kulkarni on 3/15/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classAnimation.h"
#import "classAudio.h"

@implementation classAnimation
@synthesize myAudioPlayer;

    
    - (void)viewDidLoad
    {
        [super viewDidLoad];
    
    
     
    stick.animationImages=[NSArray arrayWithObjects:
                           
                           [UIImage  imageNamed:@"nurse.PNG"],
                           [UIImage  imageNamed:@"nurse0.PNG"],
                                                  
                           
                           nil ];
    
   // [stick setAnimationRepeatCount:10];
    
    [stick setAnimationDuration:1.0];
    [stick startAnimating];
        NSMutableArray *array=[[NSMutableArray alloc]init];    
        [array addObject:@"PleaseMesureWeight12"];
        [myAudioPlayer playAudios:array];
        [array release];
       // [stick stopAnimating];     

    
    //stick.image=[UIImage imageNamed:@"stick1.jpg"];
}
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
 // Do any additional setup after loading the view from its nib.
 }
 
 - (void)viewDidUnload
 {
 [super viewDidUnload];
 // Release any retained subviews of the main view.
 // e.g. self.myOutlet = nil;
 }
 
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }*/

@end
