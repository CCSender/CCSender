//
//  CCSenderSectionView.m
//  CCSender
//
//  Created by BlueCocoa on 14-4-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CCSenderSectionView.h"

@interface SBControlCenterController : UIViewController
+(id)sharedInstance;
-(void)_dismissWithDuration:(double)duration additionalAnimations:(id)animations completion:(id)completion;
-(void)dismissAnimated:(BOOL)animated withAdditionalAnimations:(id)additionalAnimations completion:(id)completion;
-(void)dismissAnimated:(BOOL)animated completion:(id)completion;
-(void)dismissAnimated:(BOOL)animated;
@end


@implementation CCSenderSectionView

@synthesize myPhone,conTable,search;

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(0 == searchText.length)
    {
        [self.search removeAllObjects];
        [self.conTable reloadData];
        return ;
    }
    [self.search removeAllObjects];
    for(NSDictionary * str in self.myPhone)
    {
        if([[[str valueForKey:@"name"]lowercaseString] rangeOfString:[searchText lowercaseString]].length != 0 || [[[str valueForKey:@"number"]lowercaseString] rangeOfString:[searchText lowercaseString]].length != 0)
        {
            [self.search addObject:str];
        }
    }
    [self.conTable setTag:222];
    [self.conTable reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.search removeAllObjects];
    NSString *searchText = searchBar.text;
    for(NSDictionary * str in self.myPhone)
    {
        if([[[str valueForKey:@"name"]lowercaseString] rangeOfString:[searchText lowercaseString]].length != 0 || [[[str valueForKey:@"number"]lowercaseString] rangeOfString:[searchText lowercaseString]].length != 0)
        {
            [self.search addObject: str];
        }
    }
    [self.conTable setTag:222];
    [self.conTable reloadData];
    [searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 222) {
        return self.search.count;
    }
    [self.search removeAllObjects];
    return self.myPhone.count;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    self.conTable.allowsSelection=YES;
    self.conTable.scrollEnabled=YES;
    self.conTable.tag = 222;
    [self.search removeAllObjects];
    [self.conTable reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.conTable.allowsSelection=YES;
    self.conTable.scrollEnabled=YES;
    self.conTable.tag = 0;
    [self.conTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCSender"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CCSender"];
        [cell setBackgroundView:nil];
        [cell setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.3]];
    }
    if (tableView.tag == 222) {
        [cell.textLabel setText:[[self.search objectAtIndex:indexPath.row] valueForKey:@"name"]];
        [cell.detailTextLabel setText:[[self.search objectAtIndex:indexPath.row] valueForKey:@"number"]];
        return cell;
    }
    [cell.textLabel setText:[[self.myPhone objectAtIndex:indexPath.row] valueForKey:@"name"]];
    [cell.detailTextLabel setText:[[self.myPhone objectAtIndex:indexPath.row] valueForKey:@"number"]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.conTable tag]==222) {
        UIAlertView *phoneAlert = [[UIAlertView alloc] initWithTitle:@"Phone" message:[NSString stringWithFormat:@"拨打%@?\n(%@)",[[self.search objectAtIndex:indexPath.row] valueForKey:@"number"],[[self.search objectAtIndex:indexPath.row] valueForKey:@"name"]] delegate:self cancelButtonTitle:@"取消 " otherButtonTitles:@"是的", nil];
        [phoneAlert show];
        self.row = [NSString stringWithString:[[self.search objectAtIndex:indexPath.row] valueForKey:@"number"]];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Phone" message:[NSString stringWithFormat:@"拨打%@?\n(%@)",[[self.myPhone objectAtIndex:indexPath.row] valueForKey:@"number"],[[self.myPhone objectAtIndex:indexPath.row] valueForKey:@"name"]] delegate:self cancelButtonTitle:@"取消 " otherButtonTitles:@"是的", nil] show];
        self.row = [NSString stringWithString:[[self.myPhone objectAtIndex:indexPath.row] valueForKey:@"number"]];
    }
}

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
        
        self.search = [[NSMutableArray alloc] init];
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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
}

