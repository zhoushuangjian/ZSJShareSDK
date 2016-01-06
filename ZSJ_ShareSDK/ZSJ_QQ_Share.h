//
//  ZSJ_QQ_Share.h
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/5.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum QQ_ShareType{
    QQ = 0,
    QZone,
    QQGroup,
}QQ_ShareType;
@interface ZSJ_QQ_Share : NSObject
//创建一个单利
+(ZSJ_QQ_Share*)ZSJShareSdk:(NSString*)QQ_AppId;
// 检测您的QQ是否安装（SSO ）
-(BOOL)ZSJExamine;
// 分享的网址
@property(nonatomic,strong) NSString * QQ_Url;
// 分享的标题
@property(nonatomic,strong) NSString * QQ_Title;
// 分享描述
@property(nonatomic,strong) NSString * QQ_Describe;
/*注意： QQ_ShareImage and  QQ_ShareImageUrl 只能一个 */
// 分享图片 < 32K
@property(nonatomic,strong) UIImage * QQ_ShareImage;
// 分享图片 < 32K
@property(nonatomic,strong) NSString * QQ_ShareImageUrl;
//初始化发送结构体((新闻媒体型)包含 ：标题、图片、描述)
-(void)ZSJSendApiNewsObject:(QQ_ShareType)Type;
//初始化发送结构体(包含（视频型） ：标题、图片、描述)
-(void)ZSJSendApiVideoObject:(QQ_ShareType)Type;
//初始化发送结构体(包含（音频型） ：标题、图片、描述)
-(void)ZSJSendApiAudioObject:(QQ_ShareType)Type;
@end
