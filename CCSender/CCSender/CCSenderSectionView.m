//
//  CCSenderSectionView.m
//  CCSender
//
//  Created by BlueCocoa on 14-4-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CCSenderSectionView.h"

@implementation CCSenderSectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (BOOL)isiPhone{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] hasPrefix:@"iPhone"];
}

- (void)configure{
    UIGraphicsBeginImageContextWithOptions((CGSize){1.0f, 1.0f}, NO, 0.0f);
    [[UIColor colorWithWhite:0.0f alpha:0.15f] setFill];
    [[UIBezierPath bezierPathWithRect:(CGRect){CGPointZero, {1.0f, 1.0f}}] fill];
    UIImage *highlighted = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([self isiPhone]) {
        self.phone = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.phone setTitle:@"Phone" forState:UIControlStateNormal];
        [self.phone setTitleColor:[UIColor colorWithWhite:0.0f alpha:0.7f] forState:UIControlStateNormal];
        [self.phone setBackgroundImage:highlighted forState:UIControlStateHighlighted];
        [self addSubview:self.phone];
    }
    
    self.sms = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sms setTitle:@"SMS" forState:UIControlStateNormal];
    [self.sms setTitleColor:[UIColor colorWithWhite:0.0f alpha:0.7f] forState:UIControlStateNormal];
    [self.sms setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [self addSubview:self.sms];
    
    self.weibo = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weibo setTitle:@"Weibo" forState:UIControlStateNormal];
    [self.weibo setTitleColor:[UIColor colorWithWhite:0.0f alpha:0.7f] forState:UIControlStateNormal];
    [self.weibo setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [self addSubview:self.weibo];
}

#pragma mark - there are 3 methods waiting for Meirtz

- (void)phoneAction{
    
}

- (void)smsAction{
    
}

- (void)weiboAction{
    
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat separatorWidth = 1.5f;
    if ([self isiPhone]) {
        CGRect frame = self.bounds;
        frame.size.width -= separatorWidth;
        frame.size.width /= 3.0f;
        self.phone.frame = frame;
        frame.origin.x += frame.size.width;
        CGRect separatorFrame = frame;
        separatorFrame.size.width = separatorWidth;
        _separator.frame = separatorFrame;
        frame.origin.x += separatorWidth;
        self.sms.frame = frame;
        frame.origin.x += frame.size.width;
        CGRect separatorFrame1 = frame;
        separatorFrame1.size.width = separatorWidth;
        _separator.frame = separatorFrame1;
        frame.origin.x += separatorWidth;
        self.weibo.frame = frame;
    }else{
        CGRect frame = self.bounds;
        frame.size.width -= separatorWidth;
        frame.size.width /= 2.0f;
        self.sms.frame = frame;
        frame.origin.x += frame.size.width;
        CGRect separatorFrame = frame;
        separatorFrame.size.width = separatorWidth;
        _separator.frame = separatorFrame;
        frame.origin.x += separatorWidth;
        self.weibo.frame = frame;
    }
}


@end
