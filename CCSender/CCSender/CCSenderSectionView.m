//
//  CCSenderSectionView.m
//  CCSender
//
//  Created by BlueCocoa on 14-4-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CCSenderSectionView.h"
#import <Social/Social.h>

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
    
    if ([self isiPhone]) {
        [self.phone addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.sms addTarget:self action:@selector(smsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.weibo addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - there are 2 methods waiting for Meirtz

- (void)phoneAction{
    
    if (self.window == NULL) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    self.window.windowLevel = UIWindowLevelAlert;
    UIViewController *popVC = [[UIViewController alloc] init];
    self.window.rootViewController = popVC;
    [self.window makeKeyAndVisible];

    UIView *phoneView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [popVC.view addSubview:phoneView];
    [UIView animateWithDuration:0.5f animations:^{
        [popVC.view setCenter:CGPointMake(300, 300)];
        [phoneView setBackgroundColor:[UIColor yellowColor]];
    }];
    

    
}

- (void)smsAction{
    if (self.window == NULL) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    
    self.window.windowLevel = UIWindowLevelAlert;
    UIViewController *popVC = [[UIViewController alloc] init];
    self.window.rootViewController = popVC;
    [self.window makeKeyAndVisible];
   
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.body=@"BC你好!";
    [popVC presentViewController:picker animated:YES completion:nil];
}

- (void)weiboAction{
    
    
    if (self.window == NULL) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    self.window.windowLevel = UIWindowLevelAlert;
    UIViewController *popVC = [[UIViewController alloc] init];
    self.window.rootViewController = popVC;
    [self.window makeKeyAndVisible];

    
    SLComposeViewController *slComposerSheet = [[SLComposeViewController alloc] init];
    
    [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSLog(@"start completion block");
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                [self.window resignKeyWindow];
                 [self.window resignFirstResponder];
                 [self.window removeFromSuperview];
                 [self.window setUserInteractionEnabled:NO];
                 [[UIApplication sharedApplication].windows.firstObject becomeKeyWindow];
                 [[UIApplication sharedApplication].windows.firstObject becomeFirstResponder];
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                [self.window resignKeyWindow];
                 [self.window resignFirstResponder];
                 [self.window removeFromSuperview];
                 [self.window setUserInteractionEnabled:NO];
                 [[UIApplication sharedApplication].windows.firstObject becomeKeyWindow];
                 [[UIApplication sharedApplication].windows.firstObject becomeFirstResponder];
                break;
            default:
                break;
        }
        if (result != SLComposeViewControllerResultCancelled)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weibo Message" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    
    slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    [slComposerSheet setInitialText:@"BC你好"];
    //[slComposerSheet addImage:self.sharingImage];
    
    //[slComposerSheet addURL:[NSURL URLWithString:@"http://www.weibo.com/"]];
    [popVC presentViewController:slComposerSheet animated:YES completion:nil];
    
}

#pragma mark - Message Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:^(void){
        [self.window resignKeyWindow];
        [self.window resignFirstResponder];
        [self.window removeFromSuperview];
        [self.window setUserInteractionEnabled:NO];
    }];
    [[UIApplication sharedApplication].windows.firstObject becomeKeyWindow];
    [[UIApplication sharedApplication].windows.firstObject becomeFirstResponder];
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
