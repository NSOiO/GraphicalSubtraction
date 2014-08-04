//
//  GraphicalSubtractionAppDelegate.h
//  GraphicalSubtraction
//
//  Created by Matt Gallagher on 2010/05/18.
//  Copyright Matt Gallagher 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphicalSubtractionViewController;

@interface GraphicalSubtractionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GraphicalSubtractionViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GraphicalSubtractionViewController *viewController;

@end

