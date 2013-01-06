//
//  loadingPage.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 2/22/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "loadingPage.h"

@implementation loadingPage


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
}


-(void)showSplash
{
    UIViewController *modalViewController = [[UIViewController alloc] init];
    modalViewController.view = modelView;
    [self presentModalViewController:modalViewController animated:NO];
    [self performSelector:@selector(hideSplash) withObject:nil afterDelay:1.0];
    [modalViewController release];
}

//hide splash screen
- (void)hideSplash{
    [[self modalViewController] dismissModalViewControllerAnimated:YES];
}


@end
