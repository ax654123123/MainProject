//
//  YXNetRequestGroup.m
//  YXApp
//
//  Created by yintengxiang on 15/1/15.
//  Copyright (c) 2015年 YingXiang. All rights reserved.
//

#import "NetRequestGroup.h"
#import "NetEngine.h"

#import "AIFNetworkUtil.h"

//#import "AFHTTPRequestOperation.h"
//#import "AFHTTPRequestOperationManager.h"

//#import "PKWSevers+Login.h"
//#import "PKWUserManager.h"

@interface NetRequestGroup ()

@property(strong, nonatomic)NSMutableDictionary* requests;


@end

@implementation NetRequestGroup
- (id)init
{
    self = [super init];
    if (self) {
        self.requests = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequest];
}

- (NSInteger)numberOfRequests
{
    return [self.requests count];
}

- (void)removeOperation:(id)operation
{
    if (self.requests) {
        NSArray *requestUrlArray = [self.requests allKeys];
        for (NSString* urlPath in requestUrlArray) {
            if (operation) {
                if (self.requests[urlPath] == operation) {
                    [self.requests removeObjectForKey:urlPath];
                    return;
                }
            }
        }
    }
}

- (void)addOperation:(id)operation urlPath:(NSString *)urlPath
{
    if (urlPath && operation) {
        [self.requests setObject:operation forKey:urlPath];
    }
}

- (NSURLSessionTask *)findOperationByUrlPath:(NSString *)urlPath
{
    if ([urlPath length] > 0) {
        return [self.requests objectForKey:urlPath];
    }
    return nil;
}

- (void)cancelRequestByUrlString:(NSString *)urlPath
{
    if ([urlPath length] == 0) {
        return;
    }
    NSURLSessionTask *task = [self findOperationByUrlPath:urlPath];
    if (task) {
        [task cancel];
        [self.requests removeObjectForKey:urlPath];
    }
}

- (void)cancelRequestByNSURL:(NSURL *)nsUrl
{
    NSString * urlString = [nsUrl absoluteString];
    [self cancelRequestByUrlString:urlString];
}

- (void)cancelRequestByOperation:(NSURLSessionTask *)operation
{
    if (operation) {
        [operation cancel];
        [self removeOperation:operation];
    }
}

