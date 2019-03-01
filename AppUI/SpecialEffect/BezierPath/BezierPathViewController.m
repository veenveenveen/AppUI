//
//  BezierPathViewController.m
//  Animations
//
//  Created by YouXianMing on 16/1/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BezierPathViewController.h"

#define scale (kScreenWidth/600)

@interface BezierPathViewController ()

@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor blackColor];
    self.view.layer.masksToBounds = YES;
    
    // Used as background.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
        shapeLayer.path          = [self path].CGPath;
        
        shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth   = 0.5f;
        shapeLayer.opacity     = 0.5f;
        shapeLayer.position    = self.view.center;
        [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
        
        [self.view.layer addSublayer:shapeLayer];
    }
    
    // Red line animation.
    {
        CAShapeLayer *shapeLayer = [self createAniamtionShapeLayerWith:UIColor.redColor duration:10];
        [self.view.layer addSublayer:shapeLayer];
    }
    
    // Green line animation.
    {
        CAShapeLayer *shapeLayer = [self createAniamtionShapeLayerWith:UIColor.yellowColor duration:12];
        [self.view.layer addSublayer:shapeLayer];
    }
    
    // Cyan line animation.
    {
        CAShapeLayer *shapeLayer = [self createAniamtionShapeLayerWith:UIColor.cyanColor duration:7];
        [self.view.layer addSublayer:shapeLayer];
    }
    
    // Yellow line animation.
    
    {
        CAShapeLayer *shapeLayer = [self createAniamtionShapeLayerWith:UIColor.grayColor duration:4];
        [self.view.layer addSublayer:shapeLayer];
    }
}

- (CAShapeLayer *)createAniamtionShapeLayerWith:(UIColor *)lineColor duration:(NSTimeInterval)duration {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = CGRectMake(0, 0, 600, 300);
    shapeLayer.path          = [self path].CGPath;
    shapeLayer.strokeEnd     = 0.f;
    
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor   = lineColor.CGColor;
    shapeLayer.lineWidth     = 2.f;
    shapeLayer.position      = self.view.center;
    shapeLayer.shadowColor   = lineColor.CGColor;
    shapeLayer.shadowOpacity = 1.f;
    shapeLayer.shadowRadius  = 4.f;
    shapeLayer.lineCap       = kCALineCapRound;
    [shapeLayer setTransform:CATransform3DMakeScale(scale, scale, 1.f)];
    
    CGFloat MAX = 0.98f;
    CGFloat GAP = 0.02;
    
    CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    aniStart.fromValue         = [NSNumber numberWithFloat:MAX];
    aniStart.toValue           = [NSNumber numberWithFloat:0];
    
    CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    aniEnd.fromValue           = [NSNumber numberWithFloat:1.f];
    aniEnd.toValue             = [NSNumber numberWithFloat:GAP];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration          = duration;
    group.repeatCount       = CGFLOAT_MAX;
    group.autoreverses      = YES;
    group.animations        = @[aniEnd, aniStart];
    
    [shapeLayer addAnimation:group forKey:nil];
    
    return shapeLayer;
}

- (UIBezierPath *)path {
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint   : CGPointMake(0, 150)];
    [bezierPath addLineToPoint: CGPointMake(68, 150)];
    [bezierPath addLineToPoint: CGPointMake(83, 107)];
    [bezierPath addLineToPoint: CGPointMake(96, 206)];
    [bezierPath addLineToPoint: CGPointMake(102, 150)];
    [bezierPath addLineToPoint: CGPointMake(116, 150)];
    [bezierPath addLineToPoint: CGPointMake(127, 82)];
    [bezierPath addLineToPoint: CGPointMake(143, 213)];
    [bezierPath addLineToPoint: CGPointMake(160, 150)];
    [bezierPath addLineToPoint: CGPointMake(179, 150)];
    [bezierPath addLineToPoint: CGPointMake(183, 135)];
    [bezierPath addLineToPoint: CGPointMake(192, 169)];
    [bezierPath addLineToPoint: CGPointMake(199, 150)];
    [bezierPath addLineToPoint: CGPointMake(210, 177)];
    [bezierPath addLineToPoint: CGPointMake(227, 70)];
    [bezierPath addLineToPoint: CGPointMake(230, 210)];
    [bezierPath addLineToPoint: CGPointMake(249, 135)];
    [bezierPath addLineToPoint: CGPointMake(257, 150)];
    [bezierPath addLineToPoint: CGPointMake(360, 150)];
    [bezierPath addLineToPoint: CGPointMake(372, 124)];
    [bezierPath addLineToPoint: CGPointMake(395, 197)];
    [bezierPath addLineToPoint: CGPointMake(408, 82)];
    [bezierPath addLineToPoint: CGPointMake(416, 150)];
    [bezierPath addLineToPoint: CGPointMake(424, 135)];
    [bezierPath addLineToPoint: CGPointMake(448, 224)];
    [bezierPath addLineToPoint: CGPointMake(456, 107)];
    [bezierPath addLineToPoint: CGPointMake(463, 150)];
    [bezierPath addLineToPoint: CGPointMake(600, 150)];
    
    return bezierPath;
}

@end
