//
//  ServerURL.h
//  ZXYY
//
//  Created by hndf on 15-4-1.
//  Copyright (c) 2015年 ZX. All rights reserved.
//

#ifndef ZXYY_ServerURL_h
#define ZXYY_ServerURL_h

#define BaseURL     @"http://218.25.17.238:8021/"

#define UserLogin           @"UserLogin"                    //用户登陆
///UserLogin?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&UserName=13112344321&PassWD=Aa1234
#define UserLogout          @"UserLogout"                   //用户注销
//UserLogout?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&ClientID=13112344321&sessionid=S01239499890109823412
#define InviteCodeLogin     @"InviteCodeLogin"              //用户邀请码登录、
//InviteCodeLogin?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&InvCode=12312
#define GetHomePage         @"GetHomePage"                  //获取首页
//GetHomePage?MachineID=aabbcc&UserID=13112344321&ClientID=1234
#define GetHomeBanner       @"GetHomeBanner"
//GetHomeBanner?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ClientID=1234
#define GetKBList           @"GetKBList"                    //装修必读文章列表
//GetKBList?MachineID=aabbcc&UserID=13112344321&ClientID=1234&KBTypeID=1234
#define GetKBDetail         @"GetKBDetail"                  //装修必读详情
//GetKBDetail?MachineID=aabbcc&UserID=334&ClientID=325&KBArtID=19
#define QueryKBList         @"QueryKBList"                  //文章查询
//QueryKBList?MachineID=aabbcc&UserID=13112344321&ClientID=1234&Keys=xxx"
#define SaveReadNumber      @"SaveReadNumber"               //记录文章阅读数
//SaveReadNumber?KBArtID=1&MachineID=aabbcc&UserID=13112344321&ClientID=1234
#define KBArtShare          @"KBArtShare"                   //文章分享接口   //***
//KBArtShare?MachineID=aabbcc&UserID=13112344321&ClientID=1234&KBartID=1234&Channel=1
//0 新浪微博 1 腾讯微博 2 微信 3 朋友圈 4 豆瓣网 5 QQ空间
#define KBArtPraise         @"KBArtPraise"                  //赞一下文章    //***
//KBArtPraise?MachineID=aabbcc&UserID=13112344321&ClientID=1234&KBArtID=1234
#define GetBaseBudget       @"GetBaseBudget"                //获取基础预算
//GetBaseBudget?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=123
#define GetZCBudget         @"GetZCBudget"                  //获取主材预算
//GetZCBudget?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=1234
#define GetChangeBaseBudget @"GetChangeBaseBudget"          //获取基础变更
//GetChangeBaseBudget?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=1234
#define GetChangeZCBudget   @"GetChangeZCBudget"            //获取主材变更
//GetChangeZCBudget?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=1234
#define GetPayment          @"GetPayment"                   //获取缴费记录
//GetPayment?MachineID=aabbcc&UserID=13112344321&ClientID=2345&ProjectID=1234
#define GetProject          @"GetProject"                   //施工工作接口
//GetProject?MachineID=aabbcc&UserID=220&ClientID=1234
#define GetEffectDraw       @"GetEffectDraw"                //获取业主效果图
//GetEffectDraw?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=1234
#define GetWorkDraw         @"GetWorkDraw"                  //获取业主施工图
//GetWorkDraw?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=1234
#define GetMRoomList        @"GetMRoomList"                 //获取样板间列表
//GetMRoomList?MachineID=aabbcc&UserID=334&ClientID=325
#define GetActList          @"GetActList"                   //获取活动列表
//GetActList?MachineID=aabbcc&UserID=13112344321&ClientID=1234&Type=0&NodeID=0
#define GetActDetail        @"GetActDetail"                 //获取活动详情
//GetActDetail?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ActID=1234
#define GetMRoomDetail      @"GetMRoomDetail"               //获取样板间详情
//GetMRoomDetail?MachineID=aabbcc&UserID=13112344321&ClientID=1234&MRoomID=1234
#define UpdateLoadPic       @"UpdateLoadPic"                //上传图片

