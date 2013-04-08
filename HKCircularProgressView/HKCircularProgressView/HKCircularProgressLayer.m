//
//  HKCircularProgressLayer.m
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

#define TWO_PI M_PI * 2.0f
static const float k2Pi = TWO_PI;

#define GAP 0.1

#import "HKCircularProgressLayer.h"

@interface HKCircularProgressLayer ()

+ (void)drawTrackInContext:(CGContextRef)ctx
                     fully:(BOOL)drawFullTrack
                withCenter:(CGPoint)center
                 andRadius:(CGFloat)radius
                   andTint:(CGColorRef)trackTintColor
             andFillAmount:(float)trackFillAmount;



+ (void)drawProgressInContext:(CGContextRef)ctx
                  withCurrent:(float)current
                       andMax:(float)max
                      andStep:(float)step
                     atCenter:(CGPoint)center
                andStartAngle:(float)startAngle
                   withRadius:(CGFloat)radius
                andFillAmount:(float)trackFillAmount
                 andTintColor:(CGColorRef)tintColor;

+ (void)drawArcInContext:(CGContextRef)ctx
              withCenter:(CGPoint)center
               andRadius:(CGFloat)radius
          andInnerRadius:(CGFloat)innerRadius
                 between:(CGFloat)startAngle
                     and:(CGFloat)destAngle;
@end

@implementation HKCircularProgressLayer

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if (self)
    {
        if ([layer isKindOfClass:[HKCircularProgressLayer class]])
        {
            HKCircularProgressLayer *other = layer;
            self.progressTintColor = other.progressTintColor;
            self.trackTintColor = other.trackTintColor;
            self.animationDuration = other.animationDuration;
            self.fillRadius = other.fillRadius;
            self.drawFullTrack = other.drawFullTrack;
            self.startAngle = other.startAngle;

            self.step = other.step;
            self.current = other.current;
            self.max = other.max;
        }
    }

    return self;
}

+ (id)layer
{
    HKCircularProgressLayer *result = [[HKCircularProgressLayer alloc] init];

    return result;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progressTintColor"]
        || [key isEqualToString:@"trackTintColor"]
        || [key isEqualToString:@"fillRadius"]
        || [key isEqualToString:@"drawFullTrack"]
        || [key isEqualToString:@"startAngle"]
        || [key isEqualToString:@"step"]
        || [key isEqualToString:@"current"]
        || [key isEqualToString:@"max"])
    {
        return YES;
    }

    return [super needsDisplayForKey:key];
}

+ (void)drawTrackInContext:(CGContextRef)ctx
                     fully:(BOOL)drawFullTrack
                withCenter:(CGPoint)center
                 andRadius:(CGFloat)radius
                   andTint:(CGColorRef)trackTintColor
             andFillAmount:(float)fillRadius
{
    if (drawFullTrack)
    {
        CGRect circleRect = CGRectMake(center.x - radius, center.y - radius, radius * 2.0, radius * 2.0);
        CGContextAddEllipseInRect(ctx, circleRect);
    }
    else
    {
        CGContextAddArc(ctx, center.x, center.y, radius, 0, k2Pi, 0);
        CGFloat innerRadius = radius * (1.f - fillRadius);

        CGFloat x = center.x + innerRadius;
        CGFloat y = center.y;
        CGContextAddLineToPoint(ctx, x, y);
        CGContextAddArc(ctx, center.x, center.y, innerRadius, k2Pi, 0, 1);
        CGContextClosePath(ctx);
    }

    CGContextSetFillColorWithColor(ctx, trackTintColor);
    CGContextFillPath(ctx);
}

+ (void)drawArcInContext:(CGContextRef)ctx
              withCenter:(CGPoint)center
               andRadius:(CGFloat)radius
          andInnerRadius:(CGFloat)innerRadius
                 between:(CGFloat)startAngle
                     and:(CGFloat)destAngle
{
    CGContextAddArc(ctx, center.x, center.y, radius, startAngle, destAngle, 0);
    if (innerRadius > .0f)
    {
        CGFloat x = center.x + innerRadius * cos(destAngle);
        CGFloat y = center.y + innerRadius * sin(destAngle);
        CGContextAddLineToPoint(ctx, x, y);
        CGContextAddArc(ctx, center.x, center.y, innerRadius, destAngle, startAngle, 1);
    }
    else
    {
        CGContextAddLineToPoint(ctx, center.x, center.y);
    }
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

+ (void)drawProgressInContext:(CGContextRef)ctx
                  withCurrent:(float)current
                       andMax:(float)max
                      andStep:(float)step
                     atCenter:(CGPoint)center
                andStartAngle:(float)startAngle
                   withRadius:(CGFloat)radius
                andFillAmount:(float)fillRadius
                 andTintColor:(CGColorRef)tintColor
{
    CGContextSetFillColorWithColor(ctx, tintColor);

    CGFloat destAngle = .0f;
    CGFloat innerRadius = radius * (1.f - fillRadius);

    if (step == .0f)
    {

        CGFloat progress = current / max;
        destAngle = startAngle + progress * k2Pi;
        [HKCircularProgressLayer drawArcInContext:ctx
                          withCenter:center
                           andRadius:radius
                      andInnerRadius:innerRadius
                             between:startAngle
                                 and:destAngle];
    }
    else
    {
        float gap = (step * GAP) / max;
        float gapAngle = gap * k2Pi;
        float incr = (step - (step * GAP)) / max;
        float stepAngle = incr * k2Pi;
        startAngle += gapAngle * .5f;
        for (float f = .0f; f < current; f += step)
        {
            destAngle = startAngle + stepAngle;

            [HKCircularProgressLayer drawArcInContext:ctx
                              withCenter:center
                               andRadius:radius
                          andInnerRadius:innerRadius
                                 between:startAngle
                                     and:destAngle];

            startAngle += stepAngle + gapAngle;
        }
    }
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * .5f;
    CGPoint center = CGPointMake(self.bounds.size.width * .5f, self.bounds.size.height * .5f);

    [HKCircularProgressLayer drawTrackInContext:ctx
                             fully:self.drawFullTrack
                        withCenter:center
                         andRadius:radius
                           andTint:self.trackTintColor.CGColor
                     andFillAmount:self.fillRadius];

    [HKCircularProgressLayer drawProgressInContext:ctx
                          withCurrent:self.current
                               andMax:self.max
                              andStep:self.step
                             atCenter:center
                        andStartAngle:self.startAngle
                           withRadius:radius
                        andFillAmount:self.fillRadius
                         andTintColor:self.progressTintColor.CGColor];
}

@end
