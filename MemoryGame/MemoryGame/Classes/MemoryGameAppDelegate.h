//
//  MemoryGameAppDelegate.h
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"

@interface MemoryGameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

