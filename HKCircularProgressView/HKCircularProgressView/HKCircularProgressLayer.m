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

#import "HKCircularProgressLayer.h"

#define TWO_PI M_PI * 2.0f

static const float k2Pi = TWO_PI;

@implementation HKCircularProgressEndPointFlat

- (CGFloat)startPointAngleWithCenter:(CGPoint)center
                              radius:(CGFloat)radius
                         innerRadius:(CGFloat)innerRadius
                               angle:(CGFloat)angle
{
    return angle;
}

- (CGFloat)endPointAngleWithCenter:(CGPoint)center
                            radius:(CGFloat)radius
                       innerRadius:(CGFloat)innerRadius
                             angle:(CGFloat)angle
{
    return angle;
}

- (void)drawStartPointInContext:(CGContextRef)ctx
                     withCenter:(CGPoint)center
                      andRadius:(CGFloat)radius
                 andInnerRadius:(CGFloat)innerRadius
                        atAngle:(CGFloat)angle
{
}

- (void)drawEndPointInContext:(CGContextRef)ctx
                   withCenter:(CGPoint)center
                    andRadius:(CGFloat)radius
               andInnerRadius:(CGFloat)innerRadius
                      atAngle:(CGFloat)angle
{
}

@end

static void getTipPointAndTransformForEndPoint(CGPoint center,
                                               CGFloat radius,
                                               CGFloat innerRadius,
                                               CGFloat angle,
                                               BOOL clockwise,
                                               CGPoint *outPoint,
                                               CGAffineTransform *outTransform)
{
    CGFloat trackWidth = radius - innerRadius;
    CGFloat halfTrackWidth = trackWidth * .5;
    CGFloat trackCenterRadius = innerRadius + halfTrackWidth;
    *outTransform = CGAffineTransformMakeRotation(angle);
    outTransform->tx = center.x;
    outTransform->ty = center.y;
    if (clockwise)
        halfTrackWidth *= -1;
    *outPoint = CGPointMake(trackCenterRadius, halfTrackWidth);
    *outPoint = CGPointApplyAffineTransform(*outPoint, *outTransform);
}

@implementation HKCircularProgressEndPointSpike

- (CGFloat)startPointAngleWithCenter:(CGPoint)center
                              radius:(CGFloat)radius
                         innerRadius:(CGFloat)innerRadius
                               angle:(CGFloat)angle
{
    return angle;
}

- (CGFloat)endPointAngleWithCenter:(CGPoint)center
                            radius:(CGFloat)radius
                       innerRadius:(CGFloat)innerRadius
                             angle:(CGFloat)angle
{
    return angle;
}

- (void)drawStartPointInContext:(CGContextRef)ctx
                     withCenter:(CGPoint)center
                      andRadius:(CGFloat)radius
                 andInnerRadius:(CGFloat)innerRadius
                        atAngle:(CGFloat)angle
{
    CGPoint tipPoint = CGPointZero;
    CGAffineTransform transform = CGAffineTransformIdentity;
    getTipPointAndTransformForEndPoint(center, radius, innerRadius, angle, YES, &tipPoint, &transform);
    CGContextAddLineToPoint(ctx, tipPoint.x, tipPoint.y);
    CGFloat x = center.x + innerRadius * cos(angle);
    CGFloat y = center.y + innerRadius * sin(angle);
    CGContextAddLineToPoint(ctx, x, y);
}

- (void)drawEndPointInContext:(CGContextRef)ctx
                   withCenter:(CGPoint)center
                    andRadius:(CGFloat)radius
               andInnerRadius:(CGFloat)innerRadius
                      atAngle:(CGFloat)angle
{
    CGPoint tipPoint = CGPointZero;
    CGAffineTransform transform = CGAffineTransformIdentity;
    getTipPointAndTransformForEndPoint(center, radius, innerRadius, angle, NO, &tipPoint, &transform);
    CGContextAddLineToPoint(ctx, tipPoint.x, tipPoint.y);
    CGFloat x = center.x + innerRadius * cos(angle);
    CGFloat y = center.y + innerRadius * sin(angle);
    CGContextAddLineToPoint(ctx, x, y);
}

@end

