//
//  MarkingScheme.h
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"

extern int m;

@interface MarkingScheme : NSObject {

	NSNumber *marks;
	
}

@property (nonatomic, retain) NSNumber *marks;

+ (MarkingScheme*)sharedScore;


@end
