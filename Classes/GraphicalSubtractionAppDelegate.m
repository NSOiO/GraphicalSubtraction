//
//  GraphicalSubtractionAppDelegate.m
//  GraphicalSubtraction
//
//  Created by Matt Gallagher on 2010/05/18.
//  Copyright Matt Gallagher 2010. All rights reserved.
//

#import "GraphicalSubtractionAppDelegate.h"
#import "GraphicalSubtractionViewController.h"

@implementation GraphicalSubtractionAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
