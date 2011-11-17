    //
//  FacebookController.m
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookController.h"
#import "FBConnect/FBConnect.h"
#import "MarkingScheme.h"

@implementation FacebookController

@synthesize session = _session;
@synthesize postGradesButton = _postGradesButton;
@synthesize logoutButton = _logoutButton;
@synthesize loginDialog = _loginDialog;
@synthesize facebookName = _facebookName;
@synthesize posting = _posting;
@synthesize exitButton;


- (void)viewDidLoad {
	
	// Set these values from your application page on http://www.facebook.com/developers
	// Keep in mind that this method is not as secure as using the sessionForApplication:getSessionProxy:delegate method!
	// These values are from a dummy facebook app I made called MyGrades - feel free to play around!
	static NSString* kApiKey = @"04f9668d2b2636f1eec752681ff0c41e";
	static NSString* kApiSecret = @"56366ea55dfd0b6459e6f32cbd72848e";
	_session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
	
	// Load a previous session from disk if available.  Note this will call session:didLogin if a valid session exists.
	[_session resume];
	
	[super viewDidLoad];
}

- (IBAction)postGradesTapped:(id)sender {
	_posting = YES;
	NSLog(@"yes");
	// If we're not logged in, log in first...
	if (![_session isConnected]) {
		NSLog(@"not logged..!");
		self.loginDialog = nil;
		_loginDialog = [[FBLoginDialog alloc] init];	
		[_loginDialog show];	
	}
	// If we have a session and a name, post to the wall!
	else if (_facebookName != nil) {
	
	//else {
		NSLog(@"logged in..!");
		[self postToWall];
	}
	// Otherwise, we don't have a name yet, just wait for that to come through.
}

- (IBAction)logoutButtonTapped:(id)sender {
	[_session logout];
}


#pragma mark FBSessionDelegate methods

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	[self getFacebookName];
}

- (void)session:(FBSession*)session willLogout:(FBUID)uid {
	_logoutButton.hidden = YES;
	_facebookName = nil;
}

#pragma mark Get Facebook Name Helper

- (void)getFacebookName {
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name from user where uid == %lld", _session.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
}

#pragma mark FBRequestDelegate methods

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
		self.facebookName = name;		
		_logoutButton.hidden = NO;
		[_logoutButton setTitle:[NSString stringWithFormat:@"Logout: %@", name] forState:UIControlStateNormal];
		if (_posting) {
			[self postToWall];
			_posting = NO;
		}
	}
}

#pragma mark Post to Wall Helper

- (void)postToWall {
	
	NSInteger temp=m;
	NSString *tstring = [NSString stringWithFormat:@"%d",temp];

	FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.userMessagePrompt = @"Enter your message:";
	//dialog.attachment = [NSString stringWithFormat:@"{\"name\":\"%@ got straight A's!\",\"href\":\"http://www.facebook.com/apps/application.php?id=166706766727124/\",\"caption\":\"%@ must have gotten real lucky this time!\",\"description\":\"\",\"media\":[{\"type\":\"image\",\"src\":\"http://www.raywenderlich.com/wp-content/themes/raywenderlich/images/logo.png\",\"href\":\"http://www.facebook.com/apps/application.php?id=166706766727124/\"}]}",
	//					 _facebookName, _facebookName];
	dialog.attachment = [NSString stringWithFormat:@"{\"name\":\"%@ got %@ points!\",\"href\":\"http://www.facebook.com/apps/application.php?id=166706766727124/\",\"caption\":\"%@ must have gotten real lucky this time!\",\"description\":\"\",\"media\":[{\"type\":\"image\",\"src\":\"http://www.imageshare.web.id/images/zo4srt0q5x5yn3dz8uw.png\",\"href\":\"http://www.facebook.com/apps/application.php?id=166706766727124/\"}]}",
						 _facebookName,tstring, _facebookName];

	//dialog.actionLinks = @"[{\"text\":\"Get MyGrades!\",\"href\":\"http://www.raywenderlich.com/\"}]";
	[dialog show];
	
}
-(IBAction)exitButtonTapped:(id)sender{
	
	exit(0);
}

#pragma mark Memory Cleanup

- (void)viewDidUnload {
	self.postGradesButton = nil;
    self.logoutButton = nil;
}

- (void)dealloc {
    [_session release];
	_session = nil;
	[_postGradesButton release];
	_postGradesButton = nil;
    [_logoutButton release];
	_logoutButton = nil;
    [_loginDialog release];
	_loginDialog = nil;
    [_facebookName release];
	_facebookName = nil;
    [super dealloc];
}

@end
