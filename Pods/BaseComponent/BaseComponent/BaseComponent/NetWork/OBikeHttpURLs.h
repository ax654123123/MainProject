//
//  Header.h
//
//  Created by yintengxiang on 14-6-6.
//  Copyright (c) 2014年 yintengxiang. All rights reserved.
//

//



#ifdef DEBUG

#define URLDomainName [[NSUserDefaults standardUserDefaults] objectForKey:@"DEBUG_SERVER_HOST_BIKE"]

#define WEBURL   [[NSUserDefaults standardUserDefaults] objectForKey:@"Web-url"]

#else

// 正式环境
#define URLDomainName     @"https://mobile.o.bike/api/"

#define WEBURL   @""

#endif

// 正式环境
//#define DEBUG_SERVER_HOST_BIKE     @"https://mobile.o.bike/api/"

// 开发环境
//#define DEBUG_SERVER_HOST_BIKE     @"https://mobile-dev.o.bike/api/"

// 预发布环境
//#define DEBUG_SERVER_HOST_BIKE     @"https://mobile-release.o.bike/api/"

//测试环境
#define DEBUG_SERVER_HOST_BIKE   @"https://mobile-test.o.bike/api/"

// 向兵电脑
//#define DEBUG_SERVER_HOST_BIKE     @"http://172.16.25.224:8084/api/"

// H5的环境 正式环境就是空字符串
#define DEBUG_H5_WEBURL     @"-test"



#define V1 @"v1/" //代表接口版本 以后有可能有v2 v3等等

#define DBLog(s, ...)	NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])



/**
 *  用户相关
 *
 */
#define Member V1@"member/"

#define LoginByMobile             Member@"login"//登录

#define Register                  Member@"register"//注册
#define GetCodeByPhone            Member@"register"//获取注册验证码
#define RegisterCheckCode         Member@"register/validatesms"//注册用检验SMSCode

#define ResetPassword             Member@"reset"//重置密码
#define ResetByMobile             Member@"reset/token"//重置密码用发送短信验证码
#define GetResetToken             Member@"reset/token"//重置密码用检验SMSCode

#define PostStudent               Member@"student"//学生认证
#define GetStudent                Member@"student"//学生认证失败原因

#define UpdateToken               Member@"refresh_token"//更新token

#define CheckPic                  Member@"pic/validation"//验证图形验证码，用于登录

#define GetUserInfo               Member@"current"//获取用户信息
#define UpdateUserInfo            Member@"current"//更新用户信息
#define UserIdenty                Member@"identity"//用户信息认证
#define GetUserAccountInfo        Member@"account"//用户个人账户
#define CheckAccount              Member@"account/*"//用户个人账户
#define GetUserAcoountChangeInfo  Member@"accounts"//用户账户变更明细-分页start=1
#define GetAccountDetail          Member@"accounts/details"//+statementNo
#define GetUserScoreInfo          Member@"credits"//用户积分明细-分页start=1
#define GetUserNegativeScoreInfo  Member@"credits/details"//用户负面积分明细

#define GetPayInfo                Member@"amount" //支付获取orderid
#define PayPalPayment                Member@"paypalPayment"
#define CheckApplePay             V1@"tapPay/apple"
#define PaySuccess                Member@"pay_success" //支付获取orderid
#define Refund                    Member@"refund" //退款
#define Bike_fault                Member@"bike_fault"//上报故障
#define BingCard                  Member@"card" //绑定信用卡
#define QueryCardList             Member@"card" //查询信用卡列表
#define CancelBingCard            Member@"card/*"//解除绑定
#define SetDefaultCard            Member@"card/default/*"//设置默认支付方式
#define GetActivityInfo           V1@"activity/activities"//活动列表
#define GetVIPinfo                Member@"vip"//会员信息，get
#define TopUpVIP                  Member@"amount"//会员充值，put
#define GetCouponsList            Member@"coupon/list"//获取用户优惠券列表
#define CashCoupon                Member@"coupon/exchange"//兑换优惠券
#define MemberSystem              Member@"system"
#define GetParkingList            V1@"station"//停车位列表
#define GetNoParkingList          V1@"station/noparking" // 禁停位列表

