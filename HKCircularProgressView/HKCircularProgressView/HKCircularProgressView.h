//
//  HKCircularProgressView.h
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

#import <UIKit/UIKit.h>
#import "HKCircularProgressLayer.h"

@interface HKCircularProgressView : UIView

- (void)setFillRadius:(CGFloat)fill
             animated:(BOOL)animated;

- (void)setCurrent:(CGFloat)current
          animated:(BOOL)animated;

- (void)setMax:(CGFloat)max
      animated:(BOOL)animated;

/**
 * Starts an animation that rotates indefinitely the circular view clockwise (by changing the startAngle value).
 */
- (void)startAnimating;

/**
 * Stops all animations.
 */
- (void)stopAnimating;

/**
 * The timing of the animation. fx easeIn, easeOut etc.
 */
@property (nonatomic, strong) CAMediaTimingFunction *animationTiming;

/**
 * Color of the progress circular bar
 */
@property (nonatomic, strong) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;

/**
 * Color of the track (drawn under the progress)
 */
@property (nonatomic, strong) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;

/**
 * Color of the outline
 */
@property (nonatomic, strong) UIColor *outlineTintColor UI_APPEARANCE_SELECTOR;

/**
 * Width of the outline
 */
@property (nonatomic, assign) CGFloat outlineWidth UI_APPEARANCE_SELECTOR;

/**
 * Determines whether the outline is always drawn, even for full segments.
 */
@property (nonatomic, assign) BOOL alwaysDrawOutline UI_APPEARANCE_SELECTOR;

/**
 * Duration of the animation
 */
@property (nonatomic, assign) CFTimeInterval animationDuration UI_APPEARANCE_SELECTOR;

/**
 * Percentage of the circle that will be filled (1 draws a full circle, ]0..1[ draws a ring).
 */
@property (nonatomic, assign) CGFloat fillRadius UI_APPEARANCE_SELECTOR;

/**
 * Amount of the circle that will be filled in pixels (thickness of the ring).
 */
@property (nonatomic, assign) CGFloat fillRadiusPx UI_APPEARANCE_SELECTOR;

/**
 * Angle, in radius, where the progress starts.
 */
@property (nonatomic, assign) CGFloat startAngle UI_APPEARANCE_SELECTOR;

/**
 * Determines whether the track is drawn a complete circle or if it uses the fillRadius parameter.
 */
@property (nonatomic, assign) BOOL drawFullTrack UI_APPEARANCE_SELECTOR;

/**
 * Object that is responsible for drawing the end points of the circular progress.
 */
@property (nonatomic, strong) id<HKCircularProgressEndPointDrawer> endPoint UI_APPEARANCE_SELECTOR;

/**
 * Value between 0 and 1 determining the gap between 2 segments. Only used if the step parameter is used.
 */
@property (nonatomic, assign) CGFloat gap UI_APPEARANCE_SELECTOR;

/**
 * If 0 it will draw a single progression circle. If not it will draw ceil(max / concentricStep) concentric circles progressing one after another.
 */
@property (nonatomic, assign) CGFloat concentricStep;

/**
 * Value between 0 and 1 determining the gap between 2 concentric circles.
 * Only used if the concentricStep parameter is used.
 */
@property (nonatomic, assign) CGFloat concentricGap;

/**
 * Value indicating if the concentric circles will progress inwards (HKConcentricProgressionTypeConcentric) or outwards (HKConcentricProgressionTypeExcentric).
 * Only used if the concentricStep parameter is used.
 */
@property (nonatomic, assign) HKConcentricProgressionType concentricProgressionType;

/**
 * If 0 then it will be a continuous progress. If not, it will be a discrete progress view with (max/step) markers.
 */
@property (nonatomic, assign) CGFloat step;

/**
 * Maximum value.
 */
@property (nonatomic, assign) CGFloat max;

/**
 * Current value.
 */
@property (nonatomic, assign) CGFloat current;

@end
