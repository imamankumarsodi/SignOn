//
//  UIScrollView+APParallaxHeader.h
//
//  Created by Mathias Amnell on 2013-04-12.
//  Copyright (c) 2013 Apping AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKParallaxView;
@class SKParallaxShadowView;

#pragma mark UIScrollView Category

@interface UIScrollView (SKParallaxHeader)

- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height andShadow:(BOOL)shadow;
- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height andShadow:(BOOL)shadow;

@property (nonatomic, strong, readonly) SKParallaxView *parallaxView;
@property (nonatomic, assign) BOOL showsParallax;

@end

#pragma mark APParallaxView

@protocol SKParallaxViewDelegate;

typedef NS_ENUM(NSUInteger, SKParallaxTrackingState) {
    SKParallaxTrackingActive = 0,
    SKParallaxTrackingInactive
};

@interface SKParallaxView : UIView

@property (weak) id<SKParallaxViewDelegate> delegate;

@property (nonatomic, readonly) SKParallaxTrackingState state;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *currentSubView;
@property (nonatomic, strong) SKParallaxShadowView *shadowView;
@property (nonatomic, strong) UIView *customView;

- (id)initWithFrame:(CGRect)frame andShadow:(BOOL)shadow;

@end

@protocol SKParallaxViewDelegate <NSObject>
@optional
- (void)parallaxView:(SKParallaxView *)view willChangeFrame:(CGRect)frame;
- (void)parallaxView:(SKParallaxView *)view didChangeFrame:(CGRect)frame;
@end

#pragma mark SKParallaxShadowView

@interface SKParallaxShadowView : UIView

@end
