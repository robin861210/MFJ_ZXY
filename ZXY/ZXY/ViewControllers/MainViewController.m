//
//  MainViewController.m
//  ZXY
//
//  Created by acewill on 15/6/12.
//  Copyright (c) 2015年 MFJ_zxy. All rights reserved.
//

#import "MainViewController.h"


//*** MFJ 环信所需头文件 ***//
#import "UIViewController+HUD.h"
#import "ChatListViewController.h"
#import "ContactsViewController.h"
#import "SettingsViewController.h"
#import "ApplyViewController.h"
#import "CallSessionViewController.h"
#import "ChatListView.h"

static const CGFloat kDefaultPlaySoundInterval = 3.0; //两次提示的默认间隔

@interface MainViewController ()<UIAlertViewDelegate, IChatManagerDelegate, EMCallManagerDelegate,ChatListViewDelegat>
{
    ChatListViewController *_chatListVC;            //聊天界面
    ContactsViewController *_contactsVC;            //联系人界面
    SettingsViewController *_settingsVC;            //设置界面
    CallSessionViewController *_callController;     //会话界面
    
    UIBarButtonItem *_addFriendItem, *contactsItem;
    
    ChatListView *chatListView;
}

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
#pragma mark - 
#pragma mark 页面切换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"pushToFunctionVC" object:nil];
    
#pragma mark -
#pragma mark 换新功能
    /*** MFJ 环信功能 ***/
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //获取未读消息数，此时并没有把self注册为SDK的delegate，读取出的未读数是上次退出程序时的
    //[self didUnreadMessagesCountChanged];
#warning 把self注册为SDK的delegate
    [self registerNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callOutWithChatter:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callControllerClose:) name:@"callControllerClose" object:nil];
    
    _contactsVC = [[ContactsViewController alloc] initWithNibName:nil bundle:nil];

    //联系人按钮
//    UIButton *contactsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
//    [contactsButton setTitle:@"联系人" forState:UIControlStateNormal];
//    [contactsButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
//    [contactsButton addTarget:self action:@selector(enterContactsVC:) forControlEvents:UIControlEventTouchUpInside];
//    contactsItem = [[UIBarButtonItem alloc] initWithCustomView:contactsButton];
//    if ([[[[UserInfoUtils sharedUserInfoUtils] infoDic] objectForKey:@"InvCode"] length] == 0)
//    {
//        self.navigationItem.rightBarButtonItem = contactsItem;
//    }
    //统计未读取信息数量
    [self setupUnreadMessageCount];
    //统计未添加的联系人数量
    [self setupUntreatedApplyCount];
    
#pragma mark -
#pragma mark 基础功能
    tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50-64*ScreenHeight/568)];
    [self.view addSubview:tmpView];
    
    CGRect subViewFrame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-50-64*ScreenHeight/568);
    NSLog(@"~~~ 在MainViewController界面中设置的界面高度:%f /n ~~~",subViewFrame.size.height);
    
    //首页
    homeView = [[HomeView alloc] initWithFrame:subViewFrame];
    [homeView setDelegate:self];
    [tmpView addSubview:homeView];
    //看装修
    kanZXView = [[KanZXView alloc] initWithFrame:subViewFrame];
    //沟通界面
    chatListView = [[ChatListView alloc] initWithFrame:subViewFrame];
    [chatListView networkChanged:_connectionState];
    [chatListView setDelegate:self];
    [chatListView refreshDataSource];
    [chatListView registerNotifications];
    //学装修
    xueZXView = [[XueZXView alloc] initWithFrame:subViewFrame];
    
    //初始化下方工具栏
    tabArray = @[@"首页",@"看装修",@"在线沟通",@"学装修"];
    NSArray *tabImgNorArray = @[@"zxy_home@2x",@"zxy_look@2x",@"zxy_chat@2x",@"zxy_study@2x"];
    NSArray *tabImgSelArray = @[@"zxy_homeed@2x",@"zxy_looked@2x",@"zxy_chated@2x",@"zxy_studyed@2x"];
    tabBarView = [[TabBarView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64*ScreenHeight/568, ScreenWidth, 50*ScreenHeight/568) tabBarInfo:tabArray normalImageArr:tabImgNorArray selectImageArr:tabImgSelArray];
