//
//  HKCircularProgressLayer.h
//  HKCircularProgressView
//
//  Created by Panos Baroudjian on 10/27/12.
//  Copyright (c) 2012 Panos Baroudjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HKCircularProgressLayer : CALayer

@property (nonatomic, strong) UIColor           *progressTintColor;
@property (nonatomic, strong) UIColor           *trackTintColor;
@property (nonatomic, assign) CFTimeInterval    animationDuration;
@property (nonatomic, assign) float             fillRadius;
@property (nonatomic, assign) float             startAngle;
@property (nonatomic, assign) BOOL              drawFullTrack;

@property (nonatomic, assign) float             step;
@property (nonatomic, assign) float             max;
@property (nonatomic, assign) float             current;

@end
