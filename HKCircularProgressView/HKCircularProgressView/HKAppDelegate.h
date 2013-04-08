//
//  HKAppDelegate.h
//  HKCircularProgressView
//
//  Created by Panos Baroudjian on 4/8/13.
//  Copyright (c) 2013 Panos Baroudjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKCircularProgressViewController;
@interface HKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HKCircularProgressViewController *viewController;

@end