@implementation HKCircularProgressEndPointRound

- (CGFloat)startPointAngleWithCenter:(CGPoint)center
                              radius:(CGFloat)radius
                         innerRadius:(CGFloat)innerRadius
                               angle:(CGFloat)angle
{
    return angle;
}

- (CGFloat)endPointAngleWithCenter:(CGPoint)center
                            radius:(CGFloat)radius
                       innerRadius:(CGFloat)innerRadius
                             angle:(CGFloat)angle
{
    return angle;
}

- (void)drawStartPointInContext:(CGContextRef)ctx
                     withCenter:(CGPoint)center
                      andRadius:(CGFloat)radius
                 andInnerRadius:(CGFloat)innerRadius
                        atAngle:(CGFloat)angle
{
    CGPoint tipPoint = CGPointZero;
    CGAffineTransform transform = CGAffineTransformIdentity;
    getTipPointAndTransformForEndPoint(center, radius, innerRadius, angle, YES, &tipPoint, &transform);
    CGFloat x = center.x + innerRadius * cos(angle);
    CGFloat y = center.y + innerRadius * sin(angle);
    CGContextAddQuadCurveToPoint(ctx, tipPoint.x, tipPoint.y, x, y);
}

- (void)drawEndPointInContext:(CGContextRef)ctx
                   withCenter:(CGPoint)center
                    andRadius:(CGFloat)radius
               andInnerRadius:(CGFloat)innerRadius
                      atAngle:(CGFloat)angle
{
    CGPoint tipPoint = CGPointZero;
    CGAffineTransform transform = CGAffineTransformIdentity;
    getTipPointAndTransformForEndPoint(center, radius, innerRadius, angle, NO, &tipPoint, &transform);
    CGFloat x = center.x + innerRadius * cos(angle);
    CGFloat y = center.y + innerRadius * sin(angle);
    CGContextAddQuadCurveToPoint(ctx, tipPoint.x, tipPoint.y, x, y);
}

@end

@interface HKCircularProgressLayer ()

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
            self.outlineTintColor = other.outlineTintColor;
            self.outlineWidth = other.outlineWidth;
            self.animationDuration = other.animationDuration;
            self.fillRadius = other.fillRadius;
            self.drawFullTrack = other.drawFullTrack;
            self.startAngle = other.startAngle;
            self.endPoint = other.endPoint;

            self.step = other.step;
            self.current = other.current;
            self.max = other.max;
            self.gap = other.gap;
        }
    }

    return self;
}

+ (id)layer
{
    HKCircularProgressLayer *result = [[HKCircularProgressLayer alloc] init];

    return result;
}

- (id<HKCircularProgressEndPointDrawer>)endPoint
{
    if (!_endPoint)
        _endPoint = [[HKCircularProgressEndPointFlat alloc] init];

    return _endPoint;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progressTintColor"]
        || [key isEqualToString:@"trackTintColor"]
        || [key isEqualToString:@"outlineTintColor"]
        || [key isEqualToString:@"outlineWidth"]
        || [key isEqualToString:@"fillRadius"]
        || [key isEqualToString:@"drawFullTrack"]
        || [key isEqualToString:@"startAngle"]
        || [key isEqualToString:@"endPoint"]
        || [key isEqualToString:@"gap"]
        || [key isEqualToString:@"step"]
        || [key isEqualToString:@"current"]
        || [key isEqualToString:@"max"])
    {
        return YES;
    }

    return [super needsDisplayForKey:key];
}

- (void)drawTrackInContext:(CGContextRef)ctx
                withCenter:(CGPoint)center
                 andRadius:(CGFloat)radius
{
    if (self.drawFullTrack)
    {
        CGRect circleRect = CGRectMake(center.x - radius, center.y - radius, radius * 2.0, radius * 2.0);
        CGContextAddEllipseInRect(ctx, circleRect);
    }
    else
    {
        CGContextAddArc(ctx, center.x, center.y, radius, 0, k2Pi, 0);
        CGFloat innerRadius = radius * (1.f - self.fillRadius);

        CGFloat x = center.x + innerRadius;
        CGFloat y = center.y;
        CGContextAddLineToPoint(ctx, x, y);
        CGContextAddArc(ctx, center.x, center.y, innerRadius, k2Pi, 0, 1);
        CGContextClosePath(ctx);
    }

    CGContextSetFillColorWithColor(ctx, self.trackTintColor.CGColor);
    CGContextFillPath(ctx);
}

