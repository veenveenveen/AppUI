//
//  SandClockView.m
//  TestAll
//
//  Created by 黄启明 on 2018/11/6.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "SandClockView.h"

//#define SandClockFillColor [UIColor colorWithRed:79.0/255.0 green:152.0/255.0 blue:198.0/255.0 alpha:1.0]

//#define SandClockFillColor [UIColor colorWithRed:205.0/255.0 green:169.0/255.0 blue:116.0/255.0 alpha:0.8]
//#define SandClockFrameColor [UIColor colorWithRed:151.0/255.0 green:192.0/255.0 blue:214.0/255.0 alpha:0.8]

#define SandClockFillColor [UIColor colorWithWhite:0.5 alpha:1]
#define SandClockFrameColor [UIColor colorWithWhite:0.8 alpha:1]

static const CGFloat kSandClockLength = 20;
static const NSTimeInterval kSandClockAnimationDuration = 2.5;

@interface SandClockView ()

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

// 视图
@property (nonatomic, strong) CALayer *containerLayer;          // 沙漏 父容器
@property (nonatomic, strong) CAShapeLayer *topLayer;           // 沙漏 上半部分
@property (nonatomic, strong) CAShapeLayer *bottomLayer;        // 沙漏 下半部分
@property (nonatomic, strong) CAShapeLayer *lineLayer;          // 沙漏 漏线
@property (nonatomic, strong) CAShapeLayer *frameLayer;         // 沙漏 边框
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;    // 沙漏 背景

// 动画
@property (nonatomic, strong) CAKeyframeAnimation *containerAnimation;
@property (nonatomic, strong) CAKeyframeAnimation *topAnimation;
@property (nonatomic, strong) CAKeyframeAnimation *bottomAnimation;
@property (nonatomic, strong) CAKeyframeAnimation *lineAnimation;

// 加载文字
//@property (nonatomic, strong) UILabel *loadingText;

@end

@implementation SandClockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupAnimation];
    }
    return self;
}

- (void)setupLayer {
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    [self.layer addSublayer:self.containerLayer];
//    [self.containerLayer addSublayer:self.backgroundLayer];
    [self.containerLayer addSublayer:self.topLayer];
    [self.containerLayer addSublayer:self.bottomLayer];
    [self.containerLayer addSublayer:self.lineLayer];
    [self.containerLayer addSublayer:self.frameLayer];
}

// animation

- (void)startAnimation {
    [self.topLayer addAnimation:_topAnimation forKey:@"topAnimation"];
    [self.bottomLayer addAnimation:_bottomAnimation forKey:@"bottomAnimation"];
    [self.lineLayer addAnimation:_lineAnimation forKey:@"lineAnimation"];
    [self.containerLayer addAnimation:_containerAnimation forKey:@"containerAnimation"];
}

- (void)stopAnimation {
    [self.topLayer removeAllAnimations];
    [self.bottomLayer removeAllAnimations];
    [self.lineLayer removeAllAnimations];
    [self.containerLayer removeAllAnimations];
}

- (void)setupAnimation {
    //top 动画 按比例放大缩小动画
    _topAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    _topAnimation.duration = kSandClockAnimationDuration;
    _topAnimation.repeatCount = MAXFLOAT;
    _topAnimation.keyTimes = @[@0.0,@0.6,@0.8,@1.0];
    _topAnimation.values = @[@1.0,@0.4,@0.0,@0.0];
    //bottom 动画 按比例放大缩小动画
    _bottomAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    _bottomAnimation.duration = kSandClockAnimationDuration;
    _bottomAnimation.repeatCount = MAXFLOAT;
    _bottomAnimation.keyTimes = @[@0.12,@0.8,@1.0];
    _bottomAnimation.values = @[@0.05,@1.0,@1.0];
    //line 动画 颜色从无到有
    _lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    _lineAnimation.duration = kSandClockAnimationDuration;
    _lineAnimation.repeatCount = MAXFLOAT;
    _lineAnimation.keyTimes = @[@0.0,@0.12];
    _lineAnimation.values = @[@0.0,@1.0];
    //container 动画 按z轴旋转动画
    _containerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    _containerAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.1 :1 :0.8 :0.0];
    _containerAnimation.duration = kSandClockAnimationDuration;
    _containerAnimation.repeatCount = MAXFLOAT;
    _containerAnimation.keyTimes = @[@0.8,@1.0];
    _containerAnimation.values = @[@0.0,@M_PI];
}


// layer

