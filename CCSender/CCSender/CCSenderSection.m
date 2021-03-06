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

- (void)dealloc{
    self.view = nil;
    self.bundle = nil;
}


- (void)controlCenterWillAppear {

}

- (void)controlCenterDidDisappear {
    
    
}


@end
