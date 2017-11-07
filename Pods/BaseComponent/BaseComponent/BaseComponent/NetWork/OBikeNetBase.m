//
//  BGNetBase.m
//  BGNetBase
//
//  Created by yintengxiang on 14-6-11.
//  Copyright (c) 2014年 BG. All rights reserved.
//

#import "OBikeNetBase.h"
#import "OBikeHttpURLs.h"

@interface OBikeNetBase()

@end

@implementation OBikeNetBase

+(OBikeNetBase *)sharedNetBase{
    static dispatch_once_t pred;
    static OBikeNetBase *_sharedNetBase = nil;
    
    dispatch_once(&pred, ^{ _sharedNetBase = [[self alloc] init]; });

    return _sharedNetBase;
}

- (NSDictionary *)getFinalpostParams:(NSDictionary *)postparams ApiSever:(OBikeApiSever)apiSever
{
    NSMutableDictionary* finalParams = (NSMutableDictionary *)[self getFinalpostParams:postparams];
    
    return finalParams;
}

//获取最终Post数据
- (NSDictionary *)getFinalpostParams:(NSDictionary *)postparams
{
    NSMutableDictionary* finalParams = [[NSMutableDictionary alloc] initWithDictionary:postparams];
    
//    [finalParams setValue:[OpenUDID value] forKey:@"device_id"];
    
    return finalParams;
}
// 根据请求类型得到不同的BASEURL
- (NetEngine *)netEngineForApiSever:(OBikeApiSever)apiSever
{
    /*
     由于目前只有一种域名 所以baseurl只有这一个，此处修改成返回同一个NetEngine 但是这个枚举保留防止以后用的到
     */
    switch (apiSever) {
            
        case OBikeApiSeverTypeDefault:
            return [NetEngine sharedBikeEngine];
        case OBikeApiBikeSeverType:
            return [NetEngine sharedBikeEngine];
        default:
            break;
    }
}
// 为以后如果有不同的域名作区分
- (NSString *)getActionNameWithOldActionName:(NSString *)oldActionName ApiSever:(OBikeApiSever)apiSever
{
    NSString *newActionName = oldActionName;
    
    switch (apiSever) {
            
        case OBikeApiSeverTypeDefault:
            return newActionName;
        case OBikeApiBikeSeverType:
            return newActionName;
        default:
            break;
    }
}

