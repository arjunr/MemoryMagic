    //
//  LevelOneController.m
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//#import "MemoryGameAppDelegate.h"
#import "LevelOneController.h"
#import "LevelTwoController.h"
#import "GameLostController.h"
#import "MarkingScheme.h"
#include <stdlib.h>
#import <AudioToolbox/AudioToolbox.h>
#define maxCount 15
#define delay 0.8
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define shakeCount 4
#define shakeDuration 0.11

@implementation LevelOneController

@synthesize button11;
@synthesize button12;
@synthesize button13;
@synthesize button21;
@synthesize button22;
@synthesize button23;
@synthesize button31;
@synthesize button32;
@synthesize button33;

@synthesize finishButton;
@synthesize startButton;
@synthesize countLabel;
@synthesize restartButton;
@synthesize exitButton;
@synthesize notification;


static int v11=0, v12=0, v13=0, v21=0, v22=0, v23=0, v31=0, v32=0, v33=0;
static int count=0,prevVal=0,curVal=0,prevIndex=0,curIndex=0;
static int wins=0;	

-(BOOL)canBecomeFirstResponder{
	return YES;
}



// check if all block-pairs are opened

-(IBAction)finish
{
	// goes to next level
//	[MarkingScheme sharedScore].marks = [MarkingScheme sharedScore].marks + ((maxCount-count)*5);
	NSLog(@"inside finish..!!");

	//score=score+((maxCount-count)*5);
	m=m+((maxCount-count)*5);
	NSLog(@"%d",m);
	
	if(wins==4)
	{
	LevelTwoController *viewController = [[LevelTwoController alloc]initWithNibName:@"LevelTwo" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
	}
	
}

-(IBAction)exitApp:(id)sender
{
	exit(0);
}


-(IBAction)start:(id)sender
{
	// initializing values
	//startButton.enabled=NO;
	
	[self restart:nil];
	
	
		
	
	NSLog(@"Initializing values of the blocks - Level 1");
	
	v11 = arc4random() % 5;
	v23=v11;
	
	v12 = arc4random() % 5;
	v31=v12;
	
	v13 = arc4random() % 5;
	v21=v13;
	
	v22 = arc4random() % 5;
	v33=v22;
	
	// enabling all buttons to start the game
	
	button11.enabled=YES;
	button12.enabled=YES;
	button13.enabled=YES;
	button21.enabled=YES;
	button22.enabled=YES;
	button23.enabled=YES;
	button31.enabled=YES;
	button32.enabled=YES;
	button33.enabled=YES;
	notification.text=0;
	
} 

-(IBAction)restart:(id)sender
{
	NSLog(@"Restart button pressed..!!");
	UIImage *defaultImage = [UIImage imageNamed:@"color0"];
	
	[button11 setImage:defaultImage forState:UIControlStateNormal];
	[button12 setImage:defaultImage forState:UIControlStateNormal];
	[button13 setImage:defaultImage forState:UIControlStateNormal];
	[button21 setImage:defaultImage forState:UIControlStateNormal];
	[button22 setImage:defaultImage forState:UIControlStateNormal];
	[button23 setImage:defaultImage forState:UIControlStateNormal];
	[button31 setImage:defaultImage forState:UIControlStateNormal];
	[button32 setImage:defaultImage forState:UIControlStateNormal];
	[button33 setImage:defaultImage forState:UIControlStateNormal];


	
	count=0;
	wins=0;
	
	countLabel.text=@"0";

	//[self start:nil];

}


-(IBAction)doButton11:(id)sender
{
	
	curIndex=11;
	UIButton *cur1 = (UIButton*)[self.view viewWithTag:curIndex];
	
	
	NSLog(@"Button11 Clicked..");
	//NSString *val11=[NSString stringWithFormat:@"%d",v11];
	NSString *val11=[NSString stringWithFormat:@"img%d",v11];
	UIImage *name=[UIImage imageNamed:val11];
	
	//UIImage *name=[photoNames objectAtIndex:v11];
	
		
	if(count > maxCount )
	{
		//score=10;
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		cur1.enabled=NO;
		NSLog(@"animation 1");
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur1 cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
	//	[cur1 setTitle:val11 forState:UIControlStateNormal];
		[cur1 setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v11;
			prevIndex=11;
		}
		else
		{
			curVal=v11;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)check
{
	UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
	UIButton *btn = (UIButton*)[self.view viewWithTag:prevIndex];
	UIImage *defaultImage = [UIImage imageNamed:@"color0"];
	
	if(prevVal == curVal )
	{
		wins=wins+1;
		cur.backgroundColor=[UIColor redColor];
		btn.backgroundColor=[UIColor redColor];
		
		// adding alert sound
		
		SystemSoundID soundID;
		NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"button-15" ofType:@"wav"];
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
		AudioServicesPlaySystemSound(soundID);
		[soundFile release];
	}
	else
	{
		cur.enabled=YES;
		//cur1.hidden=YES;
		
		[UIView beginAnimations:nil context:NULL];
		//[UIView setAnimationDelay:1.0];
		NSLog(@"animation2");
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setImage:defaultImage forState:UIControlStateNormal];
		[cur setTitle:@"*" forState:UIControlStateNormal];
		[UIView commitAnimations];	
		
		btn.enabled=YES;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:btn cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[btn setImage:defaultImage forState:UIControlStateNormal];
		[btn setTitle:@"*" forState:UIControlStateNormal];
		
		[UIView commitAnimations];
		
	} // end of ==
	prevIndex=0;
	curIndex=0;
	
	if(wins == 4)
	{
		NSLog(@"inside..!!");
		[self performSelector :@selector(finish)
				   withObject :nil
				   afterDelay :0.5];
	}
}

-(IBAction)doButton12:(id)sender
{
	
	NSLog(@"Button12 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v12];
	curIndex=12;
	UIImage *name=[UIImage imageNamed:val11];

	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setImage:name forState:UIControlStateNormal];
		[cur setTitle:val11 forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c12=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c12;
		
		if(count%2==1)
		{
			prevVal=v12;
			prevIndex=12;
		}
		else
		{
			curVal=v12;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)doButton13:(id)sender
{
	
	NSLog(@"Button13 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v13];
	curIndex=13;
	UIImage *name=[UIImage imageNamed:val11];

	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v13;
			prevIndex=13;
		}
		else
		{
			curVal=v13;
			
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)doButton21:(id)sender
{
	
	NSLog(@"Button21 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v21];
	curIndex=21;
	UIImage *name=[UIImage imageNamed:val11];

	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v21;
			prevIndex=21;
		}
		else
		{
			curVal=v21;
			
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(IBAction)doButton22:(id)sender
{
	
	NSLog(@"Button22 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v22];
	curIndex=22;
	UIImage *name=[UIImage imageNamed:val11];

	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v22;
			prevIndex=22;
		}
		else
		{
			curVal=v22;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(IBAction)doButton23:(id)sender
{
	
	NSLog(@"Button23 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v23];
	curIndex=23;
	UIImage *name=[UIImage imageNamed:val11];

	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v23;
			prevIndex=23;
		}
		else
		{
			curVal=v23;
			
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(IBAction)doButton31:(id)sender
{
	
	NSLog(@"Button31 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v31];
	curIndex=31;
	UIImage *name=[UIImage imageNamed:val11];

	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v31;
			prevIndex=31;
		}
		else
		{
			curVal=v31;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(IBAction)doButton32:(id)sender
{
	
	NSLog(@"Button32 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v32];
	curIndex=32;
	UIImage *name=[UIImage imageNamed:val11];

	
	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v32;
			prevIndex=32;
		}
		else
		{
			curVal=v32;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(IBAction)doButton33:(id)sender
{
	
	NSLog(@"Button33 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"img%d",v33];
	curIndex=33;
	UIImage *name=[UIImage imageNamed:val11];

	
	if(count > maxCount )
	{
		NSLog(@"Maximum touches reached..!!");
		GameLostController *viewController = [[GameLostController alloc]initWithNibName:@"GameLost" bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
		
	}
	else 
	{
		UIButton *cur = (UIButton*)[self.view viewWithTag:curIndex];
		
		
		cur.enabled=NO;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v33;
			prevIndex=33;
		}
		else
		{
			curVal=v33;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void) wobbleEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
	if ([finished boolValue]) {
        UIView* item = (UIView *)context;
        item.transform = CGAffineTransformIdentity;
		[self start:nil];
	}
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake)
	{	SystemSoundID soundID;
		NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"alien_28" ofType:@"wav"];
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
		AudioServicesPlaySystemSound(soundID);
		[soundFile release];
		
		CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-1.50));
		CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(0.0));
		
		button11.transform = leftWobble;  // starting point
		button12.transform = leftWobble;  // starting point
		button13.transform = leftWobble;  // starting point
		button21.transform = leftWobble;  // starting point
		button22.transform = leftWobble;  // starting point
		button23.transform = leftWobble;  // starting point
		button31.transform = leftWobble;  // starting point
		button32.transform = leftWobble;  // starting point
		button33.transform = leftWobble;  // starting point
		
		[UIView beginAnimations:@"wobble" context:nil];
		[UIView setAnimationRepeatAutoreverses:YES]; // important
		[UIView setAnimationRepeatCount:shakeCount];
		[UIView setAnimationDuration:shakeDuration];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(wobbleEnded:finished:context:)];
		// [UIView setAnimationDidStopSelector:@selector(start:)];

		button11.transform = rightWobble; // end here & auto-reverse
		button12.transform = rightWobble; // end here & auto-reverse
		button13.transform = rightWobble; // end here & auto-reverse
		button21.transform = rightWobble; // end here & auto-reverse
		button22.transform = rightWobble; // end here & auto-reverse
		button23.transform = rightWobble; // end here & auto-reverse
		button31.transform = rightWobble; // end here & auto-reverse
		button32.transform = rightWobble; // end here & auto-reverse
		button33.transform = rightWobble; // end here & auto-reverse
		
		
		[UIView commitAnimations];
		//[self start:nil];
	}
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"level one";
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// disabling buttons before START is pressed..
	
	button11.enabled=NO;
	button12.enabled=NO;
	button13.enabled=NO;
	button21.enabled=NO;
	button22.enabled=NO;
	button23.enabled=NO;
	button31.enabled=NO;
	button32.enabled=NO;
	button33.enabled=NO;
	
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
/*
- (void)viewWillAppear:(BOOL)animated
{
	
    BarContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
	[BarContainerView addSubview:button11];
	[self.view addSubview:BarContainerView];
	[self.view bringSubviewToFront:BarContainerView];
}	
*/
@end