- (void)drawArcInContext:(CGContextRef)ctx
              withCenter:(CGPoint)center
               andRadius:(CGFloat)radius
          andInnerRadius:(CGFloat)innerRadius
                 between:(CGFloat)startAngle
                     and:(CGFloat)destAngle
                    fill:(BOOL)fill
{
    startAngle = [self.endPoint startPointAngleWithCenter:center
                                                   radius:radius
                                              innerRadius:innerRadius
                                                    angle:startAngle];
    destAngle = [self.endPoint endPointAngleWithCenter:center
                                                radius:radius
                                           innerRadius:innerRadius
                                                 angle:destAngle];

    CGContextAddArc(ctx, center.x, center.y, radius, startAngle, destAngle, 0);

    [self.endPoint drawEndPointInContext:ctx
                              withCenter:center
                               andRadius:radius
                          andInnerRadius:innerRadius
                                 atAngle:destAngle];
    
    CGContextAddArc(ctx, center.x, center.y, innerRadius, destAngle, startAngle, 1);

    [self.endPoint drawStartPointInContext:ctx
                                withCenter:center
                                 andRadius:innerRadius
                            andInnerRadius:radius
                                   atAngle:startAngle];

    CGContextClosePath(ctx);
    if (fill)
        CGContextFillPath(ctx);
    CGContextStrokePath(ctx);

}

- (void)drawProgressInContext:(CGContextRef)ctx
                     atCenter:(CGPoint)center
                   withRadius:(CGFloat)radius
{
    CGContextSetFillColorWithColor(ctx, self.progressTintColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, self.outlineTintColor
                                     ? self.outlineTintColor.CGColor
                                     : self.progressTintColor.CGColor);
    CGContextSetLineWidth(ctx, self.outlineWidth);
    CGFloat destAngle = .0f;
    CGFloat innerRadius = radius * (1.f - self.fillRadius);

    if (self.step == .0f)
    {
        CGFloat progress = self.current / self.max;
        destAngle = self.startAngle + progress * k2Pi;
        [self drawArcInContext:ctx
                    withCenter:center
                     andRadius:radius
                andInnerRadius:innerRadius
                       between:self.startAngle
                           and:destAngle
                          fill:YES];
        if (self.outlineWidth> .0 && self.current < self.max)
        {
            [self drawArcInContext:ctx
                        withCenter:center
                         andRadius:radius
                    andInnerRadius:innerRadius
                           between:destAngle
                               and:self.startAngle
                              fill:NO];
        }
    }
    else
    {
        float gap = (self.step * self.gap) / self.max;
        float gapAngle = gap * k2Pi;
        float incr = (self.step - (self.step * self.gap)) / self.max;
        float stepAngle = incr * k2Pi;
        float startAngle = self.startAngle + (gapAngle * .5f);
        for (float f = .0f; f < self.current; f += self.step)
        {
            destAngle = startAngle + stepAngle;
            [self drawArcInContext:ctx
                        withCenter:center
                         andRadius:radius
                    andInnerRadius:innerRadius
                           between:startAngle
                               and:destAngle
                              fill:YES];
            startAngle += stepAngle + gapAngle;
        }

        if (self.outlineWidth > .0 && self.max)
        {
            for (float f = self.current + self.step; f <= self.max; f += self.step)
            {
                destAngle = startAngle + stepAngle;
                [self drawArcInContext:ctx
                            withCenter:center
                             andRadius:radius
                        andInnerRadius:innerRadius
                               between:startAngle
                                   and:destAngle
                                  fill:NO];
                startAngle += stepAngle + gapAngle;
            }
        }
    }
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * .5f - (2. * self.outlineWidth);
    CGPoint center = CGPointMake(self.bounds.size.width * .5f, self.bounds.size.height * .5f);

    [self drawTrackInContext:ctx withCenter:center andRadius:radius];
    [self drawProgressInContext:ctx atCenter:center withRadius:radius];
}

@end