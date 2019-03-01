//
//  LEMTransition.m
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMTransitionAnimation.h"

static NSTimeInterval animationDuration = 1;

@interface LEMTransitionAnimation ()

@end

@implementation LEMTransitionAnimation

//MARK: - CATransition动画实现

+ (void)transitionWithType:(LEMTransitionType)type onView:(UIView *)view {
    [self transitionWithType:type subType:LEMTransitionSubTypeLeft onView:view];
}

+ (void)transitionWithType:(LEMTransitionType)type subType:(LEMTransitionSubType)subType onView:(UIView *)view {
    NSString *animationType = @"";
    CATransitionSubtype animationSubType = kCATransitionFromLeft; // default
    
    switch (subType) {
        case LEMTransitionSubTypeTop:
            animationSubType = kCATransitionFromTop;
            break;
        case LEMTransitionSubTypeLeft:
            animationSubType = kCATransitionFromLeft;
            break;
        case LEMTransitionSubTypeBottom:
            animationSubType = kCATransitionFromBottom;
            break;
        case LEMTransitionSubTypeRight:
            animationSubType = kCATransitionFromRight;
            break;
    }
    
    switch (type) {
        case LEMTransitionTypeFade:
            animationType = kCATransitionFade;
            [self addAnimationType:animationType subtype:nil onView:view];
            break;
        case LEMTransitionTypePush:
            animationType = kCATransitionPush;
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypeReveal:
            animationType = kCATransitionReveal;
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypeMoveIn:
            animationType = kCATransitionMoveIn;
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypeCube:
            animationType = @"cube";
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypeSuckEffect:
            animationType = @"suckEffect";
            [self addAnimationType:animationType subtype:nil onView:view];
            break;
        case LEMTransitionTypeOglFlip:
            animationType = @"oglFlip";
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypeRippleEffect:
            animationType = @"rippleEffect";
            [self addAnimationType:animationType subtype:nil onView:view];
            break;
        case LEMTransitionTypePageCurl:
            animationType = @"pageCurl";
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypePageUnCurl:
            animationType = @"pageUnCurl";
            [self addAnimationType:animationType subtype:animationSubType onView:view];
            break;
        case LEMTransitionTypeCameraIrisHollowOpen:
            animationType = @"cameraIrisHollowOpen";
            [self addAnimationType:animationType subtype:nil onView:view];
            break;
        case LEMTransitionTypeCameraIrisHollowClose:
            animationType = @"cameraIrisHollowClose";
            [self addAnimationType:animationType subtype:nil onView:view];
            break;
        case LEMTransitionTypeCurlDown:
            [self animationWithAnimationTransition:UIViewAnimationTransitionCurlDown onView:view];
            break;
        case LEMTransitionTypeCurlUp:
            [self animationWithAnimationTransition:UIViewAnimationTransitionCurlUp onView:view];
            break;
        case LEMTransitionTypeFlipFromLeft:
            [self animationWithAnimationTransition:UIViewAnimationTransitionFlipFromLeft onView:view];
            break;
        case LEMTransitionTypeFlipFromRight:
            [self animationWithAnimationTransition:UIViewAnimationTransitionFlipFromRight onView:view];
            break;
    }
}

+ (void)addAnimationType:(NSString *)type subtype:(CATransitionSubtype)subtype onView:(UIView *)view {
    DLog(@"type = %@ subtype = %@",type, subtype);
    CATransition *animation = [[CATransition alloc] init];
    animation.duration = animationDuration;
    animation.type = type;
    if (!kStringIsEmpty(subtype)) {
        animation.subtype = subtype;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"animation"];
}

+ (void)animationWithAnimationTransition:(UIViewAnimationTransition)transition onView:(UIView *)view {
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

@end
