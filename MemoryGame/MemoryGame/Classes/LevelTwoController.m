    //
//  LevelTwoController.m
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelTwoController.h"
#import "GameLostController.h"
#import "LevelThreeController.h"
#import "MarkingScheme.h"
#include <stdlib.h>
#import <AudioToolbox/AudioToolbox.h>

#define maxCount 25
#define delay 1.0
#define dur 0.4
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define shakeCount 4
#define shakeDuration 0.11


@implementation LevelTwoController

@synthesize button11;
@synthesize button12;
@synthesize button13;
@synthesize button14;
@synthesize button21;
@synthesize button22;
@synthesize button23;
@synthesize button24;
@synthesize button31;
@synthesize button32;
@synthesize button33;
@synthesize button34;
@synthesize button41;
@synthesize button42;
@synthesize button43;
@synthesize button44;

@synthesize finishButton;
@synthesize startButton;
@synthesize countLabel;
@synthesize restartButton;
@synthesize exitButton;
@synthesize notification;


static int v11=0, v12=0, v13=0,v14=0, v21=0, v22=0, v23=0,v24=0, v31=0, v32=0, v33=0,v34=0,v41=0,v42=0,v43=0,v44=0;
static int count=0,prevVal=0,curVal=0,prevIndex=0,curIndex=0;
static int wins=0;										// check if all block-pairs are opened

-(IBAction)finish
{
	// goes to next level
	
	//score=score+((maxCount-count)*5);
	m=m+((maxCount-count)*5);

//	[MarkingScheme sharedScore].marks = [MarkingScheme sharedScore].marks + ((maxCount-count)*5);

	
	if(wins==8)
	{
		LevelThreeController *viewController = [[LevelThreeController alloc]initWithNibName:@"LevelThree" bundle:nil];
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
	[self restart:nil];

	
	NSLog(@"Initializing values of the blocks - Level 1");
	
	v11 = arc4random() % 9;
	v23=v11;
	
	v12 = arc4random() % 9;
	v44=v12;
	
	v13 = arc4random() % 9;
	v21=v13;
	
	v14 = arc4random() % 9;
	v33=v14;
	
	v22 = arc4random() % 9;
	v43=v22;
	
	v24 = arc4random() % 9;
	v32=v24;
	
	v31 = arc4random() % 9;
	v42=v31;
	
	v34 = arc4random() % 9;
	v41=v34;
	
	// enabling all buttons to start the game
	
	button11.enabled=YES;
	button12.enabled=YES;
	button13.enabled=YES;
	button14.enabled=YES;
	button21.enabled=YES;
	button22.enabled=YES;
	button23.enabled=YES;
	button24.enabled=YES;
	button31.enabled=YES;
	button32.enabled=YES;
	button33.enabled=YES;
	button34.enabled=YES;
	button41.enabled=YES;
	button42.enabled=YES;
	button43.enabled=YES;
	button44.enabled=YES;
	
	notification.text=0;
	
} 

-(IBAction)restart:(id)sender
{
	NSLog(@"Restart button pressed..!!");
	UIImage *defaultImage = [UIImage imageNamed:@"color0"];
	
	[button11 setImage:defaultImage forState:UIControlStateNormal];
	[button12 setImage:defaultImage forState:UIControlStateNormal];
	[button13 setImage:defaultImage forState:UIControlStateNormal];
	[button14 setImage:defaultImage forState:UIControlStateNormal];
	[button21 setImage:defaultImage forState:UIControlStateNormal];
	[button22 setImage:defaultImage forState:UIControlStateNormal];
	[button23 setImage:defaultImage forState:UIControlStateNormal];
	[button24 setImage:defaultImage forState:UIControlStateNormal];
	[button31 setImage:defaultImage forState:UIControlStateNormal];
	[button32 setImage:defaultImage forState:UIControlStateNormal];
	[button33 setImage:defaultImage forState:UIControlStateNormal];
	[button34 setImage:defaultImage forState:UIControlStateNormal];
	[button41 setImage:defaultImage forState:UIControlStateNormal];
	[button42 setImage:defaultImage forState:UIControlStateNormal];
	[button43 setImage:defaultImage forState:UIControlStateNormal];
	[button44 setImage:defaultImage forState:UIControlStateNormal];
	
	count=0;
	wins=0;
	
	countLabel.text=@"0";
	
	
}


-(IBAction)doButton11:(id)sender
{
	
	curIndex=11;
	UIButton *cur1 = (UIButton*)[self.view viewWithTag:curIndex];
	
	
	NSLog(@"Button11 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v11];
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
		
		cur1.enabled=NO;
		NSLog(@"animation 1");
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur1 cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur1 setTitle:val11 forState:UIControlStateNormal];
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:@"*" forState:UIControlStateNormal];
		[cur setImage:defaultImage forState:UIControlStateNormal];

		[UIView commitAnimations];	
		
		btn.enabled=YES;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:btn cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[btn setTitle:@"*" forState:UIControlStateNormal];
		[btn setImage:defaultImage forState:UIControlStateNormal];

		[UIView commitAnimations];
		
	} // end of ==
	prevIndex=0;
	curIndex=0;
	
	if(wins == 8)
	{
		[self performSelector :@selector(finish)
				   withObject :nil
				   afterDelay :0.5];
	}
	
}

