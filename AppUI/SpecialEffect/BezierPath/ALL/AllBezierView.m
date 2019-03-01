//
//  AllBezierView.m
//  AppUI
//
//  Created by Himin on 2019/1/28.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "AllBezierView.h"

@implementation AllBezierView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.orangeColor;
        [self addShapeLayer];
    }
    return self;
}

- (void)addShapeLayer {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 420)];
    v.backgroundColor = UIColor.whiteColor;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = v.bounds;
    shapeLayer.backgroundColor = UIColor.lightGrayColor.CGColor;
    shapeLayer.path          = [self createBezierPath].CGPath;
    
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor   = UIColor.darkGrayColor.CGColor;
    shapeLayer.lineWidth     = 1.f;
    shapeLayer.position      = v.center;
    //    shapeLayer.shadowColor   = UIColor.darkGrayColor.CGColor;
    //    shapeLayer.shadowOpacity = 1.f;
    //    shapeLayer.shadowRadius  = 4.f;
    shapeLayer.lineCap       = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    
    [v.layer addSublayer:shapeLayer];
    v.center = self.center;
    [self addSubview:v];
}

- (UIBezierPath *)createBezierPath {
    // width = 300; height = 420;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // 外形
    [bezierPath moveToPoint : CGPointMake(84, 72)];
    [bezierPath addQuadCurveToPoint: CGPointMake(93, 1) controlPoint:CGPointMake(86, 41)];
    //    [bezierPath addLineToPoint: CGPointMake(93, 1)];//直线
    [bezierPath addQuadCurveToPoint: CGPointMake(122, 65) controlPoint:CGPointMake(109, 32)];
    //    [bezierPath addLineToPoint: CGPointMake(122, 65)];//直线
    [bezierPath addLineToPoint: CGPointMake(113, 68)];
    [bezierPath addLineToPoint: CGPointMake(117, 80)];
    [bezierPath addQuadCurveToPoint:CGPointMake(183, 80) controlPoint:CGPointMake(150, 68)];
    
    [bezierPath addLineToPoint: CGPointMake(187, 68)];
    [bezierPath addLineToPoint: CGPointMake(178, 65)];
    [bezierPath addQuadCurveToPoint: CGPointMake(207, 1) controlPoint:CGPointMake(191, 32)];
    //    [bezierPath addLineToPoint: CGPointMake(207, 1)];//直线
    [bezierPath addQuadCurveToPoint: CGPointMake(216, 72) controlPoint:CGPointMake(214, 41)];
    //    [bezierPath addLineToPoint: CGPointMake(216, 72)];//直线
    [bezierPath addLineToPoint: CGPointMake(205, 70)];
    [bezierPath addLineToPoint: CGPointMake(206, 89)];
    
    [bezierPath addQuadCurveToPoint:CGPointMake(253, 172) controlPoint:CGPointMake(250, 110)];
    [bezierPath addCurveToPoint:CGPointMake(280, 320) controlPoint1:CGPointMake(290, 200) controlPoint2:CGPointMake(320, 280)];
    [bezierPath addCurveToPoint:CGPointMake(150, 405) controlPoint1:CGPointMake(280, 380) controlPoint2:CGPointMake(200, 450)];
    [bezierPath addCurveToPoint:CGPointMake(20, 320) controlPoint1:CGPointMake(100, 450) controlPoint2:CGPointMake(20, 380)];
    [bezierPath addCurveToPoint:CGPointMake(47, 172) controlPoint1:CGPointMake(-20, 280) controlPoint2:CGPointMake(10, 200)];
    [bezierPath addQuadCurveToPoint:CGPointMake(95, 89) controlPoint:CGPointMake(50, 110)];
    
    [bezierPath addLineToPoint: CGPointMake(95, 70)];
    [bezierPath addLineToPoint: CGPointMake(84, 72)];
    
    //眼睛
    //左眼
    [bezierPath moveToPoint : CGPointMake(103, 128)];
    [bezierPath addArcWithCenter:CGPointMake(97, 128) radius:6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [bezierPath moveToPoint : CGPointMake(111, 126)];
    [bezierPath addArcWithCenter:CGPointMake(94, 126) radius:17 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //右眼
    [bezierPath moveToPoint : CGPointMake(209, 128)];
    [bezierPath addArcWithCenter:CGPointMake(203, 128) radius:6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [bezierPath moveToPoint : CGPointMake(223, 126)];
    [bezierPath addArcWithCenter:CGPointMake(206, 126) radius:17 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //鼻子
    [bezierPath moveToPoint:CGPointMake(133, 129)];
    [bezierPath addCurveToPoint:CGPointMake(167, 129) controlPoint1:CGPointMake(142, 122) controlPoint2:CGPointMake(158, 122)];
    [bezierPath addQuadCurveToPoint:CGPointMake(164, 134) controlPoint:CGPointMake(171, 132)];
    [bezierPath addQuadCurveToPoint:CGPointMake(136, 134) controlPoint:CGPointMake(150, 138)];
    [bezierPath addQuadCurveToPoint:CGPointMake(133, 129) controlPoint:CGPointMake(129, 132)];
    
    //胡须(左)
    [bezierPath moveToPoint:CGPointMake(86, 145)];
    [bezierPath addLineToPoint: CGPointMake(28, 140)];
    [bezierPath moveToPoint:CGPointMake(80, 152)];
    [bezierPath addLineToPoint: CGPointMake(0, 155)];
    [bezierPath moveToPoint:CGPointMake(73, 164)];
    [bezierPath addLineToPoint: CGPointMake(13, 170)];
    
    //胡须(右)
    [bezierPath moveToPoint:CGPointMake(214, 145)];
    [bezierPath addLineToPoint: CGPointMake(272, 140)];
    [bezierPath moveToPoint:CGPointMake(220, 152)];
    [bezierPath addLineToPoint: CGPointMake(300, 155)];
    [bezierPath moveToPoint:CGPointMake(227, 164)];
    [bezierPath addLineToPoint: CGPointMake(287, 170)];
    
    //肚子
    [bezierPath moveToPoint:CGPointMake(26, 290)];
    [bezierPath addCurveToPoint:CGPointMake(274, 290) controlPoint1:CGPointMake(30, 140) controlPoint2:CGPointMake(270, 140)];
    [bezierPath addCurveToPoint:CGPointMake(26, 290) controlPoint1:CGPointMake(275, 437) controlPoint2:CGPointMake(25, 437)];
    
    // 肚子月牙图案
    // 第一行
    //1
    [bezierPath moveToPoint:CGPointMake(80, 216)];
    [bezierPath addQuadCurveToPoint:CGPointMake(120, 216) controlPoint:CGPointMake(100, 187)];
    [bezierPath addQuadCurveToPoint:CGPointMake(80, 216) controlPoint:CGPointMake(100, 202)];
    
    //2
    [bezierPath moveToPoint:CGPointMake(130, 216)];
    [bezierPath addCurveToPoint:CGPointMake(170, 216) controlPoint1:CGPointMake(145, 196) controlPoint2:CGPointMake(155, 196)];
    [bezierPath addQuadCurveToPoint:CGPointMake(130, 216) controlPoint:CGPointMake(150, 202)];
    
    //3
    [bezierPath moveToPoint:CGPointMake(180, 216)];
    [bezierPath addQuadCurveToPoint:CGPointMake(220, 216) controlPoint:CGPointMake(200, 187)];
    [bezierPath addQuadCurveToPoint:CGPointMake(180, 216) controlPoint:CGPointMake(200, 202)];
    
    // 第二行
    //4
    [bezierPath moveToPoint:CGPointMake(50, 248)];
    [bezierPath addQuadCurveToPoint:CGPointMake(95, 248) controlPoint:CGPointMake(72.5, 219)];
    [bezierPath addQuadCurveToPoint:CGPointMake(50, 248) controlPoint:CGPointMake(72.5, 234)];
    
    //5
    [bezierPath moveToPoint:CGPointMake(100, 248)];
    [bezierPath addQuadCurveToPoint:CGPointMake(145, 248) controlPoint:CGPointMake(122.5, 219)];
    [bezierPath addQuadCurveToPoint:CGPointMake(100, 248) controlPoint:CGPointMake(122.5, 234)];
    
    //6
    [bezierPath moveToPoint:CGPointMake(155, 248)];
    [bezierPath addQuadCurveToPoint:CGPointMake(200, 248) controlPoint:CGPointMake(177.5, 219)];
    [bezierPath addQuadCurveToPoint:CGPointMake(155, 248) controlPoint:CGPointMake(177.5, 234)];
    
    //7
    [bezierPath moveToPoint:CGPointMake(205, 248)];
    [bezierPath addQuadCurveToPoint:CGPointMake(250, 248) controlPoint:CGPointMake(227.5, 219)];
    [bezierPath addQuadCurveToPoint:CGPointMake(205, 248) controlPoint:CGPointMake(227.5, 234)];
    
    return bezierPath;
}

@end
