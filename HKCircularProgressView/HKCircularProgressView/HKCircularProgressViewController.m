//
//  HKViewController.m
//  HKCircluarProgressView
//
//  Created by Panos Baroudjian on 4/8/13.
//  Copyright (c) 2013 Panos Baroudjian. All rights reserved.
//

#import "HKCircularProgressViewController.h"
#import "HKCircularProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface HKCircularProgressViewController ()
+ (void)addShadowToView:(UIView *)view;
@end

@implementation HKCircularProgressViewController

+ (void)addShadowToView:(UIView *)view
{
    [[view layer] setShadowOffset:CGSizeMake(0, -1)];
    [[view  layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[view  layer] setShadowRadius:1.0f];
    [[view  layer] setShadowOpacity:0.75f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.circularProgressView.progressTintColor = [UIColor cyanColor];
    self.circularProgressView.max = 1.0f;
    self.circularProgressView.animationDuration = 5.0f;
    self.circularProgressView.step = 0.1f;
    self.circularProgressView.startAngle = (M_PI * 3) * 0.5;
    self.circularProgressView.translatesAutoresizingMaskIntoConstraints = NO;

    self.circularProgressView2.animationDuration = 5.0f;
    self.circularProgressView2.fillRadius = .35f;
    self.circularProgressView2.progressTintColor = [UIColor magentaColor];
    self.circularProgressView2.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.circularProgressView3.animationDuration = 5.0f;
    self.circularProgressView3.fillRadius = 1.0f;
    self.circularProgressView3.progressTintColor = [UIColor yellowColor];
    self.circularProgressView2.translatesAutoresizingMaskIntoConstraints = NO;

    [HKCircularProgressViewController addShadowToView:self.circularProgressView];
    [HKCircularProgressViewController addShadowToView:self.circularProgressView2];
    [HKCircularProgressViewController addShadowToView:self.circularProgressView3];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.circularProgressView setCurrent:1.0f
                                 animated:YES];
    [self.circularProgressView2 setCurrent:1.0f
                                  animated:YES];
    [self.circularProgressView3 setCurrent:1.0f
                                  animated:YES];
    [self.circularProgressView3 setFillRadius:0.35f
                                     animated:YES];
}

- (void)viewDidUnload {
    [self setCircularProgressView2:nil];
    [self setCircularProgressView3:nil];
    [self setCircularProgressView2:nil];
    [self setCircularProgressView:nil];
    [super viewDidUnload];
}
@end
