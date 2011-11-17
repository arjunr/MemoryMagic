    //
//  GameOverController.m
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameOverController.h"
#import "MarkingScheme.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation GameOverController

@synthesize postOnFbYes;
@synthesize cancel;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title=@"You Won !";
    }
    return self;
}

-(IBAction)doPostOnFb:(id)sender
{
	NSLog(@"Post on Facebook..!!");
	
	//[Score sharedScore].marks = [Score sharedScore].marks + ((maxCount-count)*5);
	
	//NSLog(@"marks = %@",[MarkingScheme sharedScore].marks);
	NSLog(@"marks = %d",m);
	
	FacebookController *viewController = [[FacebookController alloc]initWithNibName:@"FacebookView" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
	
}

-(IBAction)doCancel:(id)sender
{
	NSLog(@"Cancel clicked..!!");
	exit(0);
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	SystemSoundID soundID;
	NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"applause-2" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
	AudioServicesPlaySystemSound(soundID);
	[soundFile release];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