#define UpdateHeadLogo      @"UpdateHeadLogo"               //上传头像
//UpdateHeadLogo?MachineID=aabbcc&UserID=13112344321&ClientID=1234&Logo=aaaa.jpg
#define GetWorkFlow         @"GetWorkFlow"                  //获取进度信息
//GetWorkFlow?MachineID=aabbcc&UserID=13112344321&ClientID=1234&ProjectID=1234
#define GetWorkFlowDetail   @"GetWorkFlowDetail"            //获取节点详情
//GetWorkFlowDetail?MachineID=aabbcc&UserID=131&ClientID=134&ProjectID=134&FlowOrder=320&NodeID=0
#define GetClientComplaint  @"GetClientComplaint"           //获取用户投诉历史列表
//GetClientComplaint?MachineID=aabbcc&UserID=13112344321&ClientID=2345&ProjectID=1234
#define SaveComplaint       @"SaveComplaint"                //用户提交投诉内容
//SaveComplaint?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&ClientID=158&Complaint=地面不平&PicPath=1.jpg|2.jgp
#define GetInvitationCode   @"GetInvitationCode"            //获取我的邀请码
//GetInvitationCode?Lat=38.76623&Lon=116.43213&LocaDesc=辽宁省沈阳市中山路15号3-5-3&MachineID=aabbcc&VerNum=2.4&Src=0&Channels=0&sessionid=S01239499890109823412&UserID=13112344321&ClientID=2345
#define ActSignUp           @"ActSignUp"                    //活动报名接口
//ActSignUp?MachineID=aabbcc&UserID=131&ClientID=234&ActID=1234&Mobile=13809876543&Caller=李先生
#define GetSysParam         @"GetSysParam"                //关于我们页面请求
//GetSysParam?MachineID=aabbcc&UserID=13112344321&ClientID=2345&sessionid=S0123456789
#define FreeDesignApply      @"FreeDesignApply"             //申请免费设计
//FreeDesignApply?MachineID=aabbcc&UserID=13112344321&ClientID=1234&Mobile=13112344321&Caller=李先生
#define ModifyPasswd        @"ModifyPasswd"                 //修改用户密码
//ModifyPasswd?MachineID=aabbcc&UserID=13112344321&ClientID=1234&OldPwd=1234&NewPwd=4321
#define UpdateWorkPic       @"UpdateWorkPic"              //上传工地照片
//UpdateWorkPic?Lat=38.76623&Lon=116.43213&LocaDesc=铁西区建设大路&MachineID=aabbcc&UserID=13112344321&ClientID=1234&UserNick=张三&ProjectID=1234&PicTitle=木工施工&Pic=aaa.jpg&Desc=木工正在施工&FlowOrder=320600&ButtonID=2013&ButtonName=木工施工&RoomType=0&RoomName=客厅&WorkerScoreQuality=3&WorkerScoreTime=4&WorkerScoreAttitude=5


//*******************************************************//
#define GetSynthesizeHomePage       @"GetSynthesizeHomePage"        //获取首页综合信息接口
#define GetHomeBannerDraw           @"GetHomeBannerDraw"            //首页混动图片
#define GetListOfImpressionDrawing  @"GetListOfImpressionDrawing"   //看装修-精选
#define GetListOfPano               @"GetListOfPano"                //看装修-360

#define GetKBListInLearnDec     @"GetKBListInLearnDec"      //学装修模块-获取只是库文章列表
//GetKBListInLearnDec?MachineID=aabbcc&UserID=13112344321&ClientID=1234&sessionid=1234567&Lon=123&Lat=123&Locadesc=辽宁省沈阳市&VerNum=2.4&Src=0&Channcels=0
#define GetDecBudget        @"GetDecBudget"                 //装修预算接口
//GetDecBudget?Area=100&RoomType=小户型&RoomCount=一室一厅一卫&DecRank=经济实惠&RoomSytle=简约型&RoomLocal=沈阳&MachineID=aabbcc&UserID=13112344321&ClientID=1234&sessionid=1234567&Lon=123&Lat=123&Locadesc=辽宁省沈阳市&VerNum=2.4&Src=0&Channels=0

#define GetDecDiary          @"GetDecDiary"                 //装修日记列表
//GetDecDiaryOfPrivate? DecDiaryID=1234&MachineID=aabbcc&UserID=13112344321&ClientID=1234&sessionid=1234567&Lon=123&Lat=123&Locadesc=辽宁省沈阳市&VerNum=2.4&Src=0&Channels=0







#endif
