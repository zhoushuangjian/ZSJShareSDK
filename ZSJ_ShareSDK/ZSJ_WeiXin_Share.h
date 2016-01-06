//
//  ZSJ_WeiXin_Share.h
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/5.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApiObject.h"
@interface ZSJ_WeiXin_Share : NSObject
//创建一个单利
+(ZSJ_WeiXin_Share*)ZSJShareSdk:(NSString*)WeiXin_AppId;
// 检测您的QQ是否安装（SSO ）
-(BOOL)ZSJExamine;
// 分享的网址
@property(nonatomic,strong) NSString * WeiXin_Url;
// 分享的标题
@property(nonatomic,strong) NSString * WeiXin_Title;
// 分享描述
@property(nonatomic,strong) NSString * WeiXin_Describe;
/*注意： QQ_ShareImage and  QQ_ShareImageUrl 只能一个 */
// 分享图片 < 32K
@property(nonatomic,strong) UIImage * WeiXin_ShareImage;
// 分享图片 < 32K
@property(nonatomic,strong) NSString * WeiXin_ShareImageUrl;
// 创建发送体（媒体文件）
-(void)ZSJSendWebpageObject:(enum WXScene)Scene;
// 创建发送体（图片文件）
-(void)ZSJSendImageObject:(enum WXScene)Scene;

/** 音乐网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString * WeiXin_musicUrl;
/** 音乐lowband网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString * WeiXin_musicLowBandUrl;
/** 音乐数据url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString * WeiXin_musicDataUrl;
/**音乐lowband数据url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString * WeiXin_musicLowBandDataUrl;
// 创建发送体（音乐文件）
-(void)ZSJSendMusicObject:(enum WXScene)Scene;
/** 视频网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString * WeiXin_videoUrl;
/** 视频lowband网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString * WeiXin_videoLowBandUrl;

// 创建发送体（视频文件）
-(void)ZSJSendVideoObject:(enum WXScene)Scene;

@end
