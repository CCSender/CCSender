//
//  CCSenderSectionView.h
//  CCSender
//
//  Created by BlueCocoa on 14-4-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <sys/utsname.h>

@interface CCSenderSectionView : UIView<MFMessageComposeViewControllerDelegate>{
    UIView *_separator;
}
@property (strong, nonatomic) UIButton *sms,*phone,*weibo;
@property (strong, nonatomic) UIWindow *window;
@end
