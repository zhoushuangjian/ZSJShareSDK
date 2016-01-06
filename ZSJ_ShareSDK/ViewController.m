//
//  ViewController.m
//  ZSJ_ShareSDK
//
//  Created by 周双建 on 16/1/3.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "ViewController.h"
#import "zsj.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
// 创建展示区
@property(nonatomic,strong) UITableView * Show_tableView;
// 获取数据源
@property(nonatomic,strong) NSMutableArray * SourcesArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNav];
    // 创建展示区
    [self makeTableView];
    // 加载数据
    [self loadData];
}
-(void)makeTableView{
    self.Show_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    _Show_tableView.delegate = self;
    _Show_tableView.dataSource = self;
    _Show_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_Show_tableView];
}
// 返回个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _SourcesArray.count;
}
// 每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 380;
}
// 配置文件
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * ID_Str = [NSString stringWithFormat:@"CELL%ld",indexPath.row];
    UITableViewCell * Cell = [tableView dequeueReusableCellWithIdentifier:ID_Str];
    if (!Cell) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID_Str];
        // 美女图
        UIImageView * Image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 200)];
        Image.tag = 100;
        [Cell addSubview:Image];
        // 匿名
        UILabel * NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(Image.frame)+5, 200, 30)];
        NameLabel.tag = 200;
        [Cell addSubview:NameLabel];
        
        //描述
        UILabel * MiaoshuLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(NameLabel.frame)-5, self.view.frame.size.width-20, 60)];
        MiaoshuLabel.tag = 300;
        MiaoshuLabel.font = [UIFont systemFontOfSize:15];
        MiaoshuLabel.numberOfLines = 2;
        MiaoshuLabel.textColor = [UIColor lightGrayColor];
        [Cell addSubview:MiaoshuLabel];
        
        
        // 分割边线

        UIImageView * LineImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(MiaoshuLabel.frame), self.view.frame.size.width, 20)];
        LineImageV.tag = 400;
        [Cell addSubview:LineImageV];
        
        // 图像
        
        NSArray * ImageArray = @[[UIImage imageNamed:@"ic_qq"],[UIImage imageNamed:@"ic_qq_zone"],[UIImage imageNamed:@"ic_pay"],[UIImage imageNamed:@"ic_friend"],[UIImage imageNamed:@"ic_sina"]];
        for (int i =0 ;i< ImageArray.count;i++){
            UIButton * Button = [UIButton buttonWithType:UIButtonTypeCustom];
            Button.frame = CGRectMake(((self.view.frame.size.width-200)/6+40)*i+(self.view.frame.size.width-200)/6, 10+CGRectGetMaxY(LineImageV.frame), 40, 40);
            [Button setImage:ImageArray[i] forState:UIControlStateNormal];
            [Button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            Button.titleLabel.text = [NSString stringWithFormat:@"%ld*%d",indexPath.row,i];
            [Cell addSubview:Button];
        }
        
        UIView * ViewCe = [[UIView alloc]initWithFrame:CGRectMake(0, 376, self.view.frame.size.width, 3)];
        ViewCe.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [Cell addSubview:ViewCe];
    }
    UIImageView * Cell_ImageV = (UIImageView*)[Cell viewWithTag:100];
    Cell_ImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_SourcesArray[indexPath.row][@"image"]]];
    
    //name
    UILabel * Cell_nameLabel = (UILabel*)[Cell viewWithTag:200];
    Cell_nameLabel.text = _SourcesArray[indexPath.row][@"title"];
    
    //maisohu
    UILabel * Cell_MiaoshuLabel = (UILabel*)[Cell viewWithTag:300];
    Cell_MiaoshuLabel.text = [NSString stringWithFormat:@"      %@",_SourcesArray[indexPath.row][@"miaoshu"]];

    //分割线
    NSArray * ImageArray = @[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"4.png"]];
    UIImageView * Cell_animanImageV = (UIImageView*)[Cell viewWithTag:400];
    Cell_animanImageV.animationImages = ImageArray;
    Cell_animanImageV.animationDuration = 0.8;
    Cell_animanImageV.animationRepeatCount = -1;
    [Cell_animanImageV startAnimating];
    
    return Cell;
}

