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

    self.animationTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
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
    [self setConcentricStep:.0];
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

- (void)setAlwaysDrawOutline:(BOOL)alwaysDrawOutline
{
    if (self.alwaysDrawOutline != alwaysDrawOutline)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.alwaysDrawOutline = alwaysDrawOutline;
        [layer setNeedsDisplay];
    }
}

- (void)setFillRadius:(CGFloat)fillRadius
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
        animation.timingFunction = self.animationTiming;
        animation.delegate = self;
        [self.layer addAnimation:animation forKey:@"fillRadiusAnimation"];
    }

    layer.fillRadius = fillRadius;
    [layer setNeedsDisplay];
}

- (void)setFillRadius:(CGFloat)fillRadius
{
    [self setFillRadius:fillRadius animated:NO];
}

- (void)setFillRadiusPx:(CGFloat)fillRadiusPx
               animated:(BOOL)animated
{
    if (self.fillRadiusPx == fillRadiusPx)
    {
        return;
    }

    fillRadiusPx = MAX(0.0f, fillRadiusPx);

    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
    if (animated && self.animationDuration > 0.0f)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillRadiusPx"];
        animation.duration = self.animationDuration;
        animation.fromValue = @(self.fillRadiusPx);
        animation.toValue = @(fillRadiusPx);
        animation.delegate = self;
        animation.timingFunction = self.animationTiming;
        [self.layer addAnimation:animation forKey:@"fillRadiusPxAnimation"];
    }

    layer.fillRadiusPx = fillRadiusPx;
    [layer setNeedsDisplay];
}

- (void)setFillRadiusPx:(CGFloat)fillRadiusPx
{
    [self setFillRadiusPx:fillRadiusPx animated:NO];
}

- (void)setCurrent:(CGFloat)current
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
        animation.fromValue = @(self.current);
        animation.toValue = @(current);
        animation.timingFunction = self.animationTiming;
        [self.layer addAnimation:animation forKey:@"currentAnimation"];
    }
    
    layer.current = current;
    [layer setNeedsDisplay];
}

- (void)setCurrent:(CGFloat)current
{
    [self setCurrent:current animated:YES];
}

- (void)setStartAngle:(CGFloat)startAngle
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

- (void)setConcentricStep:(CGFloat)concentricStep
{
    if (concentricStep != self.concentricStep)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.concentricStep = concentricStep;
        [layer setNeedsDisplay];
    }
}

- (void)setConcentricGap:(CGFloat)concentricGap
{
    if (concentricGap != self.concentricGap)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.concentricGap = concentricGap;
        [layer setNeedsDisplay];
    }
}

- (void)setConcentricProgressionType:(HKConcentricProgressionType)concentricProgressionType
{
    if (concentricProgressionType != self.concentricProgressionType)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.concentricProgressionType = concentricProgressionType;
        [layer setNeedsDisplay];
    }
}

- (void)setStep:(CGFloat)step
{
    if (step != self.step)
    {
        HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
        layer.step = step;
        [layer setNeedsDisplay];
    }
}

- (void)setMax:(CGFloat)max
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
        animation.fromValue = @(layer.max);
        animation.toValue = @(max);
        animation.timingFunction = self.animationTiming;
        [self.layer addAnimation:animation forKey:@"currentAnimation"];
    }

    layer.max = max;
    [layer setNeedsDisplay];
}

- (void)setMax:(CGFloat)max
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

- (BOOL)alwaysDrawOutline
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.alwaysDrawOutline;
}

- (CGFloat)outlineWidth
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.outlineWidth;
}

- (CGFloat)fillRadius
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.fillRadius;
}

- (CGFloat)fillRadiusPx
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.fillRadiusPx;
}

- (CGFloat)startAngle
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

- (CGFloat)concentricStep
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.concentricStep;
}

- (CGFloat)concentricGap
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.concentricGap;
}

- (HKConcentricProgressionType)concentricProgressionType
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.concentricProgressionType;
}

- (CGFloat)step
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.step;
}

- (CGFloat)max
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;

    return layer.max;
}

- (CGFloat)current
{
    HKCircularProgressLayer *layer = (HKCircularProgressLayer *)self.layer;
    
    return layer.current;
}

@end
