//
//  ViewController.m
//  ViewPlayer
//
//  Created by Yang on 2017/9/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "HttpTool.h"
#import "QBImagePickerController.h"
#import "UCVideoView.h"
#import "FMDatabase.h"
#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

#define  KScreenWidth self.view.frame.size.width
#define  KScreenHeight self.view.frame.size.height

//#define URL @"http://192.168.51.185:8080/userfiles/1/files/VID_20160831_073311.mp4"

#define URL @"http://v.jiefuku.com/2017112102.mp4"

@interface ViewController ()<UIWebViewDelegate,UISearchBarDelegate,MBProgressHUDDelegate,QBImagePickerControllerDelegate>
@property (nonatomic,strong)NSMutableArray *orderPictureArray;//图片数组
@property(nonatomic,strong)NSArray *videoArray;

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UCVideoView *videoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    /*
     // 设定位置和大小
     CGRect frame = CGRectMake(0,0,200,200);
     frame.size = [UIImage imageNamed:@"timg.gif"].size;
     //    frame.size.width = [UIImage imageNamed:@"启动页640.gif"].size.width / 2;
     //    frame.size.height = [UIImage imageNamed:@"启动页640.gif"].size.height / 2;
     // 读取gif图片数据
     NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"gif"]];
     // view生成
     UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
     webView.userInteractionEnabled = NO;//用户不可交互
     [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
     [self.view addSubview:webView];
     
     */
    
//    [self setUpView];
    //      [self.view addSubview:self.searchBar];
    //
    //    dict =  @{@"title":@"视频六",
    //              @"image":@"http://vimg3.ws.126.net/image/snapshot/2016/9/5/1/VBV4BEH51.jpg",
    //              @"video":@"http://flv2.bn.netease.com/videolib3/1609/03/lGPqA9142/SD/lGPqA9142-mobile.mp4"};
    //    [self setUpView];
    
    
    //    NSString *str1 = @"https://view.officeapps.live.com/op/view.aspx?src=";
    //    NSString *str2 = @"http://doc.24hoursdoctor.cn:8080/resources/upload/file/1.docx";
    //    NSString *str3 = [NSString stringWithFormat:@"%@%@",str1,str2];
    //    //    1、创建UIWebView：
    //    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    //
    //
    //    //    2、加载在线资源http内容
    //    NSURL* url = [NSURL URLWithString:str3];//创建URL
    //    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    //    [webView loadRequest:request];//加载
    //
    //    //    3、导航
    //    //    UIWebView类内部会管理浏览器的导航动作，通过goForward和goBack方法你可以控制前进与后退动作：
    //    [webView goBack];
    //    [webView goForward];
    //
    //    //    4、UIWebViewDelegate委托代理
    //
    //    webView.delegate = self;
    //
    //    //    5、显示网页视图UIWebView：
    //
    //    [self.view addSubview:webView];
    //
    //    __weak __typeof(&*self)ws = self;
    //
    //    [self.view addSubview:webView];
    //    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(ws.view.mas_top).offset(0);
    //        make.left.right.bottom.equalTo(ws.view);
    //    }];
    
    
    
    //    if (![QBImagePickerController isAccessible]) {
    //        NSLog(@"Error: Source is not accessible.");
    //    }
    
}

-(void)getData
{
    //从NSBundle目录读取
    NSString* dbPath = [[NSBundle mainBundle]pathForResource:@"departmentdata.db" ofType:@""];
    
    
    FMDatabase* database = [ FMDatabase databaseWithPath: dbPath];
    if ( ![ database open ] )
    {
        return;
    }
    
    // 查找表 AllTheQustions
    FMResultSet* resultSet = [ database executeQuery: @"select * from departmentClassA" ];
    resultSet = [database executeQuery:@"select * from departmentClassA"];
    
    //读取table表中所有字段
    NSMutableDictionary *dict = resultSet.columnNameToIndexMap;
    
    // 循环逐行读取数据resultSet next
    while ( [ resultSet next ] )
    {
        // 对应字段来取数据
        NSString* fileid = [ resultSet stringForColumn: @"id" ];
        NSString* fileName = [ resultSet stringForColumn: @"departmenta" ];
        
        NSLog(@"%@,    %@ ",fileName,fileid);
        
        // 读取完之后关闭数据库
//        [ database close ];
        ///斤斤计较军
    }
}



