//
//  UCVideoView.m
//  EScience
//
//  Created by Yang on 2017/10/19.
//  Copyright © 2017年 WJyong. All rights reserved.
//

#import "UCVideoView.h"

#import "KYVideo.h"

#define font_size 15

@interface UCVideoView()<KYVedioPlayerDelegate>

@property(nonatomic,strong)UIView *lineView;

@end

@implementation UCVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    __weak __typeof (&*self)ws = self;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top).offset(18 );
        make.left.equalTo(ws.mas_left).offset(15 );
        make.right.equalTo(ws.mas_right).offset(-15 );
        make.height.equalTo(@(15 ));
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.nameLabel.mas_bottom).offset(6 );
        make.left.equalTo(ws.mas_left).offset(15 );
        make.right.equalTo(ws.mas_right).offset(-15 );
        make.height.equalTo(@(0.5 ));
    }];
    
        [self addSubview:self.videoImage];
        [self.videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.lineView.mas_bottom).offset(6 );
            make.left.equalTo(ws.mas_left).offset(15 );
            make.height.equalTo(@(118 ));
            make.width.equalTo(@(238 ));
        }];
    
        [self.videoImage addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.videoImage.mas_centerY);
            make.centerX.equalTo(ws.videoImage.mas_centerX);
            make.height.width.equalTo(@(38 ));
        }];
    
        [self.videoImage addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.videoImage.mas_top).offset(1.5 );
            make.right.equalTo(ws.videoImage.mas_right).offset(-1.5 );
            make.width.height.equalTo(@(36 ));
        }];
    
        [self addSubview:self.sizeLabel];
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.mas_right).offset(-15 );
            make.left.equalTo(ws.videoImage.mas_right).offset(15 );
            make.height.equalTo(@(15 ));
            make.bottom.equalTo(ws.videoImage.mas_bottom);
        }];
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UCBaseCostomer labelWithFrame:CGRectZero font:[UIFont systemFontOfSize:font_size] textColor:[UIColor blackColor] text:@""];
    }
    return _nameLabel;
}

-(UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [UCBaseCostomer labelWithFrame:CGRectZero font:[UIFont systemFontOfSize:font_size] textColor:[UIColor grayColor] backgroundColor:[UIColor clearColor] textAlignment:2 numOfLines:1 text:@""];
    }
    return _sizeLabel;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UCBaseCostomer viewWithFrame:CGRectZero backgroundColor:[UIColor lightGrayColor]];
    }
    return _lineView;
}