- (void)ExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)activeWindow{
    self.window.windowLevel = UIWindowLevelNormal+levelOffset;
    [self.window makeKeyAndVisible];
    [self.window becomeFirstResponder];
    [self.window setHidden:NO];
    [self.window setAlpha:1.0f];
    [self.window setUserInteractionEnabled:YES];
}

- (void)deactiveWindow{
    [self.window resignFirstResponder];
    [self.window resignKeyWindow];
    [self.window setHidden:YES];
    [self.window setAlpha:0.0f];
    [self.window setUserInteractionEnabled:NO];
    [[UIApplication sharedApplication].windows.firstObject becomeKeyWindow];
    [[UIApplication sharedApplication].windows.firstObject becomeFirstResponder];
}

#pragma mark - there are 2 methods waiting for Meirtz

- (void)phoneAction{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.popVC = [[UIViewController alloc] init];
        self.navi = [[UINavigationController alloc] initWithRootViewController:self.popVC];
        [self.navi setTitle:@"联系人"];
        [self.navi.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
        UIView *phoneView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.popVC.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
        [phoneView setBackgroundColor:[UIColor whiteColor]];
        [phoneView setAlpha:0.8];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissPhone)];
        self.popVC.navigationItem.rightBarButtonItem = rightItem;
        
        self.popVC.edgesForExtendedLayout = UIRectEdgeNone;
        self.popVC.extendedLayoutIncludesOpaqueBars =NO;
        self.popVC.modalPresentationCapturesStatusBarAppearance =NO;
        self.popVC.navigationController.navigationBar.translucent =NO;
         [self.popVC.view addSubview:phoneView];
       
    });
    
    
    self.window.rootViewController = self.navi;
    if (self.myPhone == NULL) {
        self.myPhone = [[NSMutableArray alloc] init];
    }
    [self.myPhone removeAllObjects];

    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
       
        UISearchBar * searchBar = [[UISearchBar alloc] init];
        searchBar.frame = CGRectMake(0, 0, self.conTable.bounds.size.width, 0);
        searchBar.delegate = self;
        CGRect rect = self.popVC.view.frame;
        rect.size.height -= 64;
        self.conTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        searchBar.showsCancelButton = NO;
        searchBar.placeholder = @"搜索联系人";
        searchBar.barStyle = UIBarStyleDefault;
        [searchBar sizeToFit];
        self.conTable.opaque= NO;
        [self.conTable setBackgroundColor:[UIColor clearColor]];
        UIView *view = [[UIView alloc]init];
        [view setBackgroundColor:[UIColor clearColor]];
        view.opaque = NO;
        [self.conTable setBackgroundView:view];
        [self ExtraCellLineHidden:self.conTable];
        self.conTable.tableHeaderView = searchBar;
        if (![[self.popVC.view subviews] containsObject:self.conTable]) {
            [self.popVC.view addSubview:self.conTable];
        };

    });
    [self.popVC.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height+300)];
    [self.window setAlpha:0.0f];
    
    [self.conTable setDataSource:self];
    [self.conTable setDelegate:self];
    
    
    self.window.windowLevel = UIWindowLevelNormal+levelOffset;
    [self.window makeKeyAndVisible];
    [self.window becomeFirstResponder];
    [self.window setHidden:NO];
    [self.window setAlpha:0.0f];
    [self.window setUserInteractionEnabled:YES];
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationCurveLinear animations:^(void){
        
        [self.popVC.view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
              [self.window setAlpha:1.0f];
    } completion:nil];
    
    
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //dispatch_release(sema);
    }
    
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    //NSLog(@"%@" ,results);
    
#ifdef __arm64__
    long peopleCount = CFArrayGetCount(results);
#else
    int peopleCount = CFArrayGetCount(results);
