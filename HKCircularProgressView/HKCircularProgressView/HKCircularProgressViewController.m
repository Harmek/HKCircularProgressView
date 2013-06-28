//
//  HKCircularProgressView.m
//  HKCircluarProgressView
//
//  Copyright (c) 2012-2013, Panos Baroudjian.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

#import "HKCircularProgressViewController.h"
#import "HKCircularProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface HKCircularProgressViewController ()
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
    self.circularProgressView.fillRadiusPx = 25;
    self.circularProgressView.step = 0.1f;
    self.circularProgressView.startAngle = (M_PI * 3) * 0.5;
    self.circularProgressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.circularProgressView.outlineWidth = 1;
    self.circularProgressView.outlineTintColor = [UIColor blackColor];
    self.circularProgressView.endPoint = [[HKCircularProgressEndPointSpike alloc] init];

    self.circularProgressView2.animationDuration = 5.0f;
    self.circularProgressView2.fillRadiusPx = 25;
    self.circularProgressView2.progressTintColor = [UIColor magentaColor];
    self.circularProgressView2.translatesAutoresizingMaskIntoConstraints = NO;
    self.circularProgressView2.endPoint = [[HKCircularProgressEndPointRound alloc] init];
    
    self.circularProgressView3.fillRadius = 1;
    self.circularProgressView3.progressTintColor = [UIColor yellowColor];
    self.circularProgressView3.translatesAutoresizingMaskIntoConstraints = NO;

    [HKCircularProgressViewController addShadowToView:self.circularProgressView];

    self.concentricProgressView.max = 150;
    self.concentricProgressView.concentricStep = 60;
    self.concentricProgressView.concentricGap = .25;
    self.concentricProgressView.gap = .25;
    self.concentricProgressView.step = 5;
    self.concentricProgressView.progressTintColor = [UIColor cyanColor];
    self.concentricProgressView.outlineTintColor = [UIColor blackColor];
    self.concentricProgressView.outlineWidth = 1;
    self.concentricProgressView.concentricProgressionType = HKConcentricProgressionTypeExcentric;

    [[HKCircularProgressView appearance] setAnimationDuration:5];

    self.circularProgressView.alwaysDrawOutline = YES;
    self.concentricProgressView.alwaysDrawOutline = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.circularProgressView setCurrent:0.6f
                                 animated:YES];
    [self.circularProgressView2 setCurrent:1.0f
                                  animated:YES];
    [self.circularProgressView3 setCurrent:0.7f
                                  animated:YES];
    [self.concentricProgressView setCurrent:150
                                   animated:YES];
}

- (void)viewDidUnload {
    [self setCircularProgressView2:nil];
    [self setCircularProgressView3:nil];
    [self setCircularProgressView:nil];
    [self setConcentricProgressView:nil];
    [super viewDidUnload];
}
@end
