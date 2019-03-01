//
//  XYZOrbitView.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/12.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "XYZOrbitView.h"

#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height

#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height

// 背景圆宽度 视图背景宽度除以3
#define bgCircleWidth (self.frame.size.width / 3)
// 轨道圆宽度
#define orbitCircleWidth (bgCircleWidth + 10)
// 点视图宽度
#define pointContainerWidth (bgCircleWidth * 2)

@interface XYZOrbitView ()

@property (nonatomic, strong) CABasicAnimation *xRotationForHorizontalRing;
@property (nonatomic, strong) CABasicAnimation *zRotationForHorizontalRing;

@property (nonatomic, strong) CABasicAnimation *yRotationForVerticalRing;
@property (nonatomic, strong) CABasicAnimation *zRotationForVerticalRing;

@property (nonatomic, strong) CABasicAnimation *xRotationForPointContainer1;
@property (nonatomic, strong) CABasicAnimation *zRotationForPointContainer1;

@property (nonatomic, strong) CABasicAnimation *yRotationForPointContainer2;
@property (nonatomic, strong) CABasicAnimation *zRotationForPointContainer2;

@end


@implementation XYZOrbitView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)launchOrbit {
    [self setupUI];
}

#pragma mark - private

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    self.layer.cornerRadius = 10;
    [self createBackgroundView];
    [self createRingViews];
    [self createStarViews];
}

// 创建背景圆
- (void)createBackgroundView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((selfWidth-bgCircleWidth)*0.5, (selfHeight-bgCircleWidth)*0.5, bgCircleWidth, bgCircleWidth)];
    bgView.backgroundColor = self.backgroundColor;
    bgView.layer.cornerRadius = bgCircleWidth * 0.5;
    bgView.layer.borderWidth = 2;
    bgView.layer.borderColor = UIColor.blackColor.CGColor;
    [self addSubview:bgView];
    // 创建月牙阴影
    CGFloat radius = bgCircleWidth/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius-2 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:true];
    [path addCurveToPoint:CGPointMake(radius, 2) controlPoint1:CGPointMake(radius*1.8, radius) controlPoint2:CGPointMake(radius, 2)];
    [path closePath];
    
    CAShapeLayer *crescentLayer = [CAShapeLayer layer];
    crescentLayer.path = path.CGPath;
    crescentLayer.fillRule = kCAFillRuleNonZero;
    crescentLayer.fillMode = kCAFillModeForwards;
    crescentLayer.fillColor = [UIColor colorWithWhite:0.96 alpha:1].CGColor;
    [bgView.layer addSublayer:crescentLayer];
}

// 创建轨迹(ring)圆
- (void)createRingViews {
    UIView *horizontalRing = [[UIView alloc] initWithFrame:CGRectMake((selfWidth-orbitCircleWidth)*0.5, (selfHeight-orbitCircleWidth)*0.5, orbitCircleWidth, orbitCircleWidth)];
    horizontalRing.backgroundColor = UIColor.clearColor;
    horizontalRing.layer.cornerRadius = orbitCircleWidth * 0.5;
    horizontalRing.layer.borderWidth = 1;
    horizontalRing.layer.borderColor = UIColor.blackColor.CGColor;
    [horizontalRing.layer addAnimation:self.xRotationForHorizontalRing forKey:@"xRotationForHorizontalRing"];
    [horizontalRing.layer addAnimation:self.zRotationForHorizontalRing forKey:@"zRotationForHorizontalRing"];
    [self addSubview:horizontalRing];
    
    UIView *vertivalRing = [[UIView alloc] initWithFrame:CGRectMake((selfWidth-orbitCircleWidth)*0.5, (selfHeight-orbitCircleWidth)*0.5, orbitCircleWidth, orbitCircleWidth)];
    vertivalRing.backgroundColor = UIColor.clearColor;
    vertivalRing.layer.cornerRadius = orbitCircleWidth * 0.5;
    vertivalRing.layer.borderWidth = 1;
    vertivalRing.layer.borderColor = UIColor.blackColor.CGColor;
    [vertivalRing.layer addAnimation:self.yRotationForVerticalRing forKey:@"yRotationForVerticalRing"];
    [vertivalRing.layer addAnimation:self.zRotationForVerticalRing forKey:@"zRotationForVerticalRing"];
    [self addSubview:vertivalRing];
}

// 创建点(star)视图
- (void)createStarViews {
    UIView *pointContainer_1 = [[UIView alloc] initWithFrame:CGRectMake((selfWidth-pointContainerWidth)*0.5, (selfHeight-pointContainerWidth)*0.5, pointContainerWidth, pointContainerWidth)];
    pointContainer_1.backgroundColor = UIColor.clearColor;
    [self addSubview:pointContainer_1];
    
    UIView *pointContainer_2 = [[UIView alloc] initWithFrame:CGRectMake((selfWidth-pointContainerWidth)*0.5, (selfHeight-pointContainerWidth)*0.5, pointContainerWidth, pointContainerWidth)];
    pointContainer_2.backgroundColor = UIColor.clearColor;
    [self addSubview:pointContainer_2];
    
    CGFloat pointWidth = 4;
    UIView *point1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pointWidth, pointWidth)];
    point1.backgroundColor = UIColor.blackColor;
    point1.layer.cornerRadius = pointWidth*0.5;
    [pointContainer_1 addSubview:point1];
    
    UIView *point2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pointWidth, pointWidth)];
    point2.backgroundColor = UIColor.blackColor;
    point2.layer.cornerRadius = pointWidth*0.5;
    [pointContainer_2 addSubview:point2];
    
    [point1.layer addAnimation:[self positionAnimation:pointContainer_1.bounds duration:3] forKey:@"point1"];
    [point2.layer addAnimation:[self positionAnimation:pointContainer_2.bounds duration:3] forKey:@"point2"];
    
    [pointContainer_1.layer addAnimation:self.xRotationForPointContainer1 forKey:@"xRotationForPointContainer1"];
    [pointContainer_1.layer addAnimation:self.zRotationForPointContainer1 forKey:@"zRotationForPointContainer1"];

    [pointContainer_2.layer addAnimation:self.yRotationForPointContainer2 forKey:@"yRotationForPointContainer2"];
    [pointContainer_2.layer addAnimation:self.zRotationForPointContainer2 forKey:@"zRotationForPointContainer2"];
}

