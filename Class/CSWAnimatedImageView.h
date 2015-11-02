//
//  CSWAnimatedImageView.h
//  CSWAnimatedImageView
//
//  Created by Christopher Worley on 11/1/15.
//  Copyright © 2015 Christopher Worley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSWAnimatedImageObject : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIColor *colorOuter;
@property (nonatomic, strong) UIColor *colorInner;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGFloat duration;
@property (nonatomic) BOOL reverse;

@end

IB_DESIGNABLE @interface CSWAnimatedImageView : UIView

@property (nonatomic, strong, readonly) CSWAnimatedImageObject *animatedImageObject;

@property (nonatomic, strong) IBInspectable UIColor *colorOuter;
@property (nonatomic, strong) IBInspectable UIColor *colorInner;
@property (nonatomic, strong) IBInspectable NSString *imageName;
@property (nonatomic) IBInspectable CGPoint startPoint;
@property (nonatomic) IBInspectable CGPoint endPoint;
@property (nonatomic) IBInspectable CGFloat duration;
@property (nonatomic) IBInspectable BOOL reverse;


- (void)setAnimatedImageObject:(CSWAnimatedImageObject *)animatedImageObject;
@end