- (void)cancelAllRequest
{
    NSArray* newRequests = [self.requests allValues];
    for (NSURLSessionTask* operation in newRequests) {
        [operation cancel];
    }
    [self.requests removeAllObjects];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                    netEngine:(NetEngine *)netEngine
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
//    if ([URLString length] == 0) {
//        return nil;
//    }
    
    [self cancelRequestByUrlString:URLString];
    
    __weak __typeof(self) weakSelf = self;
    __block NSURLSessionDataTask *operation = nil;
    operation = [netEngine GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
#if DEBUG
        NSLog(@"URL:%@\n Response:%@\n",[task.currentRequest.URL absoluteString],responseObject);
#endif
        
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (responseObject) {
             if (success) {
                success(task, responseObject);
            }
        }else {
            if (failure) {
                failure(task, nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeOperation:operation];
        NSInteger errorCode = error.code;
#if DEBUG
        if (errorCode != NSURLErrorCancelled) {
            NSLog(@"%@",error);
        }
#endif
        if (failure && (errorCode != NSURLErrorCancelled)) {
            failure(task, error);
        }
    }];
    
#if DEBUG
    NSLog(@"URL:%@\n",[operation.currentRequest.URL absoluteString]);
#endif
    [self addOperation:operation urlPath:URLString];
    return operation;
}


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                     netEngine:(NetEngine *)netEngine
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
//    if ([URLString length] == 0) {
//        return nil;
//    }
//      [self cancelRequestByUrlString:URLString];
   
    __weak __typeof(self) weakSelf = self;
    __block NSURLSessionDataTask *operation = nil;
    operation = [netEngine POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
       
#if DEBUG
        NSLog(@"URL:%@\n Response:%@\n",[task.currentRequest.URL absoluteString],responseObject);
#endif
//        __strong __typeof(weakSelf) strongSelf = weakSelf;

        if (responseObject) {
             if (success) {
                success(task, responseObject);
            }
        }else {
            if (failure) {
                failure(task, nil);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeOperation:operation];
        NSInteger errorCode = error.code;
#if DEBUG
        NSLog(@"ERROR:%@", error);
        if (errorCode == NSURLErrorCancelled) {
            NSLog(@"cancelRequestByUser");
        }
#endif
        if (failure && (errorCode != NSURLErrorCancelled)) {
            failure(task, error);
        }
    }];
    
#if DEBUG
    NSLog(@"URL:%@\n POST:%@\n", [operation.currentRequest.URL absoluteString],parameters);
#endif
    
    [self removeOperation:operation];
    [self addOperation:operation urlPath:URLString];
    return operation;
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                    parameters:(id)parameters
                     netEngine:(NetEngine *)netEngine
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //    if ([URLString length] == 0) {
    //        return nil;
    //    }
    //      [self cancelRequestByUrlString:URLString];
    
    __weak __typeof(self) weakSelf = self;
    __block NSURLSessionDataTask *operation = nil;
    operation = [netEngine PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
        NSLog(@"URL:%@\n Response:%@\n",[task.currentRequest.URL absoluteString],responseObject);
#endif
        //        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (responseObject) {
            if (success) {
                success(task, responseObject);
            }
        }else {
            if (failure) {
                failure(task, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeOperation:operation];
        NSInteger errorCode = error.code;
#if DEBUG
        NSLog(@"ERROR:%@", error);
        if (errorCode == NSURLErrorCancelled) {
            NSLog(@"cancelRequestByUser");
        }
#endif
        if (failure && (errorCode != NSURLErrorCancelled)) {
            failure(task, error);
        }
    }];
    
#if DEBUG
    NSLog(@"URL:%@\n POST:%@\n", [operation.currentRequest.URL absoluteString],parameters);
#endif
    
    [self removeOperation:operation];
    [self addOperation:operation urlPath:URLString];
    return operation;
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                   parameters:(id)parameters
                    netEngine:(NetEngine *)netEngine
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //    if ([URLString length] == 0) {
    //        return nil;
    //    }
    //      [self cancelRequestByUrlString:URLString];
    
    __weak __typeof(self) weakSelf = self;
    
    __block NSURLSessionDataTask *operation = nil;
    operation = [netEngine PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
        NSLog(@"URL:%@\n Response:%@\n",[task.currentRequest.URL absoluteString],responseObject);
#endif
        //        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (responseObject) {
            if (success) {
                success(task, responseObject);
            }
        }else {
            if (failure) {
                failure(task, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeOperation:operation];
        NSInteger errorCode = error.code;
#if DEBUG
        NSLog(@"ERROR:%@", error);
        if (errorCode == NSURLErrorCancelled) {
            NSLog(@"cancelRequestByUser");
        }
#endif
        if (failure && (errorCode != NSURLErrorCancelled)) {
            failure(task, error);
        }
    }];

    
#if DEBUG
    NSLog(@"URL:%@\n POST:%@\n", [operation.currentRequest.URL absoluteString],parameters);
#endif
    
    [self removeOperation:operation];
    [self addOperation:operation urlPath:URLString];
    return operation;
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                       netEngine:(NetEngine *)netEngine
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //    if ([URLString length] == 0) {
    //        return nil;
    //    }
    //      [self cancelRequestByUrlString:URLString];
    
    __weak __typeof(self) weakSelf = self;
    
    __block NSURLSessionDataTask *operation = nil;
    operation = [netEngine DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if DEBUG
        NSLog(@"URL:%@\n Response:%@\n",[task.currentRequest.URL absoluteString],responseObject);
#endif
        //        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (responseObject) {
            if (success) {
                success(task, responseObject);
            }
        }else {
            if (failure) {
                failure(task, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeOperation:operation];
        NSInteger errorCode = error.code;
#if DEBUG
        NSLog(@"ERROR:%@", error);
        if (errorCode == NSURLErrorCancelled) {
            NSLog(@"cancelRequestByUser");
        }
#endif
        if (failure && (errorCode != NSURLErrorCancelled)) {
            failure(task, error);
        }
    }];
    
    
#if DEBUG
    NSLog(@"URL:%@\n POST:%@\n", [operation.currentRequest.URL absoluteString],parameters);
#endif
    
    [self removeOperation:operation];
    [self addOperation:operation urlPath:URLString];
    return operation;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                     netEngine:(NetEngine *)netEngine
     constructingBodyWithDatas:(NSArray*)bodyDatas
         constructingIdentifer:(NSString*)identifer
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
//    if ([URLString length] == 0) {
//        return nil;
//    }
//    [self cancelRequestByUrlString:URLString];

    __weak __typeof(self) weakSelf = self;
    __block NSURLSessionDataTask *operation = nil;
    operation = [netEngine POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSUInteger i = 0 ; i < [bodyDatas count]; i++) {
            
            if ([[bodyDatas objectAtIndex:i] isKindOfClass:[UIImage class]]) {
                NSData *imageData = UIImageJPEGRepresentation((UIImage*)[bodyDatas objectAtIndex:i], 1);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                // 上传图片，以文件流的格式
                [formData appendPartWithFileData:imageData name:identifer fileName:fileName mimeType:@"image/png"];
            }else {
                [formData appendPartWithFileData:[bodyDatas objectAtIndex:i] name:identifer fileName:[NSString stringWithFormat:@"%@.png",identifer] mimeType:@"image/png"];
            }
            
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
#if DEBUG
        NSLog(@"%@\n POST:%@", task.originalRequest,responseObject);
#endif
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } else {
            if (failure) {
                failure(task, nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeOperation:operation];
        NSInteger errorCode = error.code;
#if DEBUG
        NSLog(@"%@", error);
        if (errorCode == NSURLErrorCancelled) {
            NSLog(@"cancelRequestByUser");
        }
#endif
        if (failure && (errorCode != NSURLErrorCancelled)) {
            failure(task, error);
        }
    }];
    
#if DEBUG
    NSLog(@"URL:%@\n POST:%@\n", [operation.currentRequest.URL absoluteString],parameters);
#endif
    
    
//   NSProgress *progress = [netEngine uploadProgressForTask:operation];
    
    [self removeOperation:operation];
    [self addOperation:operation urlPath:URLString];
    return operation;
}