#define PutUserLocation           V1@"app-open-log"//APP启动，上报用户位置

#define GetGashInfo               V1@"gash/info"//gash支付
#define GetValidMenthod           V1@"pay-method"//获取可用的支付方式

#define AddCardForTapPay          V1@"tapPay/card"//tappay 支付 添加信用卡
#define AddCardForTapPayAndAnyen          Member@"card/tw"//tappay 支付 添加信用卡
#define AddCardForBluePay         V1@"bluePay/bandUrl"//bluePay 添加信用卡
#define CheckBluPay               V1@"bluePay/payResult"//bluePay 检查支付结果
#define ShareCredit               Member@"credit"//分享增加信用分

#define CreatePaperInvoice       V1@"invoice/createPaper" //纸质发票
#define refundReason             Member@"reason"//退款原因
#define AdyenPay                 Member"adyen_pay"
/**
 *  Facebook登录
 *
 */
//#define FaceBookCheck         Member@"thirdPartyBinding/thirdPartyBinded"//2.3.3以前的版本
#define FaceBookCheckV2         Member@"thirdPartyBinding/oneclick"
#define FaceBookSMS           Member@"thirdPartyBinding/phoneBinded"
#define FaceBookCheckSMS      Member@"thirdPartyBinding/validateSms"
#define FaceBookLogin         Member@"thirdPartyBinding"
/**
 *  更改手机号
 *
 */
#define ChangePhone           Member@"changePhone/validate"
#define ChangePhoneSMS        Member@"changePhone/sms"
#define ChangePhoneCheck      Member@"changePhone"

#define WeixinHaspaid        V1@"wechat/haspaid" //微信支付 支付结果校验

#define PushConfig   Member@"config"

/**
 *  上传相关
 *
 */
#define Upload    V1@"upload/"
#define PostImage      Upload@"file"//上传图片,返回URL
#define PostMultImages Upload@"files"  //上传多张图片
/**
 *  自行车相关
 *
 */
#define Bike V1@"bike/"

#define GetUsefulBike     Bike@"list"//获取经纬度范围内可用自行车
#define RequestToOpenBike Bike@"*/unlock"//请求开锁
#define GetBikeLockStatus Bike@"*/unlockStatus"//查询锁状态
#define GetBikeLoaction   Bike@"location"//上报位置
#define PutBikeLoaction   Bike@"locations"//批量上报位置
#define PutBikePic        Bike@"picUrl"//上传自行车照片
#define GetTripTrack      Bike@"track/point"//骑行轨迹
#define GetBikeInfo       Bike@""   //获取单车信息

//自行车开关锁
#define GetLockCode Bike@"*/lockNo"      //申请解锁 获取锁编号
#define GetUnlockPass Bike@"unlockPass"    //申请解锁 获取解锁码
#define UploadLockMessage Bike@"lockMessage"  //上传锁信息 0开锁1关锁
#define UploadHisLockMessage Bike@"hisLockMessage"  //上传锁信息 0开锁1关锁
#define UnlockFail Bike@"*/unlockFail"  //开锁失败
#define HandLock Bike@"handLock"  //手动关锁

/**
 *  订单
 *
 */
#define Order V1@"order/"
#define GetBikeOrder      Order@"unComplete"//查询订单状态
#define GetOrderlist      Order@"list"      //订单列表-分页current=1
/**
 *  map
 *
 */
#define BookBike            Bike@"*/book"//车辆预约
#define CancelBookBike      Bike@"*/cancelBook"//取消车辆预约

/**
 *  获取消息
 *
 */
#define GetAppMessage       V1@"message"

/**
 *  获取消息
 *
 */
#define GetUpdateInfo       V1@"app_version"

/**
 *  获取图形验证
 *
 */
#define GetLoginImage      V1@"pic/code"

// VIP 自动续费开启关闭
#define VIPRenew        Member@"vip/renew"
