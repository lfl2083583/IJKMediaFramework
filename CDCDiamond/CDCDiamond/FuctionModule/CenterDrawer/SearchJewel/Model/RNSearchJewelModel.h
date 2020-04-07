//
//  RNSearchJewelModel.h
//  RapNet
//
//  Created by jt on 2019/11/3.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNSearchJewelModel : NSObject
//形状
@property (nonatomic, strong) NSString *shape;
//尺寸最小值
@property (nonatomic,   copy) NSString *size;
//尺寸最大值
@property (nonatomic,   copy) NSString *maxsize;
//颜色
@property (nonatomic, copy) NSString *color;
//净度
@property (nonatomic, copy) NSString *clarity;
//切口
@property (nonatomic, strong) NSString *cut;
//抛光
@property (nonatomic, strong) NSString *polished;
//对称性
@property (nonatomic, strong) NSString *symmetrical;
//地址选择类型
@property (nonatomic,   copy) NSString *loctiontype;
//国家
@property (nonatomic, strong) NSString *loction;
//省
@property (nonatomic, strong) NSString *drpState;
//城市
@property (nonatomic, strong) NSString *city;
//鉴定所
@property (nonatomic, strong) NSString *jiandingsuo;
//价格最小值
@property (nonatomic,   copy) NSString *pricemin;
//价格最大值
@property (nonatomic,   copy) NSString *pricemax;
//价格类型1，2,3）
@property (nonatomic,   copy) NSString *pricetype;
//荧光强度
@property (nonatomic, strong) NSString *fluorescent;
//萤光颜色
@property (nonatomic, strong) NSString *fluorescentcorol;
//是否高级会员
@property (nonatomic,   copy) NSString *ishighmember;
//是否彩钻（0：普通颜色，1：彩钻）
@property (nonatomic,   assign) BOOL iscz;
//彩钻颜色
@property (nonatomic, strong) NSString *fancyccolorimenstfy;
//彩钻光彩
@property (nonatomic, strong) NSString *fancyccolorovertone;
//彩钻强度
@property (nonatomic, strong) NSString *fancyccolor1;
//可售状态
@property (nonatomic,   assign) BOOL isavalible;
//是否匹配对
@property (nonatomic,   copy) NSString *isppd;
//证书编号
@property (nonatomic,   copy) NSString *reportId;


//账号（卖方）
@property (nonatomic,   copy) NSString *usercomid;
//库存号
@property (nonatomic,   copy) NSString *gupcode;
//台面百分比
@property (nonatomic,   copy) NSString *bottom;
//台面百分比最大
@property (nonatomic,   copy) NSString *bottommax;
//深度
@property (nonatomic,   copy) NSString *depth;
//深度最大
@property (nonatomic,   copy) NSString *depthmax;
//腰围
@property (nonatomic,   copy) NSString *waisttj;
//腰围最大
@property (nonatomic,   copy) NSString *waisttjmax;
//长
@property (nonatomic,   copy) NSString *chang;
//长最大
@property (nonatomic,   copy) NSString *changmax;
//宽
@property (nonatomic,   copy) NSString *kuan;
//宽
@property (nonatomic,   copy) NSString *kuanmax;
//宽
@property (nonatomic,   copy) NSString *gao;
//高最大
@property (nonatomic,   copy) NSString *gaomax;

//比率
@property (nonatomic,   copy) NSString *radio;

//比率最大
@property (nonatomic,   copy) NSString *radiomax;
//冠高
@property (nonatomic,   copy) NSString *guangao;
//冠高最大
@property (nonatomic,   copy) NSString *guangaomax;
//冠角
@property (nonatomic,   copy) NSString *guanjiao;
//冠角最大值
@property (nonatomic,   copy) NSString *guanjiaomax;

//低深
@property (nonatomic,   copy) NSString *tingsheng;
//低深最大值
@property (nonatomic,   copy) NSString *tingshengmax;
//底角
@property (nonatomic,   copy) NSString *tingjiao;
//底角最大值
@property (nonatomic,   copy) NSString *tingjiaomax;

//中心夹杂物最小
@property (nonatomic,   copy) NSString *centerinclusion;

//黑色夹杂物
@property (nonatomic,   copy) NSString *blackinclusions;
//外在夹杂物
@property (nonatomic,   copy) NSString *openinclusions;
//白色夹杂物
@property (nonatomic,   copy) NSString *whiteinclusions;
//仅限已处理
@property (nonatomic,   copy) NSString *jxhandle;

//包括已处理
@property (nonatomic,   copy) NSString *bkhandle;
//证书（true,false）
@property (nonatomic,   copy) NSString *reportfile;


//图片（true,false）
@property (nonatomic,   copy) NSString *imgfile;


//视频（true,false）
@property (nonatomic,   copy) NSString *videofile;


//钻石编号
@property (nonatomic,   copy) NSString *diaNO;


//排除阴影
@property (nonatomic,   copy) NSString *shadecos;