-(IBAction)doButton12:(id)sender
{
	
	NSLog(@"Button12 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v12];
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
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
	NSString *val11=[NSString stringWithFormat:@"level2%d",v13];
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
		[UIView setAnimationDuration:dur];
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

-(IBAction)doButton14:(id)sender
{
	
	NSLog(@"Button14 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v14];
	curIndex=14;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v14;
			prevIndex=14;
		}
		else
		{
			curVal=v14;
			
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)doButton21:(id)sender
{
	
	NSLog(@"Button21 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v21];
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
		[UIView setAnimationDuration:dur];
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
	NSString *val11=[NSString stringWithFormat:@"level2%d",v22];
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
		[UIView setAnimationDuration:dur];
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
	NSString *val11=[NSString stringWithFormat:@"level2%d",v23];
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
		[UIView setAnimationDuration:dur];
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

-(IBAction)doButton24:(id)sender
{
	
	NSLog(@"Button24 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v24];
	curIndex=24;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v24;
			prevIndex=24;
		}
		else
		{
			curVal=v24;
			
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)doButton31:(id)sender
{
	
	NSLog(@"Button31 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v31];
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
		[UIView setAnimationDuration:dur];
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
	NSString *val11=[NSString stringWithFormat:@"level2%d",v32];
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
		[UIView setAnimationDuration:dur];
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
	NSString *val11=[NSString stringWithFormat:@"level2%d",v33];
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
		[UIView setAnimationDuration:dur];
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

-(IBAction)doButton34:(id)sender
{
	
	NSLog(@"Button34 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v34];
	curIndex=34;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v34;
			prevIndex=34;
		}
		else
		{
			curVal=v34;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)doButton41:(id)sender
{
	
	NSLog(@"Button41 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v41];
	curIndex=41;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v41;
			prevIndex=41;
		}
		else
		{
			curVal=v41;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
		} // end of %
		
	}
	
}

-(IBAction)doButton42:(id)sender
{
	
	NSLog(@"Button42 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v42];
	curIndex=42;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v42;
			prevIndex=42;
		}
		else
		{
			curVal=v42;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}

-(IBAction)doButton43:(id)sender
{
	
	NSLog(@"Button43 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v43];
	curIndex=43;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v43;
			prevIndex=43;
		}
		else
		{
			curVal=v43;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
			
		} // end of %
		
	}
	
}

-(IBAction)doButton44:(id)sender
{
	
	NSLog(@"Button13 Clicked..");
	NSString *val11=[NSString stringWithFormat:@"level2%d",v44];
	curIndex=44;
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
		[UIView setAnimationDuration:dur];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cur cache:NO]; //the built in UIViewAnimationTransition values don't provide enough flexibility
		[cur setTitle:val11 forState:UIControlStateNormal];
		[cur setImage:name forState:UIControlStateNormal];
		[UIView commitAnimations];
		count=count+1;
		NSString *c11=[NSString stringWithFormat:@"%d",count];
		countLabel.text=c11;
		
		if(count%2==1)
		{
			prevVal=v44;
			prevIndex=44;
		}
		else
		{
			curVal=v44;
			[self performSelector :@selector(check)
					   withObject :nil
					   afterDelay :delay];
			
		} // end of %
		
	}
	
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title=@"Level Two";
    }
    return self;
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
	{
		SystemSoundID soundID;
		NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"alien_28" ofType:@"wav"];
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
		AudioServicesPlaySystemSound(soundID);
		[soundFile release];
		
		CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-1.50));
		CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(0.0));
		
		button11.transform = leftWobble;  // starting point
		button12.transform = leftWobble;  // starting point
		button13.transform = leftWobble;  // starting point
		button14.transform = leftWobble;  // starting point
		button21.transform = leftWobble;  // starting point
		button22.transform = leftWobble;  // starting point
		button23.transform = leftWobble;  // starting point
		button24.transform = leftWobble;  // starting point
		button31.transform = leftWobble;  // starting point
		button32.transform = leftWobble;  // starting point
		button33.transform = leftWobble;  // starting point
		button34.transform = leftWobble;  // starting point
		button41.transform = leftWobble;  // starting point
		button42.transform = leftWobble;  // starting point
		button43.transform = leftWobble;  // starting point
		button44.transform = leftWobble;  // starting point
		
		
		
		
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
		button14.transform = rightWobble; // end here & auto-reverse
		button21.transform = rightWobble; // end here & auto-reverse
		button22.transform = rightWobble; // end here & auto-reverse
		button23.transform = rightWobble; // end here & auto-reverse
		button24.transform = rightWobble; // end here & auto-reverse
		button31.transform = rightWobble; // end here & auto-reverse
		button32.transform = rightWobble; // end here & auto-reverse
		button33.transform = rightWobble; // end here & auto-reverse
		button34.transform = rightWobble; // end here & auto-reverse
		button41.transform = rightWobble; // end here & auto-reverse
		button42.transform = rightWobble; // end here & auto-reverse
		button43.transform = rightWobble; // end here & auto-reverse
		button44.transform = rightWobble; // end here & auto-reverse
		
		
		[UIView commitAnimations];
		//[self start:nil];
	}
}


-(BOOL)canBecomeFirstResponder{
	return YES;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	button11.enabled=NO;
	button12.enabled=NO;
	button13.enabled=NO;
	button14.enabled=NO;
	button21.enabled=NO;
	button22.enabled=NO;
	button23.enabled=NO;
	button24.enabled=NO;
	button31.enabled=NO;
	button32.enabled=NO;
	button33.enabled=NO;
	button34.enabled=NO;
	button41.enabled=NO;
	button42.enabled=NO;
	button43.enabled=NO;
	button44.enabled=NO;
	
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