-(UIImageView *)videoImage
{
    if (!_videoImage) {
        _videoImage = [UCBaseCostomer imageViewWithFrame:CGRectZero backGroundColor:[UIColor clearColor] cornerRadius:0 userInteractionEnabled:YES image:@""];
    }
    return _videoImage;
}
-(UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UCBaseCostomer buttonWithFrame:CGRectZero backGroundColor:[UIColor clearColor] text:@"" image:@"video_cover_play_nor"];
        [_playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UCBaseCostomer buttonWithFrame:CGRectZero backGroundColor:[UIColor clearColor] text:@"" image:@"ic_close"];
        
        [_closeBtn addTarget:self action:@selector(clostBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(KYVedioPlayer *)vedioPlayer
{
    if (!_vedioPlayer) {
        _vedioPlayer = [[KYVedioPlayer alloc]initWithFrame:CGRectMake(0,0,self.videoImage.frame.size.width, self.videoImage.frame.size.height)];
        _vedioPlayer.delegate = self;
        _vedioPlayer.closeBtnStyle = CloseBtnStyleClose;
    }
    return _vedioPlayer;
}

-(void)clostBtnClick
{
    if (self.videoBlock) {
        self.videoBlock(2);
    }
}

#pragma mark 播放按钮
-(void)playBtnClick
{
    [self closeCurrentCellVedioPlayer];
    
    if (self.vedioPlayer) {
        [self releasePlayer];
        self.vedioPlayer.URLString = self.URLString;
    }
    else{
        self.vedioPlayer.URLString = self.URLString;
    }
    
    [self.videoImage addSubview:self.vedioPlayer];
    [self.videoImage bringSubviewToFront:self.vedioPlayer];
    [self.playBtn.superview sendSubviewToBack:self.videoImage];
    [self.vedioPlayer play];
}

/**
 * 关闭当前cell 中的 视频
 **/
-(void)closeCurrentCellVedioPlayer{
    
    //    if (currentVideo != nil &&  currentIndexPath != nil) {
    //
    [self.playBtn.superview bringSubviewToFront:self.playBtn];
    [self.vedioPlayer removeFromSuperview];
    [self.vedioPlayer.player pause];
    
    if (self.videoBlock) {
        self.videoBlock(PlayerType_closesss);
    }
}

#pragma mark - KYVedioPlayerDelegate 播放器委托方法
//点击播放暂停按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    
    if (self.videoPlayBlock) {
        self.videoPlayBlock(PlayerType_pause,kyvedioPlayer);
    }
    NSLog(@"[KYVedioPlayer] clickedPlayOrPauseButton ");
}
//点击关闭按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer clickedCloseButton:(UIButton *)closeBtn{
    
    NSLog(@"[KYVedioPlayer] clickedCloseButton ");
    
    if (kyvedioPlayer.isFullscreen == YES) { //点击全屏模式下的关闭按钮
        if (self.videoPlayBlock) {
            self.videoPlayBlock(PlayerType_close,kyvedioPlayer);
        }
    }else{
        [self closeCurrentCellVedioPlayer];
    }
}
//点击分享按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer onClickShareBtn:(UIButton *)closeBtn{
    
    NSLog(@"[KYVedioPlayer] onClickShareBtn ");
    
}
//点击全屏按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    NSLog(@"[KYVedioPlayer] clickedFullScreenButton ");
    
    if (fullScreenBtn.isSelected) {//全屏显示
        kyvedioPlayer.isFullscreen = YES;
        
        if (self.videoPlayBlock) {
            self.videoPlayBlock(PlayerType_Full,kyvedioPlayer);
        }
        }else{
        if (self.videoPlayBlock) {
            self.videoPlayBlock(PlayerType_Small,kyvedioPlayer);
        }
    }
}
//单击WMPlayer的代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer singleTaped:(UITapGestureRecognizer *)singleTap{
    
    NSLog(@"[KYVedioPlayer] singleTaped ");
}
//双击WMPlayer的代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    
    NSLog(@"[KYVedioPlayer] doubleTaped ");
}

///播放状态
//播放失败的代理方法
-(void)kyvedioPlayerFailedPlay:(KYVedioPlayer *)kyvedioPlayer playerStatus:(KYVedioPlayerState)state{
    NSLog(@"[KYVedioPlayer] kyvedioPlayerFailedPlay  播放失败");
}
//准备播放的代理方法
-(void)kyvedioPlayerReadyToPlay:(KYVedioPlayer *)kyvedioPlayer playerStatus:(KYVedioPlayerState)state{
    
    NSLog(@"[KYVedioPlayer] kyvedioPlayerReadyToPlay  准备播放");
}
//播放完毕的代理方法
-(void)kyplayerFinishedPlay:(KYVedioPlayer *)kyvedioPlayer{
    
    NSLog(@"[KYVedioPlayer] kyvedioPlayerReadyToPlay  播放完毕");
    
    [self closeCurrentCellVedioPlayer];
}

/**
 *  注销播放器
 **/
- (void)releasePlayer
{
    [self.vedioPlayer resetKYVedioPlayer];
    self.vedioPlayer = nil;
}

- (void)dealloc
{
    [self releasePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"KYNetworkVideoCellPlayVC dealloc");
}



-(void)setURLString:(NSString *)URLString
{
    _URLString = URLString;
    
    self.videoImage.image = [self firstFrameWithVideoURL:URLString size:self.videoImage.frame.size];
}

#pragma mark ---- 获取图片第一帧
- (UIImage *)firstFrameWithVideoURL:(NSString *)urlStr size:(CGSize)size
{
    NSURL *url = [NSURL URLWithString:urlStr];
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}
@end
