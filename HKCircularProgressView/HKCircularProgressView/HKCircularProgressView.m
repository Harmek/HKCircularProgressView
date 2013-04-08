//
//  HKCircularProgressView.m
//  HKCircularProgressView
//
//  Created by Panos Baroudjian on 10/27/12.
//  Copyright (c) 2012 Panos Baroudjian. All rights reserved.
//

#import "HKCircularProgressView.h"
#import "HKCircularProgressLayer.h"

@interface HKCircularProgressView ()

- (void) defaultInit;

@end

@implementation HKCircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self defaultInit];
    }

    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self defaultInit];
    }

    return self;
}

+ (Class)layerClass
{
    return [HKCircularProgressLayer class];
}

- (void)defaultInit
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;

    self.progressTintColor = [UIColor blackColor];
    self.trackTintColor = [UIColor clearColor];
    self.fillRadius = 0.25f;
    self.drawFullTrack = NO;
    self.animationDuration = 0.25f;
    self.startAngle = - M_PI_2;
    [self setMax:1.0f animated:NO];
    [self setCurrent:0.0f animated:NO];
    [self setStep:0.0f];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    if (![self.progressTintColor isEqual:progressTintColor])
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.progressTintColor = progressTintColor;
        [self.layer setNeedsDisplay];
    }
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    if (![self.trackTintColor isEqual:trackTintColor])
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.trackTintColor = trackTintColor;
        [self.layer setNeedsDisplay];
    }
}

- (void)setFillRadius:(float)fillRadius
             animated:(BOOL)animated
{
    if (self.fillRadius == fillRadius)
    {
        return;
    }
    
    fillRadius = MIN(MAX(0.0f, fillRadius), 1.0f);

    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
    if (animated && self.animationDuration > 0.0f)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillRadius"];
        animation.duration = self.animationDuration;
        animation.fromValue = [NSNumber numberWithFloat:self.fillRadius];
        animation.toValue = [NSNumber numberWithFloat:fillRadius];
        animation.delegate = self;
        [self.layer addAnimation:animation forKey:@"fillRadiusAnimation"];
    }

    layer.fillRadius = fillRadius;
}

- (void)setFillRadius:(float)fillRadius
{
    [self setFillRadius:fillRadius animated:NO];
}

- (void)setCurrent:(float)current
          animated:(BOOL)animated
{
    if (current == self.current)
    {
        return;
    }
    
    current = MIN(MAX(0.0f, current), self.max);

    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
    if (animated && self.animationDuration > 0.0f)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"current"];
        animation.duration = self.animationDuration;
        animation.fromValue = [NSNumber numberWithFloat:layer.current];
        animation.toValue = [NSNumber numberWithFloat:current];
        [self.layer addAnimation:animation forKey:@"currentAnimation"];
    }

    layer.current = current;
}

- (void)setCurrent:(float)current
{
    [self setCurrent:current animated:YES];
}

- (void)setStartAngle:(float)startAngle
{
    if (startAngle != self.startAngle)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.startAngle = startAngle;
    }
}

- (void)setDrawFullTrack:(BOOL)drawFullTrack
{
    if (drawFullTrack != self.drawFullTrack)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.drawFullTrack = drawFullTrack;
    }
}

- (void)setStep:(float)step
{
    if (step != self.step)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.step = step;
    }
}

- (void)setMax:(float)max
      animated:(BOOL)animated
{
    if (max == self.max)
    {
        return;
    }

    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
    if (animated && self.animationDuration > 0.0f)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"current"];
        animation.duration = self.animationDuration;
        animation.fromValue = [NSNumber numberWithFloat:layer.max];
        animation.toValue = [NSNumber numberWithFloat:max];
        [self.layer addAnimation:animation forKey:@"currentAnimation"];
    }

    layer.max = max;
}

- (void)setMax:(float)max
{
    [self setMax:max animated:YES];
}

- (UIColor *)progressTintColor
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.progressTintColor;
}

- (UIColor *)trackTintColor
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.trackTintColor;
}

- (float)fillRadius
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.fillRadius;
}

- (float)startAngle
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.startAngle;
}

- (BOOL)drawFullTrack
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.drawFullTrack;
}

- (float)step
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.step;
}

- (float)max
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.max;
}

- (float)current
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.current;
}

@end
