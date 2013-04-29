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

@interface HKCircularProgressView : UIView <UIAppearanceContainer>

- (void)setFillRadius:(float)fill
             animated:(BOOL)animated;

- (void)setCurrent:(float)current
          animated:(BOOL)animated;

- (void)setMax:(float)max
      animated:(BOOL)animated;

@property (nonatomic, strong) UIColor           *progressTintColor      UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor           *trackTintColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor           *outlineTintColor       UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat           outlineWidth            UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CFTimeInterval    animationDuration       UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float             fillRadius              UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float             startAngle              UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL              drawFullTrack           UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) float             step;
@property (nonatomic, assign) float             max;
@property (nonatomic, assign) float             current;

@end
