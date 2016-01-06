//
//  ZSJ_WeiBo_Share.h
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/5.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum ObjectType {
    Objec = 0,
    ObjecImage,
}ObjectType;
@interface ZSJ_WeiBo_Share : NSObject
// 微博授权回调网址
@property(nonatomic,strong) NSString * WeiBo_RedirectURI;
// 微博开放平台第三方应用scope，多个scrope用逗号分隔
@property(nonatomic,strong) NSString * WeiBo_Scope;
// 分享网址
@property(nonatomic,strong) NSString * WeiBo_Url;
// 分享描述
@property(nonatomic,strong) NSString * WeiBo_Describe;
// 分享标题
@property(nonatomic,strong) NSString * WeiBo_Title;
// 分享媒体的标记
@property(nonatomic,strong) NSString * WeiBo_ObjectID;
// 分享图片
@property(nonatomic,strong) UIImage * WeiBo_ShareImage;
// 分享媒体的标记
@property(nonatomic,strong) NSString * WeiBo_CHFD;

// 初始化对象
+(ZSJ_WeiBo_Share*)ZSJShareSdk:(NSString*)Weibo_AppId;
// 检测您的QQ是否安装（SSO ）
-(BOOL)ZSJExamine;
// 创建发送体
-(void)ZSJSendObject:(ObjectType)ObjectType;
@end
