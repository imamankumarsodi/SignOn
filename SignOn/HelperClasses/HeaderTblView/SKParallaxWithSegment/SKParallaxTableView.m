//
//  DTTableView.m
//
//  Created by ToanDK on 4/24/15.
//  Copyright (c) 2015 ToanDK. All rights reserved.
//

#import "SKParallaxTableView.h"
//#import <SDWebImage/UIImageView+WebCache.h>

@implementation SKParallaxTableView

#define NAVIGATION_BAR_HEIGHT 64
#define SHADOW_TAG 101

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] && object == self) {
        float offsetY = self.contentOffset.y;
        SKParallaxHeaderView *headerView = (SKParallaxHeaderView*)self.tableHeaderView;
        
        float limit = self.tableHeaderView.frame.size.height - NAVIGATION_BAR_HEIGHT;
        if (offsetY >= limit) {
            topBarView.alpha = 1;
        }
        else topBarView.alpha = 0;
        if (offsetY > 0) {
            bgView.frame = CGRectMake(0, -kSKImageViewOffsetY-offsetY, bgView.frame.size.width, bgView.frame.size.height);
        }
        else {
            if (offsetY < -kSKImageViewOffsetY*2)
                self.contentOffset = CGPointMake(0, -kSKImageViewOffsetY*2);
            else if (offsetY > -kSKScaleLimitOffset) {
                CGPoint center = bgView.center;
                bgView.transform = CGAffineTransformMakeScale(1, 1);
                bgView.frame = CGRectMake(0, -kSKImageViewOffsetY-offsetY/2, bgView.frame.size.width, bgView.frame.size.height);
                bgView.center = CGPointMake(center.x, bgView.center.y);
            }
            else {
                CGPoint center = bgView.center;
                float ratio = 1 + MAX((-offsetY - kSKScaleLimitOffset)/400, 0);
                bgView.transform = CGAffineTransformMakeScale(ratio, ratio);
                bgView.center = center;
            }
        }
        UIView *tabBarView = headerView.tabBarView;
        if (tabBarView) {
            if (offsetY >= limit - tabBarView.frame.size.height) {
                if (tabBarView.superview == headerView) {
                    [tabBarView removeFromSuperview];
                    [self.superview insertSubview:tabBarView aboveSubview:self];
                    tabBarView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, tabBarView.frame.size.width, tabBarView.frame.size.height);
                }
            }
            else {
                if (tabBarView.superview == self.superview) {
                    [tabBarView removeFromSuperview];
                    [headerView addSubview:tabBarView];
                    tabBarView.frame = CGRectMake(0, headerView.frame.size.height - tabBarView.frame.size.height, tabBarView.frame.size.width, tabBarView.frame.size.height);
                }
            }
        }
    }
}

-(void)setupTopBarViewWithHeader:(SKParallaxHeaderView*)headerView {
    topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -headerView.frame.size.height + NAVIGATION_BAR_HEIGHT, self.frame.size.width, headerView.frame.size.height)];
    
    UIView *headerImgView = [[UIView alloc] initWithFrame:CGRectMake(0, -kSKImageViewOffsetY, self.frame.size.width, topBarView.frame.size.height + kSKImageViewOffsetY*2)];
    headerImgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    headerImgView.clipsToBounds = YES;
    headerImgView.contentMode = UIViewContentModeScaleAspectFill;
//    headerImgView.image = headerView.bgImage;
//    if (headerView.imageUrl) {
//        // setup image from url here
//        [headerImgView setImageWithURL:[NSURL URLWithString:headerView.imageUrl] placeholderImage:[UIImage imageNamed:@"girl.jpg"]];
//    }
    
    [topBarView addSubview:headerImgView];
    
    UIImageView *maskImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topBarView.frame.size.width, topBarView.frame.size.height)];
    maskImg.backgroundColor = [UIColor blackColor];
    maskImg.alpha = 0.3;
    maskImg.tag = SHADOW_TAG;
    if (!self.showShadow) maskImg.hidden = YES;
    maskImg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [topBarView addSubview:maskImg];
    topBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    topBarView.alpha = 0;
    topBarView.clipsToBounds = YES;
    [self.superview insertSubview:topBarView aboveSubview:self];
}

-(void)setupBackgroundViewWithHeader:(SKParallaxHeaderView*)headerView {
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -kSKImageViewOffsetY, self.frame.size.width, topBarView.frame.size.height + kSKImageViewOffsetY*2)];
    UIView *bgImgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, topBarView.frame.size.height + kSKImageViewOffsetY*2)];
//    bgImgView.image = headerView.bgImage;
//    if (headerView.imageUrl) {
//        // setup image from url here
//        [bgImgView setImageWithURL:[NSURL URLWithString:headerView.imageUrl] placeholderImage:[UIImage imageNamed:@"girl.jpg"]];
//    }
    [bgView addSubview:bgImgView];
    bgImgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;;
    
    bgImgView.clipsToBounds = YES;
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    UIImageView *maskImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
    maskImg.backgroundColor = [UIColor blackColor];
    maskImg.alpha = 0.3;
    maskImg.tag = SHADOW_TAG;
    maskImg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [bgView addSubview:maskImg];
    if (!self.showShadow) maskImg.hidden = YES;
    bgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.superview insertSubview:bgView belowSubview:self];
}

-(void)setSKHeaderView:(SKParallaxHeaderView *)headerView {
    [self setTableHeaderView:headerView];
    
    [self setupTopBarViewWithHeader:headerView];
    [self setupBackgroundViewWithHeader:headerView];
}

-(void)setShowShadow:(BOOL)showShadow {
    _showShadow = showShadow;
    UIView *maskImg1 = [bgView viewWithTag:SHADOW_TAG];
    maskImg1.hidden = !showShadow;
    
    UIView *maskImg2 = [topBarView viewWithTag:SHADOW_TAG];
    maskImg2.hidden = !showShadow;
}

@end