//-(NSMutableArray *)orderPictureArray
//{
//    if (!_orderPictureArray) {
//        _orderPictureArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"jiatupian"], nil];
//    }
//    return _orderPictureArray;
//}
//
//
//#pragma mark   选择图片方法
//- (void)clickTapEvet{
//    NSInteger index = 0;
//    for (int i = 0; i<self.orderPictureArray.count; i++) {
//        if (![self.orderPictureArray[i] isEqual:[UIImage imageNamed:@"jiatupian"]]) {
//            index++;
//        }
//        else
//        {
//            break;
//        }
//    }
//
//    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.maximumNumberOfSelection = 3-index;
//    imagePickerController.allowsMultipleSelection = YES;
//    imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
//    [self presentViewController:navigationController animated:YES completion:NULL];
//}
//
//#pragma mark   选择视频
//-(void)selectedVideoClick
//{
//    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.maximumNumberOfSelection = 1;
//    imagePickerController.allowsMultipleSelection = YES;
//    imagePickerController.filterType = QBImagePickerControllerFilterTypeVideos;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
//    [self presentViewController:navigationController animated:YES completion:NULL];
//}
//
//
//- (void)dismissImagePickerController
//{
//    if (self.presentedViewController) {
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    } else {
//        [self.navigationController popToViewController:self animated:YES];
//    }
//}
//
//
//#pragma mark - QBImagePickerControllerDelegate
//
//
//- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
//{
//    NSLog(@"*** imagePickerController:didSelectAsset:");
//    NSLog(@"%@", asset);
//
//    [self dismissImagePickerController];
//
//}
//
//- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
//{
//    NSLog(@"*** imagePickerController:didSelectAssets:");
//    NSLog(@"%@", assets);
//
//
//    [self dismissImagePickerController];
//
//    ///api/v1/uploadImage
//
//
////    if (assets.count > 0) {
////        UIImage *image;
////        for (int i = 0; i < assets.count; i++) {
////            ALAsset *asset_sign=[assets objectAtIndex:i];
////            NSLog(@"asset_one==%@",asset_sign);
////            image =[UIImage imageWithCGImage:asset_sign.defaultRepresentation.fullScreenImage];
////
////            NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] init];
////
////            NSArray *IMAGEARR = @[image];
////
////            [bodyDic setObject:@"1" forKey:@"userId"];
////
////            _videoImage.image = image
////
////            [[HttpTool shareTool] httpPOSTUploadImageWithURL2:@"api/v1/uploadImage" Params:bodyDic andImages:IMAGEARR AndName:@"imageFile" AndFileName:@"000" success:^(id response) {
////                NSLog(@"response%@",response);
////
////            } failure:^(NSError *error) {
////                NSLog(@"error%@",error);
////
////            }];
////        }
////    }
//
//
//    if (assets.count > 0) {
//        UIImage *image;
//        for (int i = 0; i < assets.count; i++) {
//            ALAsset *asset_sign = [assets objectAtIndex:i];
//            NSLog(@"asset_one==%@",asset_sign);
//            image =[UIImage imageWithCGImage:asset_sign.defaultRepresentation.fullScreenImage];
//
//            if ([[asset_sign valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
//            {
//                NSLog(@"- 文件日期: %@", [asset_sign valueForProperty:ALAssetPropertyDate]);
//                NSLog(@"- 文件名称: %@", [[asset_sign defaultRepresentation] filename]);
//                NSLog(@"- 文件大小: %lld", [[asset_sign defaultRepresentation] size]);
//                NSLog(@"- 文件URL: %@", [[asset_sign defaultRepresentation] url]);
//                NSLog(@"- 文件缩略图: %@", [UIImage imageWithCGImage:[asset_sign thumbnail]]);
//
//                _videoImage.image = [UIImage imageWithCGImage:[asset_sign thumbnail]];
//
//
//                if ([[asset_sign valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
//                {
//                    NSLog(@"- 文件日期: %@", [asset_sign valueForProperty:ALAssetPropertyDate]);
//                    NSLog(@"- 文件名称: %@", [[asset_sign defaultRepresentation] filename]);
//                    NSLog(@"- 文件大小: %lld", [[asset_sign defaultRepresentation] size]);
//                    NSLog(@"- 文件URL: %@", [[asset_sign defaultRepresentation] url]);
//                    NSLog(@"- 文件缩略图: %@", [UIImage imageWithCGImage:[asset_sign thumbnail]]);
//
//
//                    NSString *videoUrlStr = [NSString stringWithFormat:@"%@",[[asset_sign defaultRepresentation] url]];
//
//                    NSString *videoName = [NSString stringWithFormat:@"%@",[[asset_sign defaultRepresentation] filename]];
//
//                    NSURL *filePathURL  = [NSURL URLWithString:videoUrlStr];
//
//                    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:filePathURL  options:nil];
//
//                    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
//                    [formater setDateFormat:@"yyyyMMddHHmmss"];
//                    NSString *fileName = [NSString stringWithFormat:@"output-%@.mp4",[formater stringFromDate:[NSDate date]]];
//
//                    NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", fileName];
//                    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
//
//                    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
//                    {
//                        NSLog(@"outPath = %@",outfilePath);
//
//                        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
//                        exportSession.outputURL = [NSURL fileURLWithPath:outfilePath];
//                        exportSession.outputFileType = AVFileTypeMPEG4;
//                        [exportSession exportAsynchronouslyWithCompletionHandler:^{
//                            if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
//                                NSLog(@"AVAssetExportSessionStatusCompleted---转换成功");
//                                NSString *filePath = outfilePath;
//                                NSURL *filePathURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",outfilePath]];
//                                NSLog(@"转换完成_filePath = %@\n_filePathURL = %@",filePath,filePathURL);
//
//                                NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] init];
//                                [bodyDic setObject:@"1" forKey:@"userId"];
//
//                                [[HttpTool shareTool]httpPOSTUploadVideoWithURL:@"api/v1/uploadVideo" Params:bodyDic andVideo:filePathURL AndName:@"videoFile" AndFileName:videoName success:^(id response) {
//                                    NSLog(@"response%@",response);
//
//                                    [self ClearMovieFromDoucments];
//
//
//                                } failure:^(NSError *error) {
//                                    NSLog(@"error%@",error);
//                                }];                            }else{
//                                NSLog(@"转换失败,值为:%li,可能的原因:%@",(long)[exportSession status],[[exportSession error] localizedDescription]);
//                            }
//                        }];
//
//                    }
//                }
//            }
//    }
//    }
//}
//
//
//
////记得上传成功之后要删除沙盒中的视频文件哦！代码奉上
//#pragma mark - 清除documents中的视频文件
//-(void)ClearMovieFromDoucments{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
//    NSEnumerator *e = [contents objectEnumerator];
//    NSString *filename;
//    while ((filename = [e nextObject])) {
//        NSLog(@"%@",filename);
//        if ([filename isEqualToString:@"tmp.PNG"]) {
//            NSLog(@"删除%@",filename);
//            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
//            continue;
//        }
//        if ([[[filename pathExtension] lowercaseString] isEqualToString:@"mp4"]||
//            [[[filename pathExtension] lowercaseString] isEqualToString:@"mov"]||
//            [[[filename pathExtension] lowercaseString] isEqualToString:@"png"]) {
//            NSLog(@"删除%@",filename);
//            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
//        }
//    }
//}
//
//
//- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
//{
//    NSLog(@"*** imagePickerControllerDidCancel:");
//    [self dismissImagePickerController];
//}


-(UCVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [[UCVideoView alloc]initWithFrame:CGRectZero];
        
        _videoView.videoPlayBlock = ^(NSInteger index,KYVedioPlayer *kyvedioPlayer) {
            [self setVideoPlayerWithIndex:index AndKYVedioPlayer:kyvedioPlayer];
        };
        
        _videoView.videoBlock = ^(NSInteger index) {
            if (index == PlayerType_closesss) {
                [self setNeedsStatusBarAppearanceUpdate];
            }
        };
    }
    return _videoView;
}

