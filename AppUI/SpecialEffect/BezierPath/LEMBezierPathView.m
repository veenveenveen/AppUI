//
//  LEMBezierPathView.m
//  AppUI
//
//  Created by Himin on 2019/1/28.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMBezierPathView.h"

@interface LEMBezierPathView ()

@property (nonatomic, strong) UIView *bezierView;

@end

@implementation LEMBezierPathView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"cddeef"];
        [self addShapeLayer];
    }
    return self;
}

- (void)addShapeLayer {
    // width = 300; height = 420;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 420)];
    v.backgroundColor = UIColor.whiteColor;
    v.center = self.center;
    self.bezierView = v;
    [self addSubview:self.bezierView];
    
    // 外形
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    
    [shapePath moveToPoint : CGPointMake(84, 72)];
    [shapePath addQuadCurveToPoint: CGPointMake(93, 1) controlPoint:CGPointMake(86, 41)];
//    [shapePath addLineToPoint: CGPointMake(93, 1)];//直线
    [shapePath addQuadCurveToPoint: CGPointMake(122, 65) controlPoint:CGPointMake(109, 32)];
//    [shapePath addLineToPoint: CGPointMake(122, 65)];//直线
    [shapePath addLineToPoint: CGPointMake(113, 68)];
    [shapePath addLineToPoint: CGPointMake(117, 80)];
    [shapePath addQuadCurveToPoint:CGPointMake(183, 80) controlPoint:CGPointMake(150, 68)];
    
    [shapePath addLineToPoint: CGPointMake(187, 68)];
    [shapePath addLineToPoint: CGPointMake(178, 65)];
    [shapePath addQuadCurveToPoint: CGPointMake(207, 1) controlPoint:CGPointMake(191, 32)];
//    [shapePath addLineToPoint: CGPointMake(207, 1)];//直线
    [shapePath addQuadCurveToPoint: CGPointMake(216, 72) controlPoint:CGPointMake(214, 41)];
//    [shapePath addLineToPoint: CGPointMake(216, 72)];//直线
    [shapePath addLineToPoint: CGPointMake(205, 70)];
    [shapePath addLineToPoint: CGPointMake(206, 89)];
    
    [shapePath addQuadCurveToPoint:CGPointMake(253, 172) controlPoint:CGPointMake(250, 110)];
    [shapePath addCurveToPoint:CGPointMake(280, 320) controlPoint1:CGPointMake(290, 200) controlPoint2:CGPointMake(320, 280)];
    [shapePath addCurveToPoint:CGPointMake(150, 405) controlPoint1:CGPointMake(280, 380) controlPoint2:CGPointMake(200, 450)];
    [shapePath addCurveToPoint:CGPointMake(20, 320) controlPoint1:CGPointMake(100, 450) controlPoint2:CGPointMake(20, 380)];
    [shapePath addCurveToPoint:CGPointMake(47, 172) controlPoint1:CGPointMake(-20, 280) controlPoint2:CGPointMake(10, 200)];
    [shapePath addQuadCurveToPoint:CGPointMake(95, 89) controlPoint:CGPointMake(50, 110)];
    
    [shapePath addLineToPoint: CGPointMake(95, 70)];
    [shapePath addLineToPoint: CGPointMake(84, 72)];
    
    CAShapeLayer *shapeLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    shapeLayer.path          = shapePath.CGPath;

    [self addAnimationWithDuration:5 onLayer:shapeLayer delay:0];
    
    
    //眼睛
    UIBezierPath *eyeOuterPath = [UIBezierPath bezierPath];
    UIBezierPath *eyeInnerPath = [UIBezierPath bezierPath];
    //左眼
    [eyeInnerPath moveToPoint : CGPointMake(103, 128)];
    [eyeInnerPath addArcWithCenter:CGPointMake(97, 128) radius:6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [eyeOuterPath moveToPoint : CGPointMake(111, 126)];
    [eyeOuterPath addArcWithCenter:CGPointMake(94, 126) radius:17 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //右眼
    [eyeInnerPath moveToPoint : CGPointMake(209, 128)];
    [eyeInnerPath addArcWithCenter:CGPointMake(203, 128) radius:6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [eyeOuterPath moveToPoint : CGPointMake(223, 126)];
    [eyeOuterPath addArcWithCenter:CGPointMake(206, 126) radius:17 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *eyeOuterLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    eyeOuterLayer.path          = eyeOuterPath.CGPath;
    
    CAShapeLayer *eyeInnerLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    eyeInnerLayer.path          = eyeInnerPath.CGPath;
    
    [self addAnimationWithDuration:1 onLayer:eyeOuterLayer delay:5];
    [self addAnimationWithDuration:1 onLayer:eyeInnerLayer delay:6];
    

    //鼻子
    UIBezierPath *nosePath = [UIBezierPath bezierPath];
    [nosePath moveToPoint:CGPointMake(133, 129)];
    [nosePath addCurveToPoint:CGPointMake(167, 129) controlPoint1:CGPointMake(142, 122) controlPoint2:CGPointMake(158, 122)];
    [nosePath addQuadCurveToPoint:CGPointMake(164, 134) controlPoint:CGPointMake(171, 132)];
    [nosePath addQuadCurveToPoint:CGPointMake(136, 134) controlPoint:CGPointMake(150, 138)];
    [nosePath addQuadCurveToPoint:CGPointMake(133, 129) controlPoint:CGPointMake(129, 132)];
    
    CAShapeLayer *noseLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    noseLayer.path          = nosePath.CGPath;
    
    [self addAnimationWithDuration:1 onLayer:noseLayer delay:7];
    
    //胡须
    UIBezierPath *beardPath = [UIBezierPath bezierPath];
    //胡须(左)
    [beardPath moveToPoint:CGPointMake(86, 145)];
    [beardPath addLineToPoint: CGPointMake(28, 140)];
    [beardPath moveToPoint:CGPointMake(80, 152)];
    [beardPath addLineToPoint: CGPointMake(0, 155)];
    [beardPath moveToPoint:CGPointMake(73, 164)];
    [beardPath addLineToPoint: CGPointMake(13, 170)];
    //胡须(右)
    [beardPath moveToPoint:CGPointMake(214, 145)];
    [beardPath addLineToPoint: CGPointMake(272, 140)];
    [beardPath moveToPoint:CGPointMake(220, 152)];
    [beardPath addLineToPoint: CGPointMake(300, 155)];
    [beardPath moveToPoint:CGPointMake(227, 164)];
    [beardPath addLineToPoint: CGPointMake(287, 170)];
    
    CAShapeLayer *beardLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    beardLayer.path          = beardPath.CGPath;
    
    [self addAnimationWithDuration:1 onLayer:beardLayer delay:8];
    
    //肚子
    UIBezierPath *bellyPath = [UIBezierPath bezierPath];
    [bellyPath moveToPoint:CGPointMake(26, 290)];
    [bellyPath addCurveToPoint:CGPointMake(274, 290) controlPoint1:CGPointMake(30, 140) controlPoint2:CGPointMake(270, 140)];
    [bellyPath addCurveToPoint:CGPointMake(26, 290) controlPoint1:CGPointMake(275, 437) controlPoint2:CGPointMake(25, 437)];
    
    CAShapeLayer *bellyLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    bellyLayer.path          = bellyPath.CGPath;
    
    [self addAnimationWithDuration:1 onLayer:bellyLayer delay:9];
    
    // 肚子月牙图案
    UIBezierPath *crescentPath = [UIBezierPath bezierPath];
    // 第一行
    //1
    [crescentPath moveToPoint:CGPointMake(80, 216)];
    [crescentPath addQuadCurveToPoint:CGPointMake(120, 216) controlPoint:CGPointMake(100, 187)];
    [crescentPath addQuadCurveToPoint:CGPointMake(80, 216) controlPoint:CGPointMake(100, 202)];
    
    //2
    [crescentPath moveToPoint:CGPointMake(130, 216)];
    [crescentPath addCurveToPoint:CGPointMake(170, 216) controlPoint1:CGPointMake(145, 196) controlPoint2:CGPointMake(155, 196)];
    [crescentPath addQuadCurveToPoint:CGPointMake(130, 216) controlPoint:CGPointMake(150, 202)];

    //3
    [crescentPath moveToPoint:CGPointMake(180, 216)];
    [crescentPath addQuadCurveToPoint:CGPointMake(220, 216) controlPoint:CGPointMake(200, 187)];
    [crescentPath addQuadCurveToPoint:CGPointMake(180, 216) controlPoint:CGPointMake(200, 202)];

    // 第二行
    //4
    [crescentPath moveToPoint:CGPointMake(50, 248)];
    [crescentPath addQuadCurveToPoint:CGPointMake(95, 248) controlPoint:CGPointMake(72.5, 219)];
    [crescentPath addQuadCurveToPoint:CGPointMake(50, 248) controlPoint:CGPointMake(72.5, 234)];

    //5
    [crescentPath moveToPoint:CGPointMake(100, 248)];
    [crescentPath addQuadCurveToPoint:CGPointMake(145, 248) controlPoint:CGPointMake(122.5, 219)];
    [crescentPath addQuadCurveToPoint:CGPointMake(100, 248) controlPoint:CGPointMake(122.5, 234)];

    //6
    [crescentPath moveToPoint:CGPointMake(155, 248)];
    [crescentPath addQuadCurveToPoint:CGPointMake(200, 248) controlPoint:CGPointMake(177.5, 219)];
    [crescentPath addQuadCurveToPoint:CGPointMake(155, 248) controlPoint:CGPointMake(177.5, 234)];

    //7
    [crescentPath moveToPoint:CGPointMake(205, 248)];
    [crescentPath addQuadCurveToPoint:CGPointMake(250, 248) controlPoint:CGPointMake(227.5, 219)];
    [crescentPath addQuadCurveToPoint:CGPointMake(205, 248) controlPoint:CGPointMake(227.5, 234)];
    
    CAShapeLayer *crescentLayer = [self createShapeLayerWithFrame:v.bounds fillColor:UIColor.clearColor];
    crescentLayer.path          = crescentPath.CGPath;
    
    [self addAnimationWithDuration:4 onLayer:crescentLayer delay:10];
    
    [self setLayerColor:shapeLayer color:[UIColor colorWithHexString:@"889289"] delay:14];
    [self setLayerColor:eyeOuterLayer color:[UIColor colorWithHexString:@"ffffff"] delay:14];
    [self setLayerColor:eyeInnerLayer color:[UIColor colorWithHexString:@"111111"] delay:14];
    [self setLayerColor:noseLayer color:[UIColor colorWithHexString:@"505A50"] delay:14];
    [self setLayerColor:beardLayer color:[UIColor colorWithHexString:@"000000"] delay:14];
    [self setLayerColor:bellyLayer color:[UIColor colorWithHexString:@"D4D2B1"] delay:14];
    [self setLayerColor:crescentLayer color:[UIColor colorWithHexString:@"889289"] delay:14];
}

- (CAShapeLayer *)createShapeLayerWithFrame:(CGRect)frame fillColor:(UIColor *)fillColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = frame;
    shapeLayer.backgroundColor = UIColor.clearColor.CGColor;

    shapeLayer.fillColor     = fillColor.CGColor;
    shapeLayer.strokeColor   = UIColor.darkGrayColor.CGColor;
    shapeLayer.lineWidth     = 1.f;
    shapeLayer.lineCap       = kCALineCapRound;
    shapeLayer.lineJoin      = kCALineJoinRound;
    
    return shapeLayer;
}

// 设置背景色
- (void)setLayerColor:(CAShapeLayer *)layer color:(UIColor *)color delay:(CFTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.fillColor = color.CGColor;
    });
}

// 设置动画
- (void)addAnimationWithDuration:(NSTimeInterval)duration onLayer:(CAShapeLayer *)layer delay:(CFTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:0];
        aniEnd.toValue             = [NSNumber numberWithFloat:1];
        aniEnd.duration            = duration;
        [layer addAnimation:aniEnd forKey:nil];
        [self.bezierView.layer addSublayer:layer];
    });
}

@end
