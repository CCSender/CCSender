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
#import <Social/Social.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface CCSenderSectionView : UIView<MFMessageComposeViewControllerDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    UIView *_separator;
}
@property (strong, nonatomic) UITableView *conTable;
@property (strong, nonatomic) UIButton *sms,*phone,*weibo;
@property (strong, nonatomic) UIWindow *window;
@end