- (CALayer *)containerLayer {
    if (!_containerLayer) {
        _containerLayer = [CALayer layer];
        _containerLayer.backgroundColor = UIColor.clearColor.CGColor;
        _containerLayer.frame = CGRectMake((self.frame.size.width-self.width)*0.5, (self.frame.size.height-self.height*2)*0.5, self.width, self.height*2);
    }
    return _containerLayer;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        UIBezierPath *path = UIBezierPath.bezierPath;
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.width, 0)];
        [path addLineToPoint:CGPointMake(self.width*0.5, self.height)];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path closePath];
        
        _topLayer = [CAShapeLayer layer];
        _topLayer.frame = CGRectMake(0, 0, self.width, self.height);
        _topLayer.path = path.CGPath;
        _topLayer.fillColor = SandClockFillColor.CGColor;
        _topLayer.anchorPoint = CGPointMake(0.5, 1);
        _topLayer.position = CGPointMake(self.width*0.5, self.height);
    }
    return _topLayer;
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        UIBezierPath *path = UIBezierPath.bezierPath;
        [path moveToPoint:CGPointMake(self.width*0.5, 0)];
        [path addLineToPoint:CGPointMake(self.width, self.height)];
        [path addLineToPoint:CGPointMake(0, self.height)];
        [path addLineToPoint:CGPointMake(self.width*0.5, 0)];
        [path closePath];
        
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.frame = CGRectMake(0, 0, self.width, self.height);
        _bottomLayer.path = path.CGPath;
        _bottomLayer.fillColor = SandClockFillColor.CGColor;
        _bottomLayer.anchorPoint = CGPointMake(0.5, 1);
        _bottomLayer.position = CGPointMake(self.width*0.5, self.height*2);
    }
    return _bottomLayer;
}

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        UIBezierPath *path = UIBezierPath.bezierPath;
        [path moveToPoint:CGPointMake(self.width*0.5, 0)];
        [path addLineToPoint:CGPointMake(self.width*0.5, self.height)];
        
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.frame = CGRectMake(0, self.height, self.width, self.height);
        _lineLayer.path = path.CGPath;
        _lineLayer.strokeColor = SandClockFillColor.CGColor;
        _lineLayer.lineWidth = 1;
        _lineLayer.lineJoin = kCALineJoinMiter;//设置线段的连接方式棱角 kCALineJoinMiter;平滑 kCALineJoinRound;折线 kCALineJoinBevel
        _lineLayer.lineDashPattern = @[@2.0,@1.0];
        _lineLayer.lineDashPhase = 0;
        _lineLayer.strokeEnd = 0;
    }
    return _lineLayer;
}

- (CAShapeLayer *)frameLayer {
    if (!_frameLayer) {
//        UIBezierPath *path = UIBezierPath.bezierPath;
//        [path moveToPoint:CGPointMake(0, 0)];
//        [path addLineToPoint:CGPointMake(self.width, 0)];
//        [path addLineToPoint:CGPointMake(0, self.height*2)];
//        [path addLineToPoint:CGPointMake(self.width, self.height*2)];
//        [path addLineToPoint:CGPointMake(0, 0)];
//        [path closePath];
        UIBezierPath *path = UIBezierPath.bezierPath;
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.width, 0)];
        [path addLineToPoint:CGPointMake(self.width*0.5+0.577, self.height-1)];
        [path addLineToPoint:CGPointMake(self.width*0.5+0.577, self.height+1)];
        [path addLineToPoint:CGPointMake(self.width, self.height*2)];
        [path addLineToPoint:CGPointMake(0, self.height*2)];
        [path addLineToPoint:CGPointMake(self.width*0.5-0.577, self.height+1)];
        [path addLineToPoint:CGPointMake(self.width*0.5-0.577, self.height-1)];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path closePath];
        
        _frameLayer = [CAShapeLayer layer];
        _frameLayer.frame = CGRectMake(0, 0, self.width, self.height*2);
        _frameLayer.path = path.CGPath;
        _frameLayer.strokeColor = SandClockFrameColor.CGColor;
        _frameLayer.fillColor = UIColor.clearColor.CGColor;
        _frameLayer.lineWidth = 2;
    }
    return _frameLayer;
}

//- (CAShapeLayer *)backgroundLayer {
//    if (!_backgroundLayer) {
//        //        UIBezierPath *path = UIBezierPath.bezierPath;
//        //        [path moveToPoint:CGPointMake(0, 0)];
//        //        [path addLineToPoint:CGPointMake(self.width, 0)];
//        //        [path addLineToPoint:CGPointMake(0, self.height*2)];
//        //        [path addLineToPoint:CGPointMake(self.width, self.height*2)];
//        //        [path addLineToPoint:CGPointMake(0, 0)];
//        //        [path closePath];
//        UIBezierPath *path = UIBezierPath.bezierPath;
//        [path moveToPoint:CGPointMake(0, 0)];
//        [path addLineToPoint:CGPointMake(self.width, 0)];
//        [path addLineToPoint:CGPointMake(self.width*0.5+0.577, self.height-1)];
//        [path addLineToPoint:CGPointMake(self.width*0.5+0.577, self.height+1)];
//        [path addLineToPoint:CGPointMake(self.width, self.height*2)];
//        [path addLineToPoint:CGPointMake(0, self.height*2)];
//        [path addLineToPoint:CGPointMake(self.width*0.5-0.577, self.height+1)];
//        [path addLineToPoint:CGPointMake(self.width*0.5-0.577, self.height-1)];
//        [path addLineToPoint:CGPointMake(0, 0)];
//        [path closePath];
//
//        _backgroundLayer = [CAShapeLayer layer];
//        _backgroundLayer.frame = CGRectMake(0, 0, self.width, self.height*2);
//        _backgroundLayer.path = path.CGPath;
//        _backgroundLayer.strokeColor = SandClockFrameColor.CGColor;
//        _backgroundLayer.fillColor = SandClockFrameColor.CGColor;
//    }
//    return _backgroundLayer;
//}

// readonly property

- (CGFloat)width {
    return kSandClockLength*1.1;
}

- (CGFloat)height {
    return sqrt(pow(kSandClockLength, 2) - pow(self.width*0.5, 2));
}

@end