-(void)setVideoPlayerWithIndex:(NSInteger)index AndKYVedioPlayer:(KYVedioPlayer *)kyvedioPlayer
{
    if (index == PlayerType_Full)
    {
        self.navigationController.navigationBarHidden = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [kyvedioPlayer showFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft player:kyvedioPlayer withFatherView:self.view];
    }
    else if(index == PlayerType_Small || index == PlayerType_close)
    {
        self.navigationController.navigationBarHidden = NO;
        [self showCellCurrentVedioPlayer];
    }
    else if(index == PlayerType_pause)
    {
        
    }
}




/**
 * 显示 从全屏来当前的cell视频
 **/
-(void)showCellCurrentVedioPlayer{

    [self.videoView.vedioPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        self.videoView.vedioPlayer.transform = CGAffineTransformIdentity;
        self.videoView.vedioPlayer.frame = self.videoView.videoImage.bounds;
        self.videoView.vedioPlayer.playerLayer.frame =  self.videoView.vedioPlayer.bounds;
        [self.videoView.videoImage addSubview:self.videoView.vedioPlayer];
        [self.videoView.videoImage bringSubviewToFront:self.videoView.vedioPlayer];

        [self.videoView.vedioPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoView.vedioPlayer).with.offset(20);
            make.right.equalTo(self.videoView.vedioPlayer).with.offset(-20);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.videoView.vedioPlayer).with.offset(0);
        }];
        [self.videoView.vedioPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoView.vedioPlayer).with.offset(0);
            make.right.equalTo(self.videoView.vedioPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(self.videoView.vedioPlayer).with.offset(0);
        }];
        [self.videoView.vedioPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoView.vedioPlayer.topView).with.offset(45);
            make.right.equalTo(self.videoView.vedioPlayer.topView).with.offset(-45);
            make.center.equalTo(self.videoView.vedioPlayer.topView);
            make.top.equalTo(self.videoView.vedioPlayer.topView).with.offset(0);
        }];
        [self.videoView.vedioPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoView.vedioPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.videoView.vedioPlayer).with.offset(5);
        }];
        [self.videoView.vedioPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.videoView.vedioPlayer);
            make.width.equalTo(self.videoView.vedioPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        self.videoView.vedioPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        self.videoView.vedioPlayer.fullScreenBtn.selected = NO;
    }];

}
//#pragma  mark - 初始化方法
- (void)setUpView
{
    //http://v.jiefuku.com/2017112003.mp4
    [self.view addSubview:self.videoView];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
    
    self.videoView.URLString = URL;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

