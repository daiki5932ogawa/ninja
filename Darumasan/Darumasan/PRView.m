//
//  PRView.m
//  Darumasan
//
//  Created by 小川大暉 on 2015/01/10.
//  Copyright (c) 2015年 DaikiOgawa. All rights reserved.
//

#import "PRView.h"

UIView *prView2_1;

@implementation PRView



@synthesize adg2 = adg2_;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //画面取得
        UIScreen *sc = [UIScreen mainScreen];
        
        //ステータスバー込みのサイズ
        CGRect rect = sc.bounds;
        NSLog(@"%.1f, %.1f", rect.size.width, rect.size.height);
        
        
        UIImage *mainV = [UIImage imageNamed:@"main1"];
        UIImageView *mainV_v = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,rect.size.width,rect.size.height)];
        [mainV_v setImage:mainV];
        [self addSubview:mainV_v];
        
        UIView *prView2_2= [[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        prView2_2.backgroundColor = [UIColor blackColor];
        prView2_2.alpha = 0.7;
        
        prView2_1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        
        NSDictionary *adgparam2 = @{
                                    @"locationid" : @"xxxx", //管理画面から払い出された広告枠ID
                                    @"adtype" : @(kADG_AdType_Rect), //管理画面にて入力した枠サイズ(kADG_AdType_Sp：320x50, kADG_AdType_Large:320x100, kADG_AdType_Rect:300x250, kADG_AdType_Tablet:728x90, kADG_AdType_Free
                                    @"originx" : @(10), //広告枠設置起点のx座標 ※下記参照
                                    @"originy" : @(140), //広告枠設置起点のy座標 ※下記参照
                                    @"w" : @(300), //広告枠横幅 ※下記参照
                                    @"h" : @(250)  //広告枠高さ ※下記参照
                                    };
        ADGManagerViewController *adgvc2 = [[ADGManagerViewController alloc]initWithAdParams :adgparam2 :prView2_1];
        self.adg2 = adgvc2;
        adg2_.delegate = self;
        [adg2_ loadRequest];
        
        NSTimer *close_timer =
        [NSTimer
         scheduledTimerWithTimeInterval:2.0f
         target:self
         selector:@selector(close_hyoji:)
         userInfo:nil
         repeats:NO
         ];
        

        
        [self addSubview:prView2_2];
        [self addSubview:prView2_1];
        
    }
    
    return self;
}

-(void)close_hyoji:(NSTimer*)close_timer{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(125, 450, 70, 40)];
    [btn setTitle:@"とじる" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 0;
    [prView2_1 addSubview:btn];
    
}


@end