-(void)BtnClick:(UIButton*)Btn{
    NSString * Str_intager = Btn.titleLabel.text;
    NSArray * Str_Array = [Str_intager componentsSeparatedByString:@"*"];
    NSInteger  Index = [[Str_Array firstObject] integerValue];
    NSInteger  Tag = [[Str_Array lastObject] integerValue];
    switch (Tag) {
        case 0:{
            // QQ
            [self QQ_Send:Index QQ_Type:QQ];
        }
            break;
        case 1:{
            //QZ
            [self QQ_Send:Index QQ_Type:QZone];
        }
            break;
        case 2:{
            //WX
            [self WeiXin_Send:Index QQ_Type:WXSceneSession];
        }
            break;
        case 3:{
            //WF
            [self WeiXin_Send:Index QQ_Type:WXSceneTimeline];
        }
            break;
        case 4:{
            //WB
            [self WeiBo_Send:Index QQ_Type:ObjecImage];
        }
            break;
            
        default:
            break;
    }
    
}
// 发起qq 分享
-(void)QQ_Send:(NSInteger)Index QQ_Type:(QQ_ShareType)Type{
    ZSJ_QQ_Share * Share = [ZSJ_QQ_Share ZSJShareSdk:QQ_APPID];
    if ([Share ZSJExamine]) {
        // 分享的标题
        Share.QQ_Title = _SourcesArray[Index][@"title"];
        // 描述
        Share.QQ_Describe = _SourcesArray[Index][@"miaoshu"];
        // 分享网址
        Share.QQ_Url = _SourcesArray[Index][@"url"];
        // 分享的图片
        Share.QQ_ShareImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_SourcesArray[Index][@"image"]]];
        //初始化
        [Share ZSJSendApiNewsObject:Type];
    }else{
        NSLog(@"你没有安装QQ");
    }

}
// 微信 分享
-(void)WeiXin_Send:(NSInteger)Index QQ_Type:(enum WXScene)Type{
    ZSJ_WeiXin_Share * Share = [ZSJ_WeiXin_Share ZSJShareSdk:WeiXin_APPID];
    if ([Share ZSJExamine]) {
        // 分享的标题
        Share.WeiXin_Title = _SourcesArray[Index][@"title"];
        // 描述
        Share.WeiXin_Describe = _SourcesArray[Index][@"miaoshu"];
        // 分享网址
        Share.WeiXin_Url = _SourcesArray[Index][@"url"];
        // 分享的图片
        Share.WeiXin_ShareImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_SourcesArray[Index][@"image"]]];
        //初始化
        [Share ZSJSendWebpageObject:Type];
    }else{
        NSLog(@"你没有安装QQ");
    }

}
// 微博分享
-(void)WeiBo_Send:(NSInteger)Index QQ_Type:(ObjectType)Type{
    ZSJ_WeiBo_Share * Share = [ZSJ_WeiBo_Share ZSJShareSdk:WeiBo_APPID];
    if ([Share ZSJExamine]) {
        //回调网址
        Share.WeiBo_RedirectURI = WeiBo_RedirectURI_STR;
        // 分享的标题
        Share.WeiBo_Title = _SourcesArray[Index][@"title"];
        // 描述
        Share.WeiBo_Describe = _SourcesArray[Index][@"miaoshu"];
        // 分享网址
        Share.WeiBo_Url = _SourcesArray[Index][@"url"];
        // 分享的图片
        Share.WeiBo_ShareImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_SourcesArray[Index][@"image"]]];
        //拼接串
        Share.WeiBo_CHFD = @"&";
        // 媒体标记
        Share.WeiBo_ObjectID = @"ZSJ";
        //初始化
        [Share ZSJSendObject:Type];
    }else{
        NSLog(@"你没有安装QQ");
    }

}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
-(void)tencentDidLogin{
    NSLog(@"登陆了");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 创建导航
-(void)makeNav{
    UIView * NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    NavView.backgroundColor = [UIColor whiteColor];
    UILabel * Label = [[UILabel alloc]initWithFrame:CGRectMake(NavView.frame.size.width/2-100, 20, 200, 44)];
    Label.text = @"成功QQ吧提供---分享";
    Label.textAlignment = NSTextAlignmentCenter;
    [NavView addSubview:Label];
    
    UIView * Line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    Line.backgroundColor = [UIColor lightGrayColor];
    [NavView addSubview:Line];
    [self.view addSubview:NavView];

}
// 消去头部
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
// 去尾
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)loadData{
    NSString * Path_Str = [[NSBundle mainBundle] pathForResource:@"DataPlist" ofType:@"plist"];
    // 数据源初始化
    _SourcesArray = [NSMutableArray arrayWithCapacity:0];
    // 获取数据
    _SourcesArray = [NSMutableArray arrayWithContentsOfFile:Path_Str];
    // 查看
    NSLog(@"获取结果：%@",_SourcesArray);
}
@end
