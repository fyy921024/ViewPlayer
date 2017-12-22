//
//  HttpTool.m
//  EScience
//
//  Created by Yang on 2017/10/24.
//  Copyright © 2017年 WJyong. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

#define kHttp_BaseUrl  @"http://192.168.51.185:8080/" // 李春辉本地

@interface HttpTool ()

@property(nonatomic,strong) NSMutableArray *taskArray;


/*!
 *  @brief  请求方法名,用于判断是哪个网络请求
 */
@property(nonatomic,copy)   NSString *methordNameUrl;

@property (nonatomic, copy) NSString *finalIpaUrl;

@end

@implementation HttpTool

+ (HttpTool *)shareTool
{
    static HttpTool *tool = nil;
    static dispatch_once_t singleManager;
    dispatch_once(&singleManager, ^{
        tool = [[self alloc] init];
        
    });
    return tool;
}


- (AFHTTPSessionManager *)httpRequestSessionManager
{
    static  AFHTTPSessionManager *manager = nil;
    static dispatch_once_t singleManager;
    dispatch_once(&singleManager, ^{
        manager = [AFHTTPSessionManager manager];
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/gif",@"image/png",nil];
        manager.requestSerializer.timeoutInterval = 18;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-access-id"];
        [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-signature"];
    });
    return manager;
}

//通用网络请求POST
#define kSignKey @"yaolaizaixian"
- (void)httpPOSTWithURL:(NSString *)url Params:(NSDictionary  *)dict success:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    //     [dict setValue:kApiVersion forKey:@"apiversion"];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    //    [bodyDic setObject:@"1" forKey:@"resource"];
    [self httpPost:url params:bodyDic success:^(id responsObject) {
        success(responsObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



#pragma mark  底层发送post

-(void)httpPost:(NSString *)URLString params:(id)params success:(void (^)(id responsObject))success failure:(void (^)(NSError *error))failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",self.baseUrl,URLString];
    NSURLSessionDataTask *task =  [self.httpRequestSessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
    
    if (task)
    {
        NSDictionary *dic = @{
                              @"apiUrl":URLString
                              };
        [self.taskArray addObject:dic];
        
        NSLog(@"%@",dic);
    }
    
}
#pragma mark get
- (void)httpGetWithURL:(NSString *)url Params:(NSDictionary  *)dict success:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    //     [dict setValue:kApiVersion forKey:@"apiversion"];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    //    [bodyDic setObject:@"1" forKey:@"resource"];
    [self httpGet:url params:bodyDic success:^(id responsObject) {
        success(responsObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",kHttp_BaseUrl, url];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    　　//如果你不需要将通过body传 那就参数放入parameters里面
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    NSLog(@"requestURL:%@",requestUrl);
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 设置body 在这里将参数放入到body
    [request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
        
        if(responseObject!=nil){
            success(responseObject);
        }
        
        if (error) {
            failure(error);
        }
    }]resume];
}


#pragma mark  底层发送get
-(void)httpGet:(NSString *)URLString params:(id)params success:(void (^)(id responsObject))success failure:(void (^)(NSError *error))failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",self.baseUrl,URLString];
    
    NSURLSessionDataTask *task =  [self.httpRequestSessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
    
    if (task)
    {
        NSDictionary *dic = @{
                              @"apiUrl":URLString
                              };
        [self.taskArray addObject:dic];
        
        NSLog(@"%@",dic);
    }
    
}


- (NSString *)encodeToPercentEscapeString: (NSString *) input{  NSString*
    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             
                                                                             
                                                                             NULL, /* allocator */
                                                                             
                                                                             (__bridge CFStringRef)input,
                                                                             
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             
                                                                             kCFStringEncodingUTF8);
    return outputStr;
}

#pragma mark 上传图片 多张
- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL:(NSString *)url Params:(NSDictionary  *)dict andImages:(NSArray *)imageArray success:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    NSURLSessionDataTask *task = [self httpPOSTUploadImageWithURL:url Params:dict andImages:imageArray progress:nil success:success failure:failure];
    
    return task;
}

//上传图片
- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL:(NSString *)url Params:(NSDictionary  *)bodyDic andImages:(NSArray *)imageArray progress:(nullable void (^)(float))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *fUrl = [NSString stringWithFormat:@"%@%@",self.baseUrl,url];
    
    NSURLSessionDataTask *task =  [self.httpRequestSessionManager POST:fUrl parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (UIImage *oneImage in imageArray) {
            i++;
            if (![oneImage isEqual:[UIImage imageNamed:@"jiatupian"]]) {
                NSData *imageData = UIImagePNGRepresentation(oneImage);
                NSString *fileName = [NSString stringWithFormat:@"image%d",i];
                //                NSString *name = [NSString stringWithFormat:@"image%d",i];
                [formData appendPartWithFileData:imageData name:@"imagesfile" fileName:fileName mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            
            float p = uploadProgress.fractionCompleted;
            
            progress(p);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
    
    return task;
    
}

#pragma mark 上传图片 单张
- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL1:(NSString *)url Params:(NSDictionary  *)dict andImages:(NSArray *)imageArray AndName:(NSString *)name AndFileName:(NSString *)filaName success:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    NSURLSessionDataTask *task = [self httpPOSTUploadImageWithURL1:url Params:dict andImages:imageArray AndName:name AndFileName:filaName progress:nil success:success failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL1:(NSString *)url Params:(NSDictionary  *)bodyDic andImages:(NSArray *)imageArray AndName:(NSString *)name AndFileName:(NSString *)filaName progress:(nullable void (^)(float))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *fUrl = [NSString stringWithFormat:@"%@%@",self.baseUrl,url];
    
    NSURLSessionDataTask *task =  [self.httpRequestSessionManager POST:fUrl parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageArray.count>0) {
            for (UIImage *oneImage in imageArray) {
                NSData *imageData = UIImagePNGRepresentation(oneImage);
                
                [formData appendPartWithFileData:imageData name:name fileName:filaName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            
            float p = uploadProgress.fractionCompleted;
            
            progress(p);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
    
    return task;
}

#pragma mark 上传视频
- (NSURLSessionDataTask *)httpPOSTUploadVideoWithURL:(NSString *)url Params:(NSDictionary  *)dict andVideo:(NSURL *)videoUrl AndName:(NSString *)name AndFileName:(NSString *)filaName success:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    NSURLSessionDataTask *task = [self httpPOSTUploadVideoWithURL:url Params:dict andVideo:videoUrl AndName:name AndFileName:filaName progress:nil success:success failure:failure];
    return task;
}

- (NSURLSessionDataTask *)httpPOSTUploadVideoWithURL:(NSString *)url Params:(NSDictionary  *)bodyDic andVideo:(NSURL *)videoUrl AndName:(NSString *)name AndFileName:(NSString *)filaName progress:(nullable void (^)(float))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *fUrl = [NSString stringWithFormat:@"%@%@",self.baseUrl,url];
    
    NSURLSessionDataTask *task =  [self.httpRequestSessionManager POST:fUrl parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:videoUrl name:name fileName:filaName mimeType:@"video/mp4" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            float p = uploadProgress.fractionCompleted;
            progress(p);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(error);
        }
    }];
    
    return task;
}

#pragma mark- CancelNetWork
- (void)cancelAllHTTPOperationsWithPath:(NSString *)path
{
    AFHTTPSessionManager *manager;
    NSMutableArray *mutArray = self.taskArray;
    if(mutArray.count == 0)
        return;
    
    for (NSInteger i = 0;i < mutArray.count ; i++)
    {
        NSDictionary *dic = mutArray[i];
        if ([dic[@"apiUrl"] isEqualToString:path])
        {
            manager = dic[@"session"];
            [mutArray removeObjectAtIndex:i];
            self.taskArray = mutArray;
            break;
        }
    }
    [[manager session] getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        if(dataTasks.count > 0)
            [self cancelTasksInArray:dataTasks withPath:path];
    }];
}

-(void)cancelTasksInArray:(NSArray *)tasksArray withPath:(NSString *)path
{
    for (NSURLSessionTask *task in tasksArray) {
        NSRange range = [[[[task currentRequest]URL] absoluteString] rangeOfString:path];
        if (range.location != NSNotFound) {
            [task cancel];
        }
    }
}

@end