#pragma mark - animation

// HorizontalRing
- (CABasicAnimation *)xRotationForHorizontalRing {
    if (!_xRotationForHorizontalRing) {
        _xRotationForHorizontalRing = [self basicAnimationWith:@"transform.rotation.x" fromValue:M_PI_2 toValue:-M_PI_2 repeatCount:MAXFLOAT duration:4.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:NO];
    }
    return _xRotationForHorizontalRing;
}
- (CABasicAnimation *)zRotationForHorizontalRing {
    if (!_zRotationForHorizontalRing) {
        _zRotationForHorizontalRing = [self basicAnimationWith:@"transform.rotation.z" fromValue:M_PI/6 toValue:-M_PI/6 repeatCount:MAXFLOAT duration:4.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:YES];
    }
    return _zRotationForHorizontalRing;
}

// VerticalRing
- (CABasicAnimation *)yRotationForVerticalRing {
    if (!_yRotationForVerticalRing) {
        _yRotationForVerticalRing = [self basicAnimationWith:@"transform.rotation.y" fromValue:M_PI*3/8 toValue:M_PI*5/8 repeatCount:MAXFLOAT duration:6.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:YES];
    }
    return _yRotationForVerticalRing;
}
- (CABasicAnimation *)zRotationForVerticalRing {
    if (!_zRotationForVerticalRing) {
        _zRotationForVerticalRing = [self basicAnimationWith:@"transform.rotation.z" fromValue:M_PI/6 toValue:-M_PI/6 repeatCount:MAXFLOAT duration:6.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:YES];
    }
    return _zRotationForVerticalRing;
}

// PointContainer_1
- (CABasicAnimation *)xRotationForPointContainer1 {
    if (!_xRotationForPointContainer1) {
        _xRotationForPointContainer1 = [self basicAnimationWith:@"transform.rotation.x" fromValue:M_PI*1.6/4-0.001 toValue:M_PI*1.6/4+0.001 repeatCount:MAXFLOAT duration:6.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:YES];
    }
    return _xRotationForPointContainer1;
}
- (CABasicAnimation *)zRotationForPointContainer1 {
    if (!_zRotationForPointContainer1) {
        _zRotationForPointContainer1 = [self basicAnimationWith:@"transform.rotation.z" fromValue:0 toValue:M_PI*2 repeatCount:MAXFLOAT duration:6.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:NO];
    }
    return _zRotationForPointContainer1;
}

// PointContainer_2
- (CABasicAnimation *)yRotationForPointContainer2 {
    if (!_yRotationForPointContainer2) {
        _yRotationForPointContainer2 = [self basicAnimationWith:@"transform.rotation.y" fromValue:M_PI*1.6/4-0.0001 toValue:M_PI*1.6/4+0.0001 repeatCount:MAXFLOAT duration:6.0 timingFunctionName:kCAMediaTimingFunctionLinear autoreverses:YES];
    }
    return _yRotationForPointContainer2;
}
- (CABasicAnimation *)zRotationForPointContainer2 {
    if (!_zRotationForPointContainer2) {
        _zRotationForPointContainer2 = [self basicAnimationWith:@"transform.rotation.z" fromValue:0 toValue:M_PI*2 repeatCount:MAXFLOAT duration:6.0 timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut autoreverses:NO];
    }
    return _zRotationForPointContainer2;
}

// 动画创建方法
- (CABasicAnimation *)basicAnimationWith:(NSString *)keyPath fromValue:(CGFloat)from toValue:(CGFloat)to repeatCount:(CGFloat)repeatCount duration:(CFTimeInterval)duration timingFunctionName:(NSString *)name autoreverses:(BOOL)autoreverses {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    basicAnimation.fromValue = @(from);
    basicAnimation.toValue = @(to);
    basicAnimation.repeatCount = repeatCount;
    basicAnimation.duration = duration;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:name];
    basicAnimation.autoreverses = autoreverses;
    return basicAnimation;
    
}

- (CAKeyframeAnimation *)positionAnimation:(CGRect)rect duration:(CFTimeInterval)duration {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width * 0.5];
    CAKeyframeAnimation *an = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    an.path = path.CGPath;
    an.rotationMode = kCAAnimationRotateAuto;
    an.calculationMode = kCAAnimationPaced;
    an.duration = duration;
    an.repeatCount = MAXFLOAT;
    return an;
}

@end
