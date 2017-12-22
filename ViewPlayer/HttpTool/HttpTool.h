//
//  HttpTool.h
//  EScience
//
//  Created by Yang on 2017/10/24.
//  Copyright © 2017年 WJyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

/*!
 *  @brief  服务器地址
 */
@property(nonatomic,copy)   NSString *baseUrl;

+ (HttpTool *)shareTool;

#define kHttpManager [HttpManager shareManager]

//通用网络请求POST
- (void)httpPOSTWithURL:(NSString *)url Params:(NSDictionary  *)dict  success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

// get
- (void)httpGetWithURL:(NSString *)url Params:(NSDictionary  *)dict success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

//上传图片 多张
- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL:(NSString *)url Params:(NSDictionary  *)dict andImages:(NSArray *)imageArray  success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

//上传图片 单张 进度条
- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL:(NSString *)url Params:(NSDictionary  *)dict andImages:(NSArray *)imageArray progress:(nullable void (^)(float))uploadProgress success:(void(^_Nonnull)(id _Nullable response))success failure:(void (^_Nullable)(NSError * _Nonnull error))failure;


// 上传图片 单张
- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL1:(NSString *)url Params:(NSDictionary  *)dict andImages:(NSArray *)imageArray AndName:(NSString *)name AndFileName:(NSString *)filaName success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

// 上传图片 视频
- (NSURLSessionDataTask *)httpPOSTUploadVideoWithURL:(NSString *)url Params:(NSDictionary  *)dict andVideo:(NSURL *)videoUrl AndName:(NSString *)name AndFileName:(NSString *)filaName success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;


//- (NSURLSessionDataTask *)httpPOSTUploadImageWithURL1:(NSString *)url Params:(NSDictionary  *)dict andImages:(NSArray *)imageArray  success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

// 取消制定请求
- (void)cancelAllHTTPOperationsWithPath:(NSString *)path;


+ (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

@end