- (NSURLSessionDownloadTask *)download:(NSString *)URLString
                              filePath:(NSString *)filePath
                             netEngine:(NetEngine *)netEngine
                              progress:(void (^)(NSProgress *downloadProgress))progress
                               success:(void (^)(NSURLResponse *response, NSURL *filePath))success
                               failure:(void (^)(NSURLResponse *response, NSError *error))failure;
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    __weak __typeof(self) weakSelf = self;
    
    
    
    __block NSURLSessionDownloadTask *operation = nil;
    operation = [netEngine downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [weakSelf removeOperation:operation];
        if (!error) {
#if DEBUG
            NSLog(@"downloadSucceed targetPath:%@",filePath);
#endif
            if (success) {
                success(response,filePath);
            }
        }
        else{
            NSInteger errorCode = error.code;
#if DEBUG
            NSLog(@"%@", error);
            if (errorCode == NSURLErrorCancelled) {
                NSLog(@"cancelRequestByUser");
            }
#endif
            if (failure && (errorCode != NSURLErrorCancelled)) {
                failure(response, error);
            }
        }
    }];
    
    [operation resume];
    
    [self removeOperation:operation];
    [self addOperation:operation urlPath:URLString];
    return operation;
}

/**
 *上传多张图片
 */
- (NSURLSessionDataTask *)uploadImagesWithUrl:(NSString *)url
                                        parms:(NSDictionary *)parms
                                       images:(NSArray *)images
                                    netEngine:(NetEngine *)netEngine
                                     progress:(nullable void (^)(NSProgress *uploadProgress))progress
                                      success:(void (^)(NSDictionary *result))success
                                      failure:(void(^)(NSError *error))failure{
    NSURLSessionDataTask *task = [netEngine POST:url parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(NSDictionary *item in images){
            id value = [item objectForKey:@"file"];        //支持四种数据类型：NSData、UIImage、NSURL、NSString
            NSString *name = [item objectForKey:@"key"];            //文件字段的key
            NSString *fileName = [item objectForKey:@"name"];       //文件名称
            NSString *mimeType = [item objectForKey:@"type"];       //文件类型
            if (mimeType) {
                mimeType = mimeType;
            }else {
                mimeType = @"image/jpeg";
            }
            name = name ? name : @"file";
            [formData appendPartWithFileData:UIImageJPEGRepresentation(value, 0.5) name:name fileName:fileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress)progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)success([self dictionaryWithData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)failure(error);
    }];
    
    [self removeOperation:task];
    [self addOperation:task urlPath:url];

    return task;

}

#pragma mark - 数据转换
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
