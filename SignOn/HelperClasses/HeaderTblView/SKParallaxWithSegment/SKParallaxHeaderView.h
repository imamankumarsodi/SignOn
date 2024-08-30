//
//  DTHeaderView.h
//
//  Created by ToanDK on 4/24/15.
//  Copyright (c) 2015 ToanDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKParallaxHeaderView : UIView {

}

@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, assign) UIImage *bgImage;
@property (nonatomic, assign) UIView *myTopView;

@property (nonatomic, strong) UIView *tabBarView;


//-(id)initWithFrame:(CGRect)frame withImage:(UIImage*)image withTabBar:(UIView*)tabbar;

//-(id)initWithFrame:(CGRect)frame withImageUrl:(NSURL*)url withTabBar:(UIView*)tabbar;

-(id)initWithFrame:(CGRect)frame withView:(UIView*)myView withTabBar:(UIView*)tabbar;

-(id)initWithFrame:(CGRect)frame withImageUrl:(NSURL*)url withTabBar:(UIView*)tabbar;

@end