- (void)configNetEngineWithMethod:(OBikeApiMethod)method netEngine:(NetEngine *)netEngine
{
   
    switch (method) {
        case OBikeApiGET:
            netEngine.responseSerializer = [AFJSONResponseSerializer serializer];
            netEngine.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case OBikeApiPOST:
        case OBikeApiPUT:
        case OBikeApiPATCH:
        case OBikeApiDELETE:
        case OBikeApiCONNECT:
        case OBikeApiHEAD:
        case OBikeApiOPTIONS:
        case OBikeApiTRACE:
            netEngine.responseSerializer = [AFJSONResponseSerializer serializer];
            netEngine.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            break;
    }
    // 设置header
    [self configNetEngine:netEngine];
    
}
- (void)configNetEngine:(NetEngine *)netEngine{

    
    [netEngine.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [netEngine.requestSerializer setValue:app_Version forHTTPHeaderField:@"version"];
    
    
    [netEngine.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    netEngine.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [(AFJSONResponseSerializer *)netEngine.responseSerializer setRemovesKeysWithNullValues:YES];
//    DLog(@"150=====%@",netEngine.requestSerializer.HTTPRequestHeaders);
}
#pragma mark - 解密最终的回调数据

- (void)dataForHttpWithResponseObject:(id)responseObject
                     isHiddenErrorHUD:(BOOL)isHiddenErrorHUD
                     withSuccessBlock:(void(^)(id backJson))successBlock
                        withFailBlock:(void(^)(NSError *error))failBlock
                           againHttps:(void(^)(void))againHttps
{
    //解密数据
    NSDictionary *responseDict = (NSDictionary *)responseObject;//[OBikeEncryptManager decryptionHttpResponseWithObject:responseObject];
    
    if (responseDict) {
        if ([responseDict[@"success"] integerValue] == 1) {
            if (responseDict[@"data"]) {
                successBlock(responseDict[@"data"]);
            }else {
                NSError *error = [NSError errorWithDomain:@"数据为空" code:-100 userInfo:@{@"key":@"serverError"}];
                failBlock(error);
            }
            return;
        }else {
            NSError *error = [NSError errorWithDomain:@"数据错误" code:-100 userInfo:@{@"key":@"serverError"}];
            failBlock(error);
        }
    }else {
        NSError *error = [NSError errorWithDomain:@"服务器报错" code:-100 userInfo:@{@"key":@"serverError"}];
        failBlock(error);
    }
}

- (void)dataForHttpWithResponseObject:(id)responseObject
                           fromAction:(NSString*)actionName
                       withParameters:(NSDictionary*)parameters
                    withOBikeApiSever:(OBikeApiSever)apiSever
                   withOBikeApiMethod:(OBikeApiMethod)apiMethod
                     isHiddenErrorHUD:(BOOL)isHiddenErrorHUD
                     withSuccessBlock:(void(^)(id backJson))successBlock
                        withFailBlock:(void(^)(NSError *error))failBlock
{
    __weak typeof(self) wself = self;
    [self dataForHttpWithResponseObject:responseObject isHiddenErrorHUD:isHiddenErrorHUD withSuccessBlock:successBlock withFailBlock:failBlock againHttps:^{
        [wself getDataFromAction:actionName withParameters:parameters withOBikeApiSever:apiSever withOBikeApiMethod:apiMethod withSuccessBlock:successBlock withFailBlock:failBlock];
    }];
}

#pragma mark - 发起请求

- (void)getDataFromAction:(NSString*)actionName
           withParameters:(NSDictionary*)parameters
        withOBikeApiSever:(OBikeApiSever)apiSever
       withOBikeApiMethod:(OBikeApiMethod)apiMethod
         withSuccessBlock:(void(^)(id backJson)) successBlock
            withFailBlock:(void(^)(NSError *error))failBlock
{
    
    [self getDataFromAction:actionName withParameters:parameters withOBikeApiSever:apiSever withOBikeApiMethod:apiMethod isHiddenErrorHUD:NO withSuccessBlock:successBlock withFailBlock:failBlock];
    
}

- (void)getDataFromAction:(NSString*)actionName
           withParameters:(NSDictionary*)parameters
        withOBikeApiSever:(OBikeApiSever)apiSever
       withOBikeApiMethod:(OBikeApiMethod)apiMethod
         isHiddenErrorHUD:(BOOL)isHiddenErrorHUD
         withSuccessBlock:(void(^)(id backJson)) successBlock
            withFailBlock:(void(^)(NSError *error))failBlock
{
    // 添加统一参数
    NSDictionary * finalPostParameters = [self getFinalpostParams:parameters ApiSever:apiSever];
    
    // 初始化不同的域名BSAEURL
    NetEngine *netEngine = [self netEngineForApiSever:apiSever];
    
    //根据请求方式做不同操作
    [self configNetEngineWithMethod:apiMethod netEngine:netEngine];
    
    //根据不同的apisever选择不同的接口名字
    actionName = [self getActionNameWithOldActionName:actionName ApiSever:apiSever];
    
    
    switch (apiMethod) {
        case OBikeApiGET:
        {
            __weak typeof(self) wself = self;
            [netEngine.requestGroup GET:actionName parameters:finalPostParameters netEngine:netEngine success:^(NSURLSessionDataTask *task, id responseObject) {
                [wself dataForHttpWithResponseObject:responseObject
                                          fromAction:actionName
                                      withParameters:parameters
                                   withOBikeApiSever:apiSever
                                  withOBikeApiMethod:apiMethod
                                    isHiddenErrorHUD:isHiddenErrorHUD
                                    withSuccessBlock:successBlock
                                       withFailBlock:failBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [OBikeNetBase showHttpErrorMessageWithTask:task];
                failBlock(error);
            }];
            
        }
            break;
            
        case OBikeApiPOST:
        {
            __weak typeof(self) wself = self;
            [netEngine.requestGroup POST:actionName parameters:finalPostParameters netEngine:netEngine success:^(NSURLSessionDataTask *task, id responseObject) {
                [wself dataForHttpWithResponseObject:responseObject
                                          fromAction:actionName
                                      withParameters:parameters
                                   withOBikeApiSever:apiSever
                                  withOBikeApiMethod:apiMethod
                                    isHiddenErrorHUD:isHiddenErrorHUD
                                    withSuccessBlock:successBlock
                                       withFailBlock:failBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [OBikeNetBase showHttpErrorMessageWithTask:task];
                failBlock(error);
            }];
            
        }
            break;
            
        case OBikeApiPUT:
        {
            __weak typeof(self) wself = self;
            [netEngine.requestGroup PUT:actionName parameters:finalPostParameters netEngine:netEngine success:^(NSURLSessionDataTask *task, id responseObject) {
                [wself dataForHttpWithResponseObject:responseObject
                                          fromAction:actionName
                                      withParameters:parameters
                                   withOBikeApiSever:apiSever
                                  withOBikeApiMethod:apiMethod
                                    isHiddenErrorHUD:isHiddenErrorHUD
                                    withSuccessBlock:successBlock
                                       withFailBlock:failBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [OBikeNetBase showHttpErrorMessageWithTask:task];
                failBlock(error);
            }];
            
        }
            break;
            
        case OBikeApiPATCH:
        {
            __weak typeof(self) wself = self;
            [netEngine.requestGroup PATCH:actionName parameters:finalPostParameters netEngine:netEngine success:^(NSURLSessionDataTask *task, id responseObject) {
                [wself dataForHttpWithResponseObject:responseObject
                                          fromAction:actionName
                                      withParameters:parameters
                                   withOBikeApiSever:apiSever
                                  withOBikeApiMethod:apiMethod
                                    isHiddenErrorHUD:isHiddenErrorHUD
                                    withSuccessBlock:successBlock
                                       withFailBlock:failBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [OBikeNetBase showHttpErrorMessageWithTask:task];
                failBlock(error);
            }];
            
        }
            break;
            
        case OBikeApiDELETE:
        {
            __weak typeof(self) wself = self;
            [netEngine.requestGroup DELETE:actionName parameters:finalPostParameters netEngine:netEngine success:^(NSURLSessionDataTask *task, id responseObject) {
                [wself dataForHttpWithResponseObject:responseObject
                                          fromAction:actionName
                                      withParameters:parameters
                                   withOBikeApiSever:apiSever
                                  withOBikeApiMethod:apiMethod
                                    isHiddenErrorHUD:isHiddenErrorHUD
                                    withSuccessBlock:successBlock
                                       withFailBlock:failBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [OBikeNetBase showHttpErrorMessageWithTask:task];
                failBlock(error);
            }];
            
        }
            break;
            
        case OBikeApiCONNECT:
        case OBikeApiHEAD:
        case OBikeApiOPTIONS:
        case OBikeApiTRACE:
            break;
            
        default:
            break;
    }
    
    

}


#pragma mark - POST 图片

- (void)postDataFromAction:(NSString*)actionName
            withParameters:(NSDictionary*)parameters
            withimageArray:(NSArray*)imageArray
             withimageName:(NSString*)withimageName
           withOBikeApiSever:(OBikeApiSever)apiSever
          withSuccessBlock:(void(^)(id backJson)) successBlock
             withFailBlock:(void(^)(NSError *error))failBlock
{
    // 添加统一参数
    NSDictionary * finalPostParameters = [self getFinalpostParams:parameters ApiSever:apiSever];
    
    // 初始化不同的域名BSAEURL
    NetEngine *netEngine = [self netEngineForApiSever:apiSever];
    
    //根据请求方式做不同操作
    [self configNetEngineWithMethod:OBikeApiPOST netEngine:netEngine];
    
    //获取不同域名
    actionName = [self getActionNameWithOldActionName:actionName ApiSever:apiSever];
    
    __weak typeof(self) wself = self;
    [netEngine.requestGroup POST:actionName parameters:finalPostParameters netEngine:netEngine constructingBodyWithDatas:imageArray constructingIdentifer:withimageName success:^(NSURLSessionDataTask *task, id responseObject) {
        [wself dataForHttpWithResponseObject:responseObject isHiddenErrorHUD:NO withSuccessBlock:successBlock withFailBlock:failBlock againHttps:^{

        }];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [OBikeNetBase showHttpErrorMessageWithTask:task];
        failBlock(error);
    }];
}

#pragma mark - POST 图片 带进度

//上传多张图片
- (void)uploadImagesForAction:(NSString *)actionName
                        parms:(NSDictionary *)parms
                       images:(NSArray *)images
                    apiServer:(OBikeApiSever)apiSever
                     progress:(nullable void (^)(NSProgress * uploadProgress))progress
                      success:(void (^)(NSDictionary *result))success
                      failure:(void(^)(NSError *error))failure{
    
    // 初始化不同的域名BSAEURL
    NetEngine *netEngine = [self netEngineForApiSever:apiSever];
    //根据请求方式做不同操作
    [self configNetEngineWithMethod:OBikeApiPOST netEngine:netEngine];
    //获取不同域名
    actionName = [self getActionNameWithOldActionName:actionName ApiSever:apiSever];
    
    [netEngine.requestGroup uploadImagesWithUrl:actionName parms:parms images:images netEngine:netEngine progress:^(NSProgress * uploadProgress) {
        if(progress)progress(uploadProgress);
    } success:^(NSDictionary * _Nonnull result) {
        if(success)success(result);
    } failure:^(NSError * _Nonnull error) {
        if(failure)failure(error);
    }];
}

#pragma mark - ERROR

//获取HTTP状态码并输出
+ (void)showHttpErrorMessageWithTask:(NSURLSessionDataTask *)task
{
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    if (!response) {
    }else if (response.statusCode == 404) {
    }else if (response.statusCode == 500) {
    }else{
    }
}

#pragma mark - cancel URL

- (void)cancelRequestByUrlString:(NSString *)urlPath
{
    [[NetEngine sharedBikeEngine].requestGroup cancelRequestByUrlString:urlPath];
}

- (id)dictionaryWithData:(id)data
{
    NSDictionary *object = data;
    if ([data isKindOfClass:[NSData class]])
    {
        object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        object = [data object];
    }
    
    return object?:data;
}
@end
