//
//  UCVideoView.h
//  EScience
//
//  Created by Yang on 2017/10/19.
//  Copyright © 2017年 WJyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UCBaseCostomer.h"
#import "KYVedioPlayer.h"

typedef NS_ENUM(NSInteger,PlayerType) {
    
    /// 关闭
    PlayerType_close = 1,
    /// 暂停
    PlayerType_pause,
        /// 开始
    PlayerType_start,
    /// 全屏
    PlayerType_Full,
    /// 小屏
    PlayerType_Small,
    
    PlayerType_closesss
};

typedef void(^UCVideoViewPlayBlock)(NSInteger index,KYVedioPlayer *kyvedioPlayer);

typedef void(^UCVideoViewBlock)(NSInteger index);

@interface UCVideoView : UIView

@property(nonatomic,strong)UILabel *nameLabel,*sizeLabel;
@property(nonatomic,strong)UIImageView *videoImage;
@property(nonatomic,strong)UIButton *playBtn,*closeBtn;
@property(nonatomic,copy)NSString *URLString;
@property(nonatomic,strong)KYVedioPlayer *vedioPlayer;


@property(nonatomic,copy)UCVideoViewBlock videoBlock;
@property(nonatomic,copy)UCVideoViewPlayBlock videoPlayBlock;

@end