//中心夹杂物最大值
@property (nonatomic,   copy) NSString *centerinclusionmax;


//中心夹杂物最大值
@property (nonatomic,   copy) NSString *eyeclean;

- (NSMutableDictionary *)getParameters;


@end

NS_ASSUME_NONNULL_END
/**
//高级搜索  servlet/AppSearch?method=hignSearch
shape
true array
形状
size
true string
尺寸最小值
maxsize
true string
尺寸最大值
color
true array
颜色
clarity
true array
净度
cut
true array
切口
polished
true array
抛光
symmetrical
true array
对称性
loctiontype
true string
地址选择类型
loction
true array
国家
drpState
true array
省
city
true array
城市
jiandingsuo
true array
鉴定所
pricemin
true string
价格最小值
pricemax
true string
价格最大值
pricetype
true string
价格类型（1，2,3）
fluorescent
true array
荧光强度
fluorescentcorol
true array
萤光颜色
ishighmember
true string
是否高级会员
iscz
true string
是否彩钻（0：普通颜色，1：彩钻）
fancyccolorimenstfy
true array
彩钻颜色
fancyccolorovertone
true array
彩钻光彩
fancyccolor1
true array
彩钻强度
isavalible
true string
可售状态
isppd
true string
是否匹配对
reportId
true string
证书编号
usercomid
true string
账号（卖方）
gupcode
true string
库存号
bottom
true string
台面百分比
bottommax
true string
台面百分比最大
depth
true string
深度
depthmax
true string
深度最大
waisttj
true string
腰围
waisttjmax
true string
腰围最大
chang
true string
长
changmax
true string
长最大
kuan
true string
宽
kuanmax
true string
宽最大
gao
true string
高
gaomax
true string
高最大
radio
true string
比率
radiomax
true string
比率最大
guangao
true string
冠高
guangaomax
true string
冠高最大
guanjiao
true string
冠角
guanjiaomax
true string
冠角最大值
tingsheng
true string
低深
tingshengmax
true string
低深最大值
tingjiao
true string
底角
tingjiaomax
true string
底角最大值
centerinclusion
true string
中心夹杂物最小
blackinclusions
true string
黑色夹杂物
openinclusions
true string
外在夹杂物
whiteinclusions
true string
白色夹杂物
jxhandle
true string
仅限已处理
bkhandle
true string
包括已处理
reportfile
true string
证书（true,false）
imgfile
true string
图片（true,false）
videofile
true string
视频（true,false）
diaNO
true string
钻石编号
shadecos
true string
排除阴影
currentPage
true string
当前页（默认从1开始，每次下拉加一）
centerinclusionmax
true string
中心夹杂物最大值
eyeclean
true string
肉眼干净







// 详情
kuanmax
 true string
宽最大值
ishighmember
 true string
是否高级会员
usercomid
 true string
rapid(用户登录账号)
centerinclusion
 true string
中心夹杂物
isppd
 true string
是否匹配对
guangao
 true string
冠高
videofile
 true string
视频文件
gupcode
 true string
库存号
changmax
 true string
长最大值
fancyccolorovertone
 true string
颜色强度
fluorescent
 true string
荧光强度
radio
 true string
比率
diaNO
 true string
钻石编号
iscz
 true string
是否彩钻
tingjiao
 true string
底部角度
reportfile
 true string
是否有证书文件
price
 true string
价格
symmetrical
 true string
对称性
gaomax
 true string
高最大值
pricemax
 true string
价格最大值
fancyccolorimenstfy
 true string
彩钻颜色
shape
 true string
形状
tingjiaomax
 true string
底部角度最大值
kuan
 true string
宽
bottom
 true string
台面百分比
tingsheng
 true string
底部深度
guangaomax
 true string
冠高最大值
radiomax
 true string
比率最大值
bottommax
 true string
台面百分比最大值
size
 true string
尺寸（重量）
jiandingsuo
 true string
鉴定所
whiteinclusions
 true string
白色夹杂物
maxsize
 true string
重量最大值（重量）
depthmax
 true string
深度最大值
bkhandle
 true string
包括已处理
cut
 true string
切工
fancyccolor1
 true string
颜色光彩
color
 true string
白色钻石颜色
guanjiaomax
 true string
冠角最大值
waisttjmax
 true string
腰围最大值
polished
 true string
抛光
guanjiao
 true string
冠高
gao
 true string
高
pricetype
 true string
价格类型
jxhandle
 true string
仅限处理
shadecos
 true string
色彩（排除阴影）
openinclusions
 true string
外在夹杂物
loction
 true string
地区
loctiontype
 true string
地区类型
tingshengmax
 true string
底部深度最大值
reportId
 true string
证书编号
isavalible
 true string
可售状态
depth
 true string
深度
clarity
 true string
净度
chang
 true string
长
imgfile
 true string
图片文件
blackinclusions
 true string
黑色夹杂物
fluorescentcorol
 true string
荧光颜色
waisttj
 true string
腰围
*/
