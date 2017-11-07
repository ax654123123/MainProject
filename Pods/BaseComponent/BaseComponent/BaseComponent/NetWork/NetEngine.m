//
//  NetEngine.m
//  LLProjectNetBase
//
//  Created by yintengxiang on 15/6/24.
//  Copyright (c) 2015年 LLProjectNetBase. All rights reserved.
//

#import "NetEngine.h"
#import "OBikeHttpURLs.h"

#define APP_VERSION @"package-ver"
#define APP_NAME @"package-name"
#define X_CIPHER_SPEC @"x-cipher-spec"

#define ShortVersionString ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define Identifier ([[NSBundle mainBundle] bundleIdentifier])

@implementation NetEngine


+ (instancetype)sharedBikeEngine
{
    static NetEngine* sharedBikeEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBikeEngine = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:URLDomainName]];
        sharedBikeEngine.requestSerializer.timeoutInterval = 20;
    });
    return sharedBikeEngine;
}
- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        // 设置header
        
       
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];

        if (!_requestGroup) {
            _requestGroup = [[NetRequestGroup alloc] init];
        }
    }
    
    return self;
}
@end
