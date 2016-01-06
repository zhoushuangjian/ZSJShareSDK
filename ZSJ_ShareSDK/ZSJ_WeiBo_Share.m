//
//  ZSJ_WeiBo_Share.m
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/5.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "ZSJ_WeiBo_Share.h"
#import "WeiboSDK.h"
@implementation ZSJ_WeiBo_Share
+(ZSJ_WeiBo_Share*)ZSJShareSdk:(NSString *)Weibo_AppId{
    static ZSJ_WeiBo_Share * Share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Share = [[self alloc]initWidthWeibo_AppId:Weibo_AppId];
    });
    return Share;
}
-(id)initWidthWeibo_AppId:(NSString*)Weibo_AppId{
    if ([super init]) {
        // 开启调试
        [WeiboSDK enableDebugMode:YES];
        // 注册第三方Sdk
        [WeiboSDK registerApp:Weibo_AppId];
    }
    return self;
}
-(BOOL)ZSJExamine{
    if ([WeiboSDK isWeiboAppInstalled]) {
        if ([WeiboSDK isCanShareInWeiboAPP]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WeiboSDK getWeiboAppInstallUrl]]];
        return NO;
    }
}
// 创建发送对象
-(void)ZSJSendObject:(ObjectType)ObjectType{
    //创建认证对象
    WBAuthorizeRequest * AuthorizeRequest = [WBAuthorizeRequest request];
    // 授权回调网址
    AuthorizeRequest.redirectURI = _WeiBo_RedirectURI;
    //scope
    AuthorizeRequest.scope = _WeiBo_Scope;
    // 构建分享的对象
    WBSendMessageToWeiboRequest * ToWeiboRequest = [WBSendMessageToWeiboRequest requestWithMessage:[self makeMessageObjec:ObjectType]];
    ToWeiboRequest.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                @"Other_Info_1": [NSNumber numberWithInt:123],
                                @"Other_Info_2": @[@"obj1", @"obj2"],
                                @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    // 创建发送对象
    [WeiboSDK sendRequest:ToWeiboRequest];
}
// 创建消息结构
-(WBMessageObject*)makeMessageObjec:(ObjectType)ObjectType{
    WBMessageObject * MessageObject = [WBMessageObject message];
    if (ObjectType == Objec) {
        WBWebpageObject *WebpageObject = [WBWebpageObject object];
        // 标记你分享媒体的标记
        WebpageObject.objectID = _WeiBo_ObjectID;
        // 分享标题
        WebpageObject.title = _WeiBo_Title;
        // 分享链接地址
        WebpageObject.webpageUrl = _WeiBo_Url;
        // 图片转化为二进制流
        NSData * Data = UIImageJPEGRepresentation(_WeiBo_ShareImage, 0.01);
        //所列图
        [WebpageObject setThumbnailData:Data];
        // 分享描述
        WebpageObject.description = _WeiBo_Describe;
        // 对象传递
        MessageObject.mediaObject = WebpageObject;
        // 返回，所需对象
        return MessageObject;

    }else if (ObjectType == ObjecImage){
        WBImageObject * ImageObject = [WBImageObject object];
        NSData * Data = UIImageJPEGRepresentation(_WeiBo_ShareImage, 0.01);
        ImageObject.imageData = Data;
        MessageObject.text = [NSString stringWithFormat:@"%@%@%@%@%@",_WeiBo_Title,_WeiBo_CHFD,_WeiBo_Describe,_WeiBo_CHFD,_WeiBo_Url];
        MessageObject.imageObject = ImageObject;
        // 返回，所需对象
        return MessageObject;
    }else{
        return nil;
    }
}

@end
