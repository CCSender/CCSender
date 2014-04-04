//
//  CCSenderSection.m
//  CCSender
//
//  Created by BlueCocoa on 14-4-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#define MRC !__has_feature(objc_arc)

#if MRC

#define CC_Strong retain
#define CC_Weak assign

#else

#define CC_Strong strong
#define CC_Weak weak

#endif

#import "CCSenderSection.h"


@interface CCSenderSection () 

@property (nonatomic, CC_Strong) NSBundle *bundle;
@property (nonatomic, CC_Strong) CCSenderSectionView *view;

@property (nonatomic, CC_Weak) UIViewController <CCSectionDelegate> *delegate;

@end

@implementation CCSenderSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bundle = [NSBundle bundleForClass:[self class]];
    }
    return self;
}

- (CGFloat)sectionHeight {
    return 50.0f;
}

- (void)loadView {
    self.view = [[CCSenderSectionView alloc] init];
}

- (UIView *)view {
    if (!_view) {
        [self loadView];
    }
    
    return _view;
}

- (void)dealloc {
#if MRC
    [self.view release];
#endif
    self.view = nil;
    self.bundle = nil;
    
    
#if MRC
    [super dealloc];
#endif
}

- (void)controlCenterWillAppear {
<<<<<<< HEAD
 
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.windowLevel = UIWindowLevelAlert;
    
    UIViewController *popVC = [[UIViewController alloc] init];
    
    window.rootViewController = popVC;
    
    //[window makeKeyAndVisible];
    
    //UIView *popV = [[UIView alloc] init];
    

    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.body=@"lalal";
    //[popVC presentModalViewController:picker animated:YES];*/
=======
    // don't animate here
>>>>>>> FETCH_HEAD
}

- (void)controlCenterDidDisappear {
    
    
}


@end