#endif
    
    for (int i=0; i<peopleCount; i++)
    {
        ABRecordRef record = CFArrayGetValueAtIndex(results, i);
        
        
        NSString *fn,*ln,*fullname;
        fn = ln = fullname = nil;
        
        CFTypeRef vtmp = NULL;
        
        vtmp = ABRecordCopyValue(record, kABPersonFirstNameProperty);
        if (vtmp)
        {
            fn = [NSString stringWithString:(__bridge NSString *)(vtmp)];
            
            CFRelease(vtmp);
            vtmp = NULL;
        }
        vtmp = ABRecordCopyValue(record, kABPersonLastNameProperty);
        if (vtmp)
        {
            ln = [NSString stringWithString:(__bridge NSString *)(vtmp)];
            
            CFRelease(vtmp);
            vtmp = NULL;
        }
        
        //NSLog(@"%@ ,%@" ,fn ,ln);
        
        // 读取电话
        
        if (record) {
            ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
            if (phones) {
#ifdef __arm64__
                long phoneCount = ABMultiValueGetCount(phones);;
#else
                int phoneCount = ABMultiValueGetCount(phones);
#endif
                for (int j=0; j<phoneCount; j++)
                {
                    // label
                    CFStringRef lable = ABMultiValueCopyLabelAtIndex(phones, j);
                    // phone number
                    CFStringRef phonenumber = ABMultiValueCopyValueAtIndex(phones, j);
                    
                    // localize label
                    CFStringRef ll = ABAddressBookCopyLocalizedLabel(lable);
                    if (fn != nil && ln != nil) {
                        fullname = [ln stringByAppendingString:fn];
                    }else if(fn == nil && ln != nil){
                        fullname = ln;
                    }else if(ln == nil && fn != nil){
                        fullname = fn;
                    }else{
                        fullname = @" ";
                    }
                    
                    [self.myPhone addObject:@{@"name":fullname,@"number":(__bridge NSString *)phonenumber}];
                    
                    if (ll)
                        CFRelease(ll);
                    if (lable)
                        CFRelease(lable);
                    if (phonenumber)
                        CFRelease(phonenumber);
                }
                
                record = NULL;
                CFRelease(phones);
            }
            
        }
    }
    
    if (results)
        CFRelease(results);
    results = nil;
    
    if (addressBook)
        CFRelease(addressBook);
    addressBook = NULL;
    [self.conTable reloadData];
}

- (void)dismissPhone{
    //[self.popVC.navigationItem setRightBarButtonItem:nil animated:NO];
    //[self.popVC removeFromParentViewController];
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationCurveLinear animations:^(void){
        [self.window setAlpha:0.0f];
        
    } completion:^(BOOL fi){
        [self deactiveWindow];
    }];
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.search removeAllObjects];
        [self.myPhone removeAllObjects];
        [self.conTable reloadData];
    });
}

- (void)smsAction{
    UIViewController *popVC1 = [[UIViewController alloc] init];
    self.window.rootViewController = popVC1;
    [self activeWindow];
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    //picker.body=@"BC你好!";
    [popVC1 presentViewController:picker animated:YES completion:nil];
}

- (void)weiboAction{
    UIViewController *popVC = [[UIViewController alloc] init];
    self.window.rootViewController = popVC;
    [self activeWindow];
    
    SLComposeViewController* slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    //[slComposerSheet setInitialText:@"BC已哭→←_→←"];
    [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        [self deactiveWindow];
        [[UIApplication sharedApplication].windows.firstObject becomeKeyWindow];
        [[UIApplication sharedApplication].windows.firstObject becomeFirstResponder];
        NSLog(@"start completion block");
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:{
                output = @"Action Cancelled";
                
                break;
            }
            case SLComposeViewControllerResultDone:{
                output = @"Post Successfull";
                break;
            }
            default:{
                break;
            }
        }
        if (result != SLComposeViewControllerResultCancelled)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weibo Message" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    [popVC presentViewController:slComposerSheet animated:YES completion:nil];
    
}

#pragma mark - Message Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:^(void){
        [self.window resignFirstResponder];
        [self.window resignKeyWindow];
        [self.window setHidden:YES];
        [self.window setAlpha:0.0f];
        [self.window setUserInteractionEnabled:NO];
        
    }];
    [[UIApplication sharedApplication].windows.firstObject becomeKeyWindow];
    [[UIApplication sharedApplication].windows.firstObject becomeFirstResponder];
}

#pragma mark - UIAlert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationCurveLinear animations:^(void){
            [self.window setAlpha:0.0f];
        } completion:^(BOOL fi){
            [self deactiveWindow];
        }];
        Class SBControlCenterController = NSClassFromString(@"SBControlCenterController");
        id cc = [SBControlCenterController sharedInstance];
        [cc dismissAnimated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.row]]];
        });
    }
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
