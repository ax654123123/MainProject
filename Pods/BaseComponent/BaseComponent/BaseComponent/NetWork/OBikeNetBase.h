//
//  BGNetBase.h
//  BGNetBase
//
//  Created by yintengxiang on 14-6-11.
//  Copyright (c) 2014年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetEngine.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    OBikeApiSeverTypeDefault = 0,
    OBikeApiBikeSeverType,
} OBikeApiSever;


typedef enum : NSUInteger {
    OBikeApiGET = 0,
    OBikeApiPOST,
    OBikeApiPUT,
    OBikeApiPATCH,
    OBikeApiDELETE,
    OBikeApiCONNECT,
    OBikeApiHEAD,
    OBikeApiOPTIONS,
    OBikeApiTRACE,
} OBikeApiMethod;


@interface OBikeNetBase : NSObject

+(OBikeNetBase *)sharedNetBase;

/**
 *  发起请求
 *
 *  @param actionName    actionName description
 *  @param parameters    parameters description
 *  @param apiSever      apiSever description
 *  @param apiMethod     apiMethod description
 *  @param successBlock  successBlock description
 *  @param failBlock     failBlock description
 */

- (void)getDataFromAction:(NSString*)actionName
           withParameters:(NSDictionary*)parameters
        withOBikeApiSever:(OBikeApiSever)apiSever
       withOBikeApiMethod:(OBikeApiMethod)apiMethod
         withSuccessBlock:(void(^)(id backJson)) successBlock
            withFailBlock:(void(^)(NSError *error))failBlock;

/**
 *  发起请求  同上一个方法作用一样 只是多了一个isHiddenErrorHUD 默认是NO
 *
 *  @param actionName    actionName description
 *  @param parameters    parameters description
 *  @param apiSever      apiSever description
 *  @param apiMethod     apiMethod description
 *  @param isHiddenErrorHUD     是否显示错误提示HUD
 *  @param successBlock  successBlock description
 *  @param failBlock     failBlock description
 */
- (void)getDataFromAction:(NSString*)actionName
           withParameters:(NSDictionary*)parameters
        withOBikeApiSever:(OBikeApiSever)apiSever
       withOBikeApiMethod:(OBikeApiMethod)apiMethod
         isHiddenErrorHUD:(BOOL)isHiddenErrorHUD
         withSuccessBlock:(void(^)(id backJson)) successBlock
            withFailBlock:(void(^)(NSError *error))failBlock;


/**
 *  上传图片
 *
 *  @param actionName    actionName description
 *  @param parameters    parameters description
 *  @param imageArray    imageArray description
 *  @param withimageName withimageName description
 *  @param apiSever      apiSever description
 *  @param successBlock  successBlock description
 *  @param failBlock     failBlock description
 */
- (void)postDataFromAction:(NSString*)actionName
            withParameters:(NSDictionary*)parameters
            withimageArray:(NSArray*)imageArray
             withimageName:(NSString*)withimageName
           withOBikeApiSever:(OBikeApiSever)apiSever
          withSuccessBlock:(void(^)(id backJson)) successBlock
             withFailBlock:(void(^)(NSError *error))failBlock;


//上传多张图片
- (void)uploadImagesForAction:(NSString *)actionName
                                          parms:(NSDictionary *)parms
                                         images:(NSArray *)images
                                      apiServer:(OBikeApiSever)apiSever
                                       progress:(nullable void (^)(NSProgress * progress))progress
                                        success:(void (^)(NSDictionary *result))success
                                        failure:(void(^)(NSError *error))failure;
#pragma mark -
#pragma mark - Cancel

- (void)cancelRequestByUrlString:(NSString *)urlPath;

NS_ASSUME_NONNULL_END
@end

