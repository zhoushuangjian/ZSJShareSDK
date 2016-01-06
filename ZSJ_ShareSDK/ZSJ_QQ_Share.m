//
//  ZSJ_QQ_Share.m
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/5.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "ZSJ_QQ_Share.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentApiInterface.h>
@interface ZSJ_QQ_Share ()<TencentSessionDelegate>
@end
@implementation ZSJ_QQ_Share
// 初始化
+(ZSJ_QQ_Share*)ZSJShareSdk:(NSString *)QQ_AppId{
    static ZSJ_QQ_Share * Share = nil;
    // GCD 创建单利
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Share = [[self alloc]initWithQQ_AppId:QQ_AppId];
    });
    return Share;
}
// 重构方法
-(id)initWithQQ_AppId:(NSString*)QQ_AppId{
    if ([super init]) {
        // 我们进行注册
        TencentOAuth * OAuth =  [[TencentOAuth alloc]initWithAppId:QQ_AppId andDelegate:self];
        NSLog(@"%@",OAuth.accessToken);
    }
    return self;
}
// 检测QQ是否安装
-(BOOL)ZSJExamine{
    if ([QQApiInterface isQQInstalled]) {
         // 判断是否支持API调用
        if ([QQApiInterface isQQSupportApi]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[QQApiInterface getQQInstallUrl]]];
        return NO;
    }
}
// 结构消息的发送
-(void)ZSJSendApiNewsObject:(QQ_ShareType)Type{
    QQApiNewsObject * ApiNewsObjec = nil ;
    // 信息体的创建
    if (self.QQ_ShareImage) {
        NSData * QQ_Data = UIImageJPEGRepresentation(self.QQ_ShareImage, 0.5);
          ApiNewsObjec = [[QQApiNewsObject alloc]initWithURL:[NSURL URLWithString:_QQ_Url] title:_QQ_Title description:_QQ_Describe previewImageData:QQ_Data targetContentType:QQApiURLTargetTypeNews];
    }else if (self.QQ_ShareImageUrl.length){
        ApiNewsObjec = [[QQApiNewsObject alloc]initWithURL:[NSURL URLWithString:_QQ_Url] title:_QQ_Title description:_QQ_Describe previewImageURL:[NSURL URLWithString:_QQ_ShareImageUrl] targetContentType:QQApiURLTargetTypeNews];
    }
    //创建发送平台
    SendMessageToQQReq * QQReq = [SendMessageToQQReq reqWithContent:ApiNewsObjec];
    // 调用发送体，开始发送
    [self sendObject:Type tager:QQReq];
}
// 图片型
-(void)ZSJSendApiVideoObject:(QQ_ShareType)Type{
    QQApiVideoObject * ApiVideoObject = nil ;
    // 信息体的创建
    if (self.QQ_ShareImage) {
        NSData * QQ_Data = UIImageJPEGRepresentation(self.QQ_ShareImage, 0.5);
        ApiVideoObject = [[QQApiVideoObject alloc]initWithURL:[NSURL URLWithString:_QQ_Url] title:_QQ_Title description:_QQ_Describe previewImageData:QQ_Data targetContentType:QQApiURLTargetTypeVideo];
    }else if (self.QQ_ShareImageUrl.length){
        ApiVideoObject = [[QQApiVideoObject alloc]initWithURL:[NSURL URLWithString:_QQ_Url] title:_QQ_Title description:_QQ_Describe previewImageURL:[NSURL URLWithString:_QQ_ShareImageUrl] targetContentType:QQApiURLTargetTypeVideo];
    }
    //创建发送平台
    SendMessageToQQReq * QQReq = [SendMessageToQQReq reqWithContent:ApiVideoObject];
    // 调用发送体，开始发送
    [self sendObject:Type tager:QQReq];

}
// 音频型
-(void)ZSJSendApiAudioObject:(QQ_ShareType)Type{
    QQApiAudioObject * ApiAudioObject = nil ;
    // 信息体的创建
    if (self.QQ_ShareImage) {
        NSData * QQ_Data = UIImageJPEGRepresentation(self.QQ_ShareImage, 0.5);
        ApiAudioObject = [[QQApiAudioObject alloc]initWithURL:[NSURL URLWithString:_QQ_Url] title:_QQ_Title description:_QQ_Describe previewImageData:QQ_Data targetContentType:QQApiURLTargetTypeAudio];
    }else if (self.QQ_ShareImageUrl.length){
        ApiAudioObject = [[QQApiAudioObject alloc]initWithURL:[NSURL URLWithString:_QQ_Url] title:_QQ_Title description:_QQ_Describe previewImageURL:[NSURL URLWithString:_QQ_ShareImageUrl] targetContentType:QQApiURLTargetTypeAudio];
    }
    //创建发送平台
    SendMessageToQQReq * QQReq = [SendMessageToQQReq reqWithContent:ApiAudioObject];
    // 调用发送体，开始发送
    [self sendObject:Type tager:QQReq];
}
// 类型公共方法
-(void)sendObject:(QQ_ShareType)Type tager:(id)object{
    if (Type == QQ) {
        [QQApiInterface sendReq:object];
    }else if(Type == QZone){
        [QQApiInterface SendReqToQZone:object];
    }else if (Type == QQGroup){
        [QQApiInterface SendReqToQQGroupTribe:object];
    }
}
-(void)tencentDidLogin{
    
}
-(void)tencentDidNotNetWork{
    
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    
}
@end
