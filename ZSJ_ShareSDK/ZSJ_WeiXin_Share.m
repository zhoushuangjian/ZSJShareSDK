//
//  ZSJ_WeiXin_Share.m
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/5.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "ZSJ_WeiXin_Share.h"
#import "WXApi.h"
@implementation ZSJ_WeiXin_Share
+(ZSJ_WeiXin_Share*)ZSJShareSdk:(NSString *)WeiXin_AppId{
    static ZSJ_WeiXin_Share * Share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Share = [[self alloc]initWidhWeiXin_AppId:WeiXin_AppId];
    });
    return Share;
}
-(id)initWidhWeiXin_AppId:(NSString*)WeiXin_AppId{
    if ([super init]) {
        [WXApi registerApp:WeiXin_AppId];
    }
    return self;
}
-(BOOL)ZSJExamine{
    if ([WXApi isWXAppInstalled]) {
        // 检测微信是否支持 OpAi
        if ([WXApi isWXAppSupportApi]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        // 获取安装
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        return NO;
    }
}
-(void)ZSJSendWebpageObject:(enum WXScene)Scene{
   
    // 创建消息体对象
    WXMediaMessage * MediaMessage = [WXMediaMessage message];
    // 标题
    MediaMessage.title = _WeiXin_Title;
    // 描述
    MediaMessage.description = _WeiXin_Describe;
    // 图像
    [MediaMessage setThumbImage:_WeiXin_ShareImage];
    // 创建网络对象
    WXWebpageObject * WebpageObjec = [WXWebpageObject object];
    // 分享网址
    WebpageObjec.webpageUrl = _WeiXin_Url;
    // 对象的装载
    MediaMessage.mediaObject = WebpageObjec;
    [self SendWeiXin:MediaMessage Scene:Scene];
}
-(void)ZSJSendImageObject:(enum WXScene)Scene{
    // 创建消息体对象
    WXMediaMessage * MediaMessage = [WXMediaMessage message];
    // 标题
    MediaMessage.title = _WeiXin_Title;
    // 描述
    MediaMessage.description = _WeiXin_Describe;
    // 创建网络对象
    WXImageObject * ImageObject = [WXImageObject object];
    if (_WeiXin_ShareImageUrl.length) {
        // 图片网址
        ImageObject.imageUrl = _WeiXin_Url;
    }else if (_WeiXin_ShareImage){
        NSData * Data = UIImageJPEGRepresentation(_WeiXin_ShareImage, 0.5);
        ImageObject.imageData = Data ;
    }
    // 对象的装载
    MediaMessage.mediaObject = ImageObject;
    [self SendWeiXin:MediaMessage Scene:Scene];
}

-(void)ZSJSendMusicObject:(enum WXScene)Scene{
    // 创建消息体对象
    WXMediaMessage * MediaMessage = [WXMediaMessage message];
    // 标题
    MediaMessage.title = _WeiXin_Title;
    // 描述
    MediaMessage.description = _WeiXin_Describe;
    // 创建网络对象
    WXMusicObject * MusicObject = [WXMusicObject object];
    MusicObject.musicLowBandDataUrl = _WeiXin_musicLowBandDataUrl;
    MusicObject.musicLowBandUrl = _WeiXin_musicLowBandUrl;
    MusicObject.musicUrl = _WeiXin_musicUrl;
    MusicObject.musicDataUrl = _WeiXin_musicDataUrl;
    // 对象的装载
    MediaMessage.mediaObject = MusicObject;
    [self SendWeiXin:MediaMessage Scene:Scene];
}
-(void)ZSJSendVideoObject:(enum WXScene)Scene{
    // 创建消息体对象
    WXMediaMessage * MediaMessage = [WXMediaMessage message];
    // 标题
    MediaMessage.title = _WeiXin_Title;
    // 描述
    MediaMessage.description = _WeiXin_Describe;
    // 创建网络对象
    WXVideoObject * VideoObject = [WXVideoObject object];
    VideoObject.videoLowBandUrl = _WeiXin_videoLowBandUrl;
    VideoObject.videoUrl = _WeiXin_videoUrl;
    // 对象的装载
    MediaMessage.mediaObject = VideoObject;
    [self SendWeiXin:MediaMessage Scene:Scene];
}


-(void)SendWeiXin:(WXMediaMessage*)MediaMessage Scene:(enum WXScene)Scene{
    // 创建发射架
    SendMessageToWXReq * MessageToWXReq = [[SendMessageToWXReq alloc]init];
    // 是文本还是多媒体
    MessageToWXReq.bText = NO;
    // 消息信息对象
    MessageToWXReq.message = MediaMessage ;
    // 分享的场景
    MessageToWXReq.scene = Scene;
    // 发起分享
    [WXApi sendReq:MessageToWXReq];
}
@end