//    tabBarView.layer.borderWidth = 0.5f;
//    tabBarView.layer.borderColor = [[UIColor grayColor] CGColor];
    [tabBarView setBackgroundColor:[UIColor whiteColor]];
    tabBarView.delegate = self;
    [self.view addSubview:tabBarView];
    
    
    segmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    segmentView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [segmentView setSegmentReset];
}

#pragma mark -
#pragma mark TabBarViewDelegate
- (void)selectTabBarItem:(NSString *)itemIndex
{
    NSInteger index = itemIndex.intValue - 10;
    [self cleanTmpViewSubviews];
    self.navigationItem.titleView = segmentView;
    
    switch (index) {
        case 0:
            [tmpView addSubview:homeView];
            self.navigationItem.titleView = nil;
            break;
        case 1:
            [tmpView addSubview:kanZXView];
            [segmentView setSegmentSelectImgStrArray:@[@"zxy_choiceed@2x",@"zxy_overAlled@2x"] NormailImgStrArray:@[@"zxy_choice@2x",@"zxy_overAll@2x"] SegmentType:(int)index];
            break;
        case 2:
            [tmpView addSubview:chatListView];
            [segmentView setSegmentSelectImgStrArray:@[@"zxy_Seg_chated@2x",@"zxy_Seg_contacted@2x"] NormailImgStrArray:@[@"zxy_Seg_chat@2x",@"zxy_Seg_contact@2x"] SegmentType:(int)index];
            break;
        case 3:
            [tmpView addSubview:xueZXView];
            [segmentView setSegmentSelectImgStrArray:@[@"zxy_learned@2x",@"zxy_diaryed@2x"] NormailImgStrArray:@[@"zxy_learn@2x",@"zxy_diary@2x"] SegmentType:(int)index];
//            [xueZXView sendXueZX_ZSK_NetworkInfoData:GetKBListInLearnDec];
            [xueZXView sendXueZX_ZSK_NetworkInfoData:GetSynthesizeHomePage];
            break;
        default:
            break;
    }
    self.title = [tabArray objectAtIndex:index];
    switchIndex = index;
    
}

- (void) cleanTmpViewSubviews
{
    for (int i = 0; i < [[tmpView subviews] count]; i++) {
        [[[tmpView subviews] objectAtIndex:i] removeFromSuperview];
    }
}

#pragma mark -
#pragma mark CustomSegmentView Delegate
- (void)segmentSelectItem:(int)selectTag SegmentType:(int)segmentType
{
    NSLog(@"~~~selectTag:%d~~~segmentType:%d~~~",selectTag,segmentType);
    switch (segmentType) {
        case 1:
            [kanZXView transfromKanZX_Info:selectTag];
            
            break;
        case 2:
            if (selectTag == 35) {
                [self enterContactsVC:nil];
            }
            
            break;
        case 3:
            [xueZXView transfromXueZX_Info:selectTag];
            
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma mark HomeView Delegate
- (void)selectHomeADItem:(NSString *)ad_Info {
    
}


//通知方法
- (void)push:(NSNotification *)notification{
    NSLog(@"%@",[notification.userInfo objectForKey:@"viewC"]);
    NSLog(@"－－－－－接收到通知------");
    [self.navigationController pushViewController:[notification.userInfo objectForKey:@"viewC"] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*** MFJ EaseMob Functions And Delegate ***/
#pragma mark -
#pragma mark 环信方法实现

//析构函数
- (void)dealloc
{
    [self unregisterNotifications];
}

#pragma mark ChatListView Delegate
//进入联系人方法
- (IBAction)enterContactsVC:(id)sender {
    _contactsVC.title = @"联系人";
    [self.navigationController pushViewController:_contactsVC animated:YES];
    [chatListView unregisterNotifications];
}
//进行会话
- (void)chatListViewWillEnterVC:(ChatViewController *)chatVC {
    [self.navigationController pushViewController:chatVC animated:YES];
    [chatListView unregisterNotifications];
}
- (void)chatListViewHidden {
    [self hideHud];
}

//注册通知
#pragma mark - private
-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EMSDKFull sharedInstance].callManager addDelegate:self delegateQueue:nil];
}
//注销通知
-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EMSDKFull sharedInstance].callManager removeDelegate:self];
}

