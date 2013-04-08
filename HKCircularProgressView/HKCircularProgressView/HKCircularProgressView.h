//
//  HKCircularProgressView.h
//  HKCircularProgressView
//
//  Created by Panos Baroudjian on 10/27/12.
//  Copyright (c) 2012 Panos Baroudjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum HKCircularProgressType
{
    HKCircularProgressTypeContinuous = 0,
    HKCircularProgressTypeDiscrete
} HKCircularProgressType;

@interface HKCircularProgressView : UIView <UIAppearanceContainer>

- (void)setFillRadius:(float)fill
             animated:(BOOL)animated;

- (void)setCurrent:(float)current
          animated:(BOOL)animated;

- (void)setMax:(float)max
      animated:(BOOL)animated;

@property (nonatomic, strong) UIColor           *progressTintColor      UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor           *trackTintColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CFTimeInterval    animationDuration       UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float             fillRadius              UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) float             startAngle              UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL              drawFullTrack           UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) float             step;
@property (nonatomic, assign) float             max;
@property (nonatomic, assign) float             current;

@end
