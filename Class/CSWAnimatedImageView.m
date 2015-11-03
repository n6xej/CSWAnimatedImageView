//
//  CSWAnimatedImageView.m
//  CSWAnimatedImageView
//
//  Created by Christopher Worley on 11/1/15.
//  Copyright © 2015 Christopher Worley. All rights reserved.
//

/*
 You can set the following User Defined Runtime Attributes
 in Interface Builder to override the default values
 
 duration : CGFloat
 reverse : BOOL
 colorOuter : UIColor
 colorInner : UIColor
 startPoint = CGPoint
 endPoint  = CGPoint
 imageName : NSString
 */

#import "CSWAnimatedImageView.h"

@implementation CSWAnimatedImageObject

- (id)init
{
	if (self = [super init])
	{
		_duration = 5.0;
		_reverse = NO;
		_colorOuter = [UIColor orangeColor];
		_colorInner = [UIColor yellowColor];
		_startPoint = CGPointMake(0.0, 0.5);
		_endPoint  = CGPointMake(1.0, 0.5);
		_imageName = @"hangglider.png";
	}
	return self;
}


@end


@interface CSWAnimatedImageView ()

@property (nonatomic, strong, readwrite) CSWAnimatedImageObject *animatedTextObject;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation CSWAnimatedImageView

-(id)initWithCoder:(NSCoder *)aDecoder {
	if(self = [super initWithCoder:aDecoder])
	{
		_animatedImageObject = [[CSWAnimatedImageObject alloc] init];

		_gradientLayer = [[CAGradientLayer alloc] init];
		_gradientLayer.startPoint = _startPoint;
		_gradientLayer.endPoint = _endPoint;
		_gradientLayer.locations = @[@0.25, @0.5,@0.75];
		
		[self.layer addSublayer:_gradientLayer];
		
		[self initDefaults];
	}
	
	return self;
}

/*
// defaults are needed because the variables have not been
// initialized with the Key Value Coding values from IB
- (void)initDefaults {
	self.duration = 4.0;
	self.reverse = NO;
	_colorOuter = [UIColor darkGrayColor];
	self.colorInner = [UIColor whiteColor];
	self.startPoint = CGPointMake(0.0, 0.5);
	self.endPoint  = CGPointMake(1.0, 0.5);

	 _animatedTextObject.colorOuter = _colorOuter;
	 _animatedTextObject.colorInner = _colorInner;
	 _animatedTextObject.startPoint = _startPoint;
	 _animatedTextObject.endPoint = _endPoint;
	 _animatedTextObject.duration = _duration;
	 _animatedTextObject.reverse = _reverse;
}
*/

// defaults are needed because the variables have not been
// initialized with the Key Value Coding values from IB
- (void)initDefaults {
	
	_colorOuter = _animatedTextObject.colorOuter;
	self.colorInner = _animatedTextObject.colorInner;
	self.startPoint = _animatedTextObject.startPoint;
	self.endPoint = _animatedTextObject.endPoint;
	self.duration = _animatedTextObject.duration;
	self.reverse = _animatedTextObject.reverse;
	self.imageName = _animatedTextObject.imageName;
}

- (void)setAnimatedImageObject:(CSWAnimatedImageObject *)animatedImageObject {
	_animatedImageObject = animatedImageObject;

	_colorOuter = _animatedImageObject.colorOuter;
	self.colorInner = _animatedImageObject.colorInner;
	self.startPoint = _animatedImageObject.startPoint;
	self.endPoint = _animatedImageObject.endPoint;
	self.duration = _animatedImageObject.duration;
	
	self.reverse = _animatedImageObject.reverse;
	self.imageName = _animatedImageObject.imageName;
}


- (void)layoutSubviews {
	_gradientLayer.frame = CGRectMake(
									  -self.bounds.size.width,
									  self.bounds.origin.y,
									  3 * self.bounds.size.width,
									  self.bounds.size.height);
}

- (void)didMoveToWindow {
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
	
	animation.fromValue = @[@0.0, @0.0, @0.30];
	animation.toValue = @[@0.70, @1.0, @1.0];
	animation.duration = _duration;
	animation.removedOnCompletion = NO;
	animation.repeatCount = INFINITY;
	animation.autoreverses = _reverse;

	[_gradientLayer addAnimation:animation forKey:nil];
}


- (void)updateImageMask {
	
	if (_imageName) {
		
		CALayer *maskLayer = [[CALayer alloc] init];
		maskLayer.backgroundColor = [UIColor clearColor].CGColor;
		maskLayer.frame = CGRectOffset(self.bounds, self.bounds.size.width, 0);
		maskLayer.contents = (id)[[UIImage imageNamed:_imageName] CGImage];

		_gradientLayer.mask = maskLayer;
	}
}

- (void)setImageName:(NSString *)imageName {
	_imageName = imageName;
	_animatedTextObject.imageName = imageName;
	
	[self updateImageMask];
}

- (void)setReverse:(BOOL)reverse {
	_reverse = reverse;
	
	_animatedTextObject.reverse = _reverse;
	
	[self didMoveToWindow];
}

- (void)setColorOuter:(UIColor *)color {
	
	_colorOuter = color;
	_animatedTextObject.colorOuter = _colorOuter;
	
	if (_colorInner) {
		_gradientLayer.colors = [NSArray arrayWithObjects:(id) _colorOuter.CGColor, (id) _colorInner.CGColor, (id) _colorOuter.CGColor, nil];
	}
}

- (void)setColorInner:(UIColor *)color {
	
	_colorInner = color;
	_animatedTextObject.colorInner = _colorInner;
	
	if (_colorOuter) {
		_gradientLayer.colors = [NSArray arrayWithObjects:(id) _colorOuter.CGColor, (id) _colorInner.CGColor, (id) _colorOuter.CGColor, nil];
	}
}

- (void)setDuration:(CGFloat)duration {
	
	_duration = duration;
	_animatedTextObject.duration = duration;
	
	[self didMoveToWindow];
}

- (void)setStartPoint:(CGPoint)startPoint {
	if ( (startPoint.x >= 0 && startPoint.x <= 1) && (startPoint.y >= 0 && startPoint.y <= 1)) {
		_startPoint = startPoint;
		_animatedTextObject.startPoint = _startPoint;
		
		_gradientLayer.startPoint = _startPoint;
	}
}

- (void)setEndPoint:(CGPoint)endPoint {
	
	if ( (endPoint.x >= 0 && endPoint.x <= 1) && (endPoint.y >= 0 && endPoint.y <= 1)) {
		_endPoint = endPoint;
		_animatedTextObject.endPoint = _endPoint;
		
		_gradientLayer.endPoint = _endPoint;
	}
}

@end
