//
//  YXNetRequestGroup.h
//  YXApp
//
//  Created by yintengxiang on 15/1/15.
//  Copyright (c) 2015年 YingXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetEngine;

//#import "NSDictionary+Exents.h"
//#import "YXHttpRequestConstants.h"
NS_ASSUME_NONNULL_BEGIN
@interface NetRequestGroup : NSObject
@property(readonly, nonatomic) NSMutableDictionary* requests;
@property(readonly, nonatomic) NSInteger numberOfRequests;


/**
 *  Get请求
 *
 *  @param URLString  URL
 *  @param parameters 参数集
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return 请求事务实例
 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                    netEngine:(NetEngine *)netEngine
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  POST请求
 *
 *  @param URLString  URL
 *  @param parameters 参数集
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return 请求事务实例
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                     netEngine:(NetEngine *)netEngine
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  PUT请求
 *
 *  @param URLString  URL
 *  @param parameters 参数集
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return 请求事务实例
 */
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                    netEngine:(NetEngine *)netEngine
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  PATCH请求
 *
 *  @param URLString  URL
 *  @param parameters 参数集
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return 请求事务实例
 */
- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                      netEngine:(NetEngine *)netEngine
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  DELETE请求
 *
 *  @param URLString  URL
 *  @param parameters 参数集
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return 请求事务实例
 */
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                       netEngine:(NetEngine *)netEngine
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  POST请求 带图片上传
 *
 *  @param URLString  URL
 *  @param parameters 参数集
 *  @param bodyDatas  图片集合
 *  @param identifer  文件标识
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return 请求事务实例
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                     netEngine:(NetEngine *)netEngine
     constructingBodyWithDatas:(NSArray*)bodyDatas
         constructingIdentifer:(NSString*)identifer
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  文件下载
 *
 *  @param URLString URL
 *  @param filePath  目标路径
 *  @param progress  下载进度
 *  @param success   success block
 *  @param failure   failure block
 *
 *  @return 下载请求事务实例
 */
- (NSURLSessionDownloadTask *)download:(NSString *)URLString
                              filePath:(NSString *)filePath
                             netEngine:(NetEngine *)netEngine
                              progress:(void (^)(NSProgress *downloadProgress))progress
                               success:(void (^)(NSURLResponse *response, NSURL *filePath))success
                               failure:(void (^)(NSURLResponse *response, NSError *error))failure;


/**
 *   文件上传
 */
- (NSURLSessionDataTask *)uploadImagesWithUrl:(NSString *)url
                                        parms:(NSDictionary *)parms
                                       images:(NSArray *)images
                                    netEngine:(NetEngine *)netEngine
                                     progress:(nullable void (^)(NSProgress *progress))progress
                                      success:(void (^)(NSDictionary *result))success
                                      failure:(void(^)(NSError *error))failure;
/**
 *  cancel Request ByPath (post method)
 *
 *  @param urlPath urlPath
 */
- (void)cancelRequestByUrlString:(nullable NSString *)urlPath;

/**
 *  cancel Request byUrl
 *
 *  @param nsUrl URL
 */
- (void)cancelRequestByNSURL:(nullable NSURL *)nsUrl;

/**
 *  cancel Request byOperation
 *
 *  @param operation operation
 */
- (void)cancelRequestByOperation:(nullable id)operation;

/**
 *  cancel All Request
 */
- (void)cancelAllRequest;//只取消本manager当中的request

/**
 *  获取请求事务
 *
 *  @param urlPath urlPath
 *
 *  @return 请求事务实例
 */
- (nullable NSURLSessionTask *)findOperationByUrlPath:(nullable NSString *)urlPath;

@end
NS_ASSUME_NONNULL_END