// 统计未读消息数 （修改后暂不需要）
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    //    if (_chatListVC) {
    //        if (unreadCount > 0) {
    //            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
    //        }else{
    //            _chatListVC.tabBarItem.badgeValue = nil;
    //        }
    //    }
    if (unreadCount > 0) {
        [tabBarView.numLab setHidden:NO];
        [tabBarView setNumOfChatView:[NSString stringWithFormat:@"%i",(int)unreadCount]];
    }else{
        [tabBarView setNumOfChatView:[NSString stringWithFormat:@"%i",(int)unreadCount]];
        [tabBarView.numLab setHidden:YES];
    }
    
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

//统计申请添加好友的人数 (修改后不需要)
- (void)setupUntreatedApplyCount
{
    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
    if (_contactsVC) {
        if (unreadCount > 0) {
            _contactsVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            _contactsVC.tabBarItem.badgeValue = nil;
        }
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    //[_chatListVC networkChanged:connectionState]; //之前用的，现在用自己写的类。
    [chatListView networkChanged:connectionState];
}

- (void)callOutWithChatter:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSString class]]) {
        NSString *chatter = (NSString *)object;
        NSLog(@"~~~ chatter: %@ ~~~",chatter);
        if (_callController == nil) {
            EMError *error = nil;
            //            EMCallSession *callSession = [[EMSDKFull sharedInstance].callManager asyncCallAudioWithChatter:chatter timeout:50 error:&error];
            EMCallSession *callSession = [[EMSDKFull sharedInstance].callManager asyncMakeVoiceCall:chatter timeout:50 error:&error];
            
            if (callSession) {
                [[EMSDKFull sharedInstance].callManager removeDelegate:self];
                _callController = [[CallSessionViewController alloc] initCallOutWithSession:callSession];
                [self presentViewController:_callController animated:YES completion:nil];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"error") message:error.description delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else{
            [self showHint:@"正在通话中"];
        }
    }
}

- (void)callControllerClose:(NSNotification *)notification
{
    [[EMSDKFull sharedInstance].callManager addDelegate:self delegateQueue:nil];
    _callController = nil;
}

#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [self setupUnreadMessageCount];
    //[_chatListVC refreshDataSource];
    [chatListView refreshDataSource];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineCmdMessages:(NSArray *)offlineCmdMessages
{
    
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    NSDictionary *ext = message.ext;
    NSLog(@"~~~ 消息扩展: %@ ~~~",ext);
    //存到数据库
    [EMobUserInfo setEmobInfoDataWithUserId:message.from  userNickName:[ext objectForKey:@"userNick"] userIcon:[ext objectForKey:@"userIcon"]];
    
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }else {
            [self playSoundAndVibration];
        }
#endif
    }
}

-(void)didReceiveCmdMessage:(EMMessage *)message
{
    NSDictionary *ext = message.ext;
    NSLog(@"~~~ 消息扩展: %@ ~~~",ext);
    //存到 数据库
    [EMobUserInfo setEmobInfoDataWithUserId:message.from  userNickName:[ext objectForKey:@"userNick"] userIcon:[ext objectForKey:@"userIcon"]];
    [self showHint:NSLocalizedString(@"receiveCmd", @"receive cmd message")];
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isVoice"] intValue] == 1) {
        [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isVibration"] intValue] == 1) {
        [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
    }
    
    //    // 收到消息时，播放音频
    //    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    //    // 收到消息时，震动
    //    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.vidio", @"Vidio");
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}

#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {
        NSString *hintText = NSLocalizedString(@"reconnection.retry", @"Fail to log in your account, is try again... \nclick 'logout' button to jump to the login page \nclick 'continue to wait for' button for reconnection successful");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt")
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"reconnection.wait", @"continue to wait")
                                                  otherButtonTitles:NSLocalizedString(@"logout", @"Logout"),
                                  nil];
        alertView.tag = 99;
        [alertView show];
        //        [_chatListVC isConnect:NO];
        [chatListView isConnect:NO];
    }
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        //发送本地推送
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), username];
        notification.alertAction = NSLocalizedString(@"open", @"Open");
        notification.timeZone = [NSTimeZone defaultTimeZone];
    }
