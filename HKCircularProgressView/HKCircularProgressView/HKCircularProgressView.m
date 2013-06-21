//
//  HKCircularProgressView.m
//  HKCircularProgressView
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

#import "HKCircularProgressView.h"

@interface HKCircularProgressView ()
@end

@implementation HKCircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _defaultInit];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _defaultInit];
    }

    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self _defaultInit];
    }

    return self;
}

+ (Class)layerClass
{
    return [HKCircularProgressLayer class];
}

- (void)_defaultInit
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;

    self.progressTintColor = [UIColor blackColor];
    self.trackTintColor = [UIColor clearColor];
    self.outlineTintColor = nil;
    self.outlineWidth = .0;
    self.fillRadius = 0.25f;
    self.drawFullTrack = NO;
    self.animationDuration = 0.25f;
    self.startAngle = - M_PI_2;
    self.gap = .1;
    [self setMax:1.0f animated:NO];
    [self setCurrent:0.0f animated:NO];
    [self setStep:0.0f];
}

- (void)startAnimating
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"startAngle"];
    animation.duration = 1;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.repeatCount = INFINITY;
    [self.layer addAnimation:animation forKey:@"startAngleAnimation"];
}

- (void)stopAnimating
{
    [self.layer removeAllAnimations];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    if (![self.progressTintColor isEqual:progressTintColor])
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.progressTintColor = progressTintColor;
        [layer setNeedsDisplay];
    }
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    if (![self.trackTintColor isEqual:trackTintColor])
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.trackTintColor = trackTintColor;
        [layer setNeedsDisplay];
    }
}

- (void)setOutlineTintColor:(UIColor *)outlineTintColor
{
    if (![self.outlineTintColor isEqual:outlineTintColor])
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.outlineTintColor = outlineTintColor;
        [layer setNeedsDisplay];
    }
}

- (void)setOutlineWidth:(CGFloat)outlineWidth
{
    if (self.outlineWidth != outlineWidth)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.outlineWidth = outlineWidth;
        [layer setNeedsDisplay];
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
    [layer setNeedsDisplay];
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
    [layer setNeedsDisplay];
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
        [layer setNeedsDisplay];
    }
}

- (void)setDrawFullTrack:(BOOL)drawFullTrack
{
    if (drawFullTrack != self.drawFullTrack)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.drawFullTrack = drawFullTrack;
        [layer setNeedsDisplay];
    }
}

- (void)setEndPoint:(id<HKCircularProgressEndPointDrawer>)endPoint
{
    if (endPoint != self.endPoint)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.endPoint = endPoint;
        [layer setNeedsDisplay];
    }
}

- (void)setGap:(CGFloat)gap
{
    if (gap != self.gap)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.gap = gap;
        [layer setNeedsDisplay];
    }
}

- (void)setStep:(float)step
{
    if (step != self.step)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.step = step;
        [layer setNeedsDisplay];
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
    [layer setNeedsDisplay];
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

- (UIColor *)outlineTintColor
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.outlineTintColor;
}

- (CGFloat)outlineWidth
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.outlineWidth;
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

- (id<HKCircularProgressEndPointDrawer>)endPoint
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.endPoint;
}

- (CGFloat)gap
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.gap;
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