#endif
    
    [_contactsVC reloadApplyView];
}

- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    [_contactsVC reloadDataSource];
}

- (void)didRemovedByBuddy:(NSString *)username
{
    [[EaseMob sharedInstance].chatManager removeConversationByChatter:username deleteMessages:YES append2Chat:YES];
    //    [_chatListVC refreshDataSource];
    [chatListView refreshDataSource];
    [_contactsVC reloadDataSource];
}

- (void)didAcceptedByBuddy:(NSString *)username
{
    [_contactsVC reloadDataSource];
}

- (void)didRejectedByBuddy:(NSString *)username
{
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.beRefusedToAdd", @"you are shameless refused by '%@'"), username];
    TTAlertNoTitle(message);
}

- (void)didAcceptBuddySucceed:(NSString *)username
{
    [_contactsVC reloadDataSource];
}

#pragma mark - IChatManagerDelegate 群组变化

- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
#endif
    
    [_contactsVC reloadGroupView];
}

//接收到入群申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!error) {
#if !TARGET_IPHONE_SIMULATOR
        [self playSoundAndVibration];
#endif
        
        [_contactsVC reloadGroupView];
    }
}

- (void)didReceiveGroupRejectFrom:(NSString *)groupId
                          invitee:(NSString *)username
                           reason:(NSString *)reason
{
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.beRefusedToAdd", @"you are shameless refused by '%@'"), username];
    TTAlertNoTitle(message);
}


- (void)didReceiveAcceptApplyToJoinGroup:(NSString *)groupId
                               groupname:(NSString *)groupname
{
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"group.agreedToJoin", @"agreed to join the group of \'%@\'"), groupname];
    [self showHint:message];
}

#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        //发送”注销“请求
        //通知“注销”
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        alertView.tag = 100;
        [alertView show];
        
    } onQueue:nil];
}

- (void)didRemovedFromServer
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginUserRemoveFromServer", @"your account has been removed from the server side") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        alertView.tag = 101;
        [alertView show];
    } onQueue:nil];
}

- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    //    [_chatListVC networkChanged:connectionState];
    [chatListView networkChanged:connectionState];
}

#pragma mark - 自动登录回调

- (void)willAutoReconnect{
    [self hideHud];
    [self showHint:NSLocalizedString(@"reconnection.ongoing", @"reconnecting...")];
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    [self hideHud];
    if (error) {
        [self showHint:NSLocalizedString(@"reconnection.fail", @"reconnection failure, later will continue to reconnection")];
    }else{
        [self showHint:NSLocalizedString(@"reconnection.success", @"reconnection successful！")];
    }
}

#pragma mark - ICallManagerDelegate

- (void)callSessionStatusChanged:(EMCallSession *)callSession changeReason:(EMCallStatusChangedReason)reason error:(EMError *)error
{
    if (callSession.status == eCallSessionStatusConnected)
    {
        BOOL isShowPicker = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isShowPicker"] boolValue];
        if (!isShowPicker) {
            if (_callController == nil) {
                _callController = [[CallSessionViewController alloc] initCallInWithSession:callSession];
                [self presentViewController:_callController animated:YES completion:nil];
            }
        }
        else
        {
            [[EMSDKFull sharedInstance].callManager asyncEndCall:callSession.sessionId reason:eCallReason_Hangup];
        }
    }
}

#pragma mark - public
//这个方法基本不需要，目前先不去掉
- (void)jumpToChatList
{
    //    if(_chatListVC)
    //    {
    //        [self.navigationController popToViewController:self animated:NO];
    //        [self setSelectedViewController:_chatListVC];
    //    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
