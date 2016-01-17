//
//  MainView.m
//  Sample
//
//  Created by MACM001 on 2014/08/05.
//  Copyright (c) 2014年 MACM001. All rights reserved.
//

#import "MainView.h"
#import <UIKit/UIKit.h>
#import "UIImage+GIF.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DataControl.h"

//ゲージ管理
UIImageView *mater_value_s;
float iraira_value;

//体力
int tairyoku;
UIImageView *tairyoku1;
UIImageView *tairyoku2;
UIImageView *tairyoku3;
UIImageView *tairyoku4;
UIImageView *tairyoku5;

BOOL flag_wating;

//アイテム
int item_num;

//人
UIImageView *shacho1;
UIImageView *shacho2;
UIImageView *shacho3;
UIImageView *watashi1;
UIImageView *watashi2;
UIImageView *zzz1;

//煙
UIImageView *watashi3;

//夢
UIImageView *moku1;
UIImageView *moku2;

UIImageView *yume_naiyou;

//私目
UIImageView *watashi_me1;

//私化けてる絵
int watashi_bake_num;

//忍者化けてる絵座標
int z_x;
int z_y;
int s_x;
int s_y;

//盗めボタン
UIButton *nusume_btn;

UIButton *seika_btn;

UIButton *settei_btn;

//コラ表示View
UIImageView *kora_s;
UIImageView *kora1_s;

//成功時文字表示
UIImageView *seiko_moji;

//開始時表示文字
UIImageView *ninmukaishi;

//社長振り向いているかどうか
BOOL shacho_miteru;

//社長タイマーと、起動しているか
NSTimer *shacho_timer0;
NSTimer *shacho_timer1;
NSTimer *shacho_timer2;
BOOL shacho_timer_b;
BOOL shacho_timer_b1;
BOOL shacho_timer_b2;

//夢内容
int yume_num;

UILabel *yume_moji1;
UILabel *yume_moji2;
UILabel *yume_moji3;

//ゲージ貯めるタイマー
NSTimer *gage_timer1;

NSTimer *fuwafuwa_timer;

//ゲージ溜まる量増えてく
float gage_fuel;

NSUserDefaults *ud;

UIScreen *sc;
CGRect rect;

//タッチを無効化　フラグ
BOOL flag_touch_kinshi;

//ゲームやってる途中 フラグ
BOOL flag_playing;

//バレた時 ブール
BOOL flag_bareta;

//サウンドループ
BOOL sound_roop1;
NSTimer *tm_r1;

//サウンドURL
NSURL *url0;



//画面サイズ
int chosei_w;
int chosei_h;
float chosei_size;

//効果音
SystemSoundID sound_click1;
SystemSoundID sound_get1;
SystemSoundID sound_noise1;
SystemSoundID sound_coin;

//UIView
UIView * shokai_b;
UIView * shokai;

@implementation MainView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //self.backgroundColor = [UIColor blackColor];
        
        
        //効果音
        //効果音ファイル読み込み
        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"mekuru" ofType:@"mp3"];
        NSURL *url1 = [NSURL fileURLWithPath:path1];
        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url1), &sound_click1);
        
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"get1" ofType:@"mp3"];
        NSURL *url2 = [NSURL fileURLWithPath:path2];
        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url2), &sound_get1);
        
        NSString *path3 = [[NSBundle mainBundle] pathForResource:@"noise1" ofType:@"mp3"];
        NSURL *url3 = [NSURL fileURLWithPath:path3];
        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url3), &sound_noise1);
        
        NSString *path4 = [[NSBundle mainBundle] pathForResource:@"coin" ofType:@"mp3"];
        NSURL *url4 = [NSURL fileURLWithPath:path4];
        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url4), &sound_coin);
        
        
        
        //画面サイズ
        sc = [UIScreen mainScreen];
        rect = sc.bounds;
        //NSLog(@"%.1f, %.1f", rect.size.width, rect.size.height);
        chosei_w = (rect.size.width - 320)/2;
        chosei_h = (rect.size.height - 480)/2;
        chosei_size = (rect.size.width+320)/640;
        
        //NSLog(@"chosei_s = %f",chosei_size);
        
        ud = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
        [defaults setObject:@"NO" forKey:@"KEY_Timer1_B"];
        [defaults setObject:@"0" forKey:@"KEY_iraira_I"];
        [defaults setObject:@"0" forKey:@"KEY_omosa_goukei"];
        [defaults setObject:@"NO" forKey:@"KEY_flag_playing"];
        [defaults setObject:@"5" forKey:@"KEY_tairyoku"];
        [defaults setObject:@"NO" forKey:@"flag_shuryo"];
        [defaults setObject:@"YES" forKey:@"KEY_oto"];
        [defaults setObject:@"YES" forKey:@"KEY_Tsuchi"];
        [ud registerDefaults:defaults];
        
        /*
            //BGM
            NSString *path0 = [[NSBundle mainBundle] pathForResource:@"bgm2" ofType:@"mp3"];
            url0 = [NSURL fileURLWithPath:path0];
            self.sound_bgm1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url0 error:NULL];
            // 音量設定
            self.sound_bgm1.volume = 0.2f;
            self.sound_bgm1.numberOfLoops = -1;
        
        BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
        
        if (oto_onoff == YES) {
            
            [self.sound_bgm1 play];
            
        }
        */
         
        //初期値
        shacho_miteru = NO;
        
        //アイテムレベル
        int item_level;
        [defaults setObject:@"10" forKey:@"KEY_item_level"];
        [ud registerDefaults:defaults];
        
        
        //アイテムレベル条件分岐
        int omosa_gokei = (int)[ud integerForKey:@"KEY_omosa_goukei"];
        
        if (omosa_gokei > 100000 && omosa_gokei < 300000) {
            [ud setInteger:20 forKey:@"KEY_item_level"];
            [ud synchronize];
        }
        
        
        else if (omosa_gokei > 300000){
            [ud setInteger:30 forKey:@"KEY_item_level"];
            [ud synchronize];
        }
        
    
        
        item_level = (int)[ud integerForKey:@"KEY_item_level"];
        
        //アイテムナンバーをランダムで決定
        item_num = arc4random() % item_level;
        NSLog(@"アイテムナンバー%d",item_num);
        
        while (item_num == 10 || item_num == 20) {
            
        item_num = arc4random() % item_level;
            
        }
        
        
        if (item_num > 21) {
            item_num = 0;
        }
        
        //テスト
        //item_num = 21;
        
        gage_fuel = 0;
        
        [ud setInteger:item_num forKey:@"KEY_Item_num"];
        [ud synchronize];
        
        //背景
        UIImage *hannari_i = [UIImage imageNamed:@"main_bk1"];
        UIImageView *hannari1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [hannari1 setImage:hannari_i];
        [self addSubview:hannari1];
        
        //体力
        UIImage *tairyoku_i = [UIImage imageNamed:@"tairyoku"];
        
        tairyoku1 = [[UIImageView alloc]initWithFrame:CGRectMake(0+chosei_w, 20+chosei_h/4, 30*chosei_size, 40*chosei_size)];
        [tairyoku1 setImage:tairyoku_i];
        [self addSubview:tairyoku1];
        tairyoku1.hidden = YES;
        
        tairyoku2 = [[UIImageView alloc]initWithFrame:CGRectMake(30+chosei_w, 20+chosei_h/4, 30*chosei_size, 40*chosei_size)];
        [tairyoku2 setImage:tairyoku_i];
        [self addSubview:tairyoku2];
        tairyoku2.hidden = YES;
        
        tairyoku3 = [[UIImageView alloc]initWithFrame:CGRectMake(60+chosei_w, 20+chosei_h/4, 30*chosei_size, 40*chosei_size)];
        [tairyoku3 setImage:tairyoku_i];
        [self addSubview:tairyoku3];
        tairyoku3.hidden = YES;
        
        tairyoku4 = [[UIImageView alloc]initWithFrame:CGRectMake(90+chosei_w, 20+chosei_h/4, 30*chosei_size, 40*chosei_size)];
        [tairyoku4 setImage:tairyoku_i];
        [self addSubview:tairyoku4];
        tairyoku4.hidden = YES;
        
        tairyoku5 = [[UIImageView alloc]initWithFrame:CGRectMake(120+chosei_w, 20+chosei_h/4, 30*chosei_size, 40*chosei_size)];
        [tairyoku5 setImage:tairyoku_i];
        [self addSubview:tairyoku5];
        tairyoku5.hidden = YES;
        

    //↓↓殿↓↓
        UIImage *tono1_i = [UIImage imageNamed:@"otono10"];
        UIImageView *tono1 = [[UIImageView alloc]initWithFrame:CGRectMake(-10+chosei_w, 155+chosei_h, 150*chosei_size, 200*chosei_size)];
        [tono1 setImage:tono1_i];
        [self addSubview:tono1];
        
        //zzz
        UIImage* image2 = [UIImage animatedGIFNamed:@"zzz2"];
        zzz1 = [[UIImageView alloc]initWithFrame:CGRectMake(100+chosei_w*5/4, 150+chosei_h, 80*chosei_size, 80*chosei_size)];
        [zzz1 setImage:image2];
        [self addSubview:zzz1];
        
        
        //顔
        //殿こっち向いてない
        UIImage *shacho1_i = [UIImage imageNamed:@"otono_kao10"];
        shacho1 = [[UIImageView alloc]initWithFrame:CGRectMake(-10+chosei_w, 155+chosei_h, 150*chosei_size, 200*chosei_size)];
        [shacho1 setImage:shacho1_i];
        [self addSubview:shacho1];
        shacho1.hidden = NO;
        
        //殿こっち向いてる
        UIImage *shacho2_i = [UIImage imageNamed:@"otono_kao11"];
        shacho2 = [[UIImageView alloc]initWithFrame:CGRectMake(-10+chosei_w, 155+chosei_h, 150*chosei_size, 200*chosei_size)];
        [shacho2 setImage:shacho2_i];
        [self addSubview:shacho2];
        shacho2.hidden = YES;
        
        //殿起こってる
        UIImage *shacho3_i = [UIImage imageNamed:@"otono_kao12"];
        shacho3 = [[UIImageView alloc]initWithFrame:CGRectMake(-10+chosei_w, 155+chosei_h, 150*chosei_size, 200*chosei_size)];
        [shacho3 setImage:shacho3_i];
        [self addSubview:shacho3];
        shacho3.hidden = YES;
        
        
    //↓↓忍者↓↓
        
        //忍者立ってる
        //忍者化けてる絵ランダム表示
        NSString *watashi_bake_gazo;
        watashi_bake_num = arc4random()%3;
        if (watashi_bake_num == 0) {
            watashi_bake_gazo = @"tanuki";
            z_x = 170;
            z_y = 170;
            s_x = 120;
            s_y = 160;
        }
        else if (watashi_bake_num == 1){
            watashi_bake_gazo = @"nyam2";
            z_x = 180;
            z_y = 190;
            s_x = 100;
            s_y = 130;
        }
        else if (watashi_bake_num == 2){
            watashi_bake_gazo = @"kokeshi";
            z_x = 176;
            z_y = 170;
            s_x = 120;
            s_y = 160;
        }
        
        UIImage *watashi1_i = [UIImage imageNamed:watashi_bake_gazo];
        watashi1 = [[UIImageView alloc]initWithFrame:CGRectMake(z_x+chosei_w, z_y+chosei_h, s_x*chosei_size, s_y*chosei_size)];
        [watashi1 setImage:watashi1_i];
        [self addSubview:watashi1];
        watashi1.hidden = NO;
        
        //忍者盗んでる
        //UIImage *watashi2_i = [UIImage imageNamed:@"ninja1"];
        UIImage* image = [UIImage animatedGIFNamed:@"ninja_g2"];
        watashi2 = [[UIImageView alloc]initWithFrame:CGRectMake(190+chosei_w, 180+chosei_h, 90*chosei_size, 140*chosei_size)];
        [watashi2 setImage:image];
        [self addSubview:watashi2];
        watashi2.hidden = YES;
        

        
        //忍者盗んでる時目
        UIImage *watashi_me1_i = [UIImage imageNamed:@"ninja_kao"];
        watashi_me1 = [[UIImageView alloc]initWithFrame:CGRectMake(190+chosei_w, 180+chosei_h, 90*chosei_size, 140*chosei_size)];
        [watashi_me1 setImage:watashi_me1_i];
        [self addSubview:watashi_me1];
        watashi_me1.hidden = YES;
    
        
    //↓↓その他↓↓
        
        //金庫
        UIImage *kinko1_i = [UIImage imageNamed:@"otakara1"];
        UIImageView *kinko1 = [[UIImageView alloc]initWithFrame:CGRectMake(150+chosei_w, 250+chosei_h, 90*chosei_size, 100*chosei_size)];
        [kinko1 setImage:kinko1_i];
        [self addSubview:kinko1];
        
        //夢
        UIImage *moku1_i = [UIImage imageNamed:@"fuwa1"];
        moku1 = [[UIImageView alloc]initWithFrame:CGRectMake(10+chosei_w, 50+chosei_h, 140*chosei_size, 120*chosei_size)];
        [moku1 setImage:moku1_i];
        [self addSubview:moku1];
        moku1.hidden = NO;
        
        UIImage *moku2_i = [UIImage imageNamed:@"fuwa2"];
        moku2 = [[UIImageView alloc]initWithFrame:CGRectMake(10+chosei_w, 50+chosei_h, 140*chosei_size, 120*chosei_size)];
        [moku2 setImage:moku2_i];
        [self addSubview:moku2];
        moku2.hidden = YES;
        
        //夢　文字
        yume_moji1 = [[UILabel alloc] initWithFrame:CGRectMake(30+chosei_w, 60+chosei_h, 140*chosei_size, 30*chosei_size)];
        //yume_moji1.backgroundColor = [UIColor blueColor];
        //[self addSubview:yume_moji1];
        
        yume_naiyou = [[UIImageView alloc]initWithFrame:CGRectMake(30+chosei_w, 80+chosei_h, 90*chosei_size, 40*chosei_size)];
        [self addSubview:yume_naiyou];
        
        
        //ボタン soundBtn_click
        UIImage *seika_btn_i = [UIImage imageNamed:@"seika1.png"];
        seika_btn = [[UIButton alloc] initWithFrame:CGRectMake(240+chosei_w, 360+chosei_h*1.5, 70*chosei_size, 70*chosei_size)];
        [seika_btn setBackgroundImage:seika_btn_i forState:UIControlStateNormal];
        [seika_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [seika_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
        
        seika_btn.tag = 2;
        [self addSubview:seika_btn];
        
        
        
        UIImage *settei_btn_i = [UIImage imageNamed:@"settei1.png"];
        settei_btn = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 370+chosei_h*1.5, 70*chosei_size, 50*chosei_size)];
        [settei_btn setBackgroundImage:settei_btn_i forState:UIControlStateNormal];
        [settei_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [settei_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
        settei_btn.tag = 3;
        [self addSubview:settei_btn];
        
        UIImage *nusume_btn_i = [UIImage imageNamed:@"nusume1.png"];
        nusume_btn = [[UIButton alloc] initWithFrame:CGRectMake(80+chosei_w, 320+chosei_h*1.5, 160*chosei_size, 110*chosei_size)];
        [nusume_btn setBackgroundImage:nusume_btn_i forState:UIControlStateNormal];
        [nusume_btn addTarget:self action:@selector(soundBtn_noise:) forControlEvents:UIControlEventTouchDown];
        [nusume_btn addTarget:self action:@selector(nusume_btn_down) forControlEvents:UIControlEventTouchDown];
        [nusume_btn addTarget:self action:@selector(soundBtn_noise:) forControlEvents:UIControlEventTouchUpInside];
        [nusume_btn addTarget:self action:@selector(soundBtn_noise:) forControlEvents:UIControlEventTouchUpOutside];
        [nusume_btn addTarget:self action:@selector(nusume_btn_up) forControlEvents:UIControlEventTouchUpInside];
        [nusume_btn addTarget:self action:@selector(nusume_btn_up) forControlEvents:UIControlEventTouchUpOutside];
        nusume_btn.exclusiveTouch=YES;
        [self addSubview:nusume_btn];
        
        //ゲージ
        iraira_value =  0;
        
        iraira_value = (int)[ud integerForKey:@"KEY_iraira_I"];
        
        UIImage *mater_bk = [UIImage imageNamed:@"white"];
        UIImageView *mater_bk_s = [[UIImageView alloc]initWithFrame:CGRectMake(44, 57+chosei_h/3, 230*chosei_size+(chosei_size-1)*50, 30*chosei_size)];
        [mater_bk_s setImage:mater_bk];
        [self addSubview:mater_bk_s];
        
        UIImage *mater_value = [UIImage imageNamed:@"value"];
        mater_value_s = [[UIImageView alloc]initWithFrame:CGRectMake(44, 57+chosei_h/3, iraira_value*chosei_size+(chosei_size-1)*50, 30*chosei_size)];
        [mater_value_s setImage:mater_value];
        [self addSubview:mater_value_s];
        
        UIImage *mater_waku = [UIImage imageNamed:@"waku10"];
        UIImageView *mater_waku_s = [[UIImageView alloc]initWithFrame:CGRectMake(35, 40+chosei_h/3, 250*chosei_size+(chosei_size-1)*50, 60*chosei_size)];
        [mater_waku_s setImage:mater_waku];
        [self addSubview:mater_waku_s];
        
        UIImage *kora_i = [UIImage imageNamed:@"kusemono1"];
        kora_s =[[UIImageView alloc]initWithFrame:CGRectMake(00, 60, 300, 130)];
        [kora_s setImage:kora_i];
        [self addSubview:kora_s];
        kora_s.hidden = YES;
        
        UIImage *kora1_i = [UIImage imageNamed:@"shippai_moji1"];
        kora1_s =[[UIImageView alloc]initWithFrame:CGRectMake(85, 200, 150, 150)];
        [kora1_s setImage:kora1_i];
        [self addSubview:kora1_s];
        kora1_s.hidden = YES;
        
        //成功時表示文字
        UIImage *seiko_moji_i = [UIImage imageNamed:@"tassei1"];
        seiko_moji = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80, 260, 250)];
        [seiko_moji setImage:seiko_moji_i];
        [self addSubview:seiko_moji];
        seiko_moji.hidden = YES;
        
        //開始時表示文字
        UIImage *ninmukaishi_i = [UIImage imageNamed:@"ninmukaishi1"];
        ninmukaishi = [[UIImageView alloc]initWithFrame:CGRectMake(20+chosei_w, 40+chosei_h*1.2, 280*chosei_size, 100*chosei_size)];
        [ninmukaishi setImage:ninmukaishi_i];
        [self addSubview:ninmukaishi];
        ninmukaishi.hidden = YES;
        
        BOOL shokai = [ud boolForKey:@"KEY_Shokai"];
        if (shokai == NO) {
            
        [self shokai_hyoji];
        
        }
    }
    return self;
}

//画面に戻ってきたとき
-(void)execMain{
    
    /*
    
    //アプリが終了されてたら計算
    BOOL flag_shuryo = [ud boolForKey:@"flag_shuryo"];
    if (flag_shuryo == YES) {
        
        NSLog(@"shuryo flag");
        
        //時間計算
        NSDate *now = [NSDate date];
        float tmp= [now timeIntervalSinceDate:[[NSUserDefaults standardUserDefaults] objectForKey:@"cdate"]]; //差分をfloatで取得
        int hh = (int)(tmp / 3600);
        int mm = (int)((tmp-hh) / 60);
        //float ss = tmp -(float)(hh*3600+mm*60);
        
        //体力に換算
        int tairyoku = (int)[ud integerForKey:@"KEY_tairyoku"];
        
        //+1する
        if(mm >= 5 && mm < 10){
            if (tairyoku != 5) {
                tairyoku = tairyoku + 1;
                NSLog(@"回復1(SHR)");
            }
        }
        //+2する
        else if (mm >= 10 && mm < 15) {
            NSLog(@"回復2(SHR)");
            if (tairyoku < 3) {
                tairyoku = tairyoku +2;
            }
            else if(tairyoku >= 3){
                tairyoku = 5;
            }
        }
        
        //+3する
        else if (mm >= 15 && mm < 20) {
            NSLog(@"回復3(SHR)");
            if (tairyoku < 2) {
                tairyoku = tairyoku +3;
            }
            else if(tairyoku >= 2){
                tairyoku = 5;
            }
        }
        
        //+4する
        else if (mm >= 20 && mm < 25) {
            NSLog(@"回復4(SHR)");
            if (tairyoku < 1) {
                tairyoku = tairyoku +4;
            }
            else if(tairyoku >= 1){
                tairyoku = 5;
            }
        }
        
        //+5する
        else if (mm >= 25 && mm < 30) {
            NSLog(@"回復5(SHR)");
            if (tairyoku < 1) {
                tairyoku = tairyoku +4;
            }
            else if(tairyoku >= 1){
                tairyoku = 5;
            }
        }
        
        [ud setInteger:tairyoku forKey:@"KEY_tairyoku"];
        [ud setBool:NO forKey:@"flag_shuryo"];
        [ud synchronize];
        
        NSLog(@"shuryoしてたら体力=%d",tairyoku);
        
        NSLog(@"%02d:%02d",hh,mm);
        
        
        
    }
     */
    
    flag_playing = [ud boolForKey:@"KEY_flag_playing"];
    
    [self tairyoku_hyoji];
    
    NSLog(@"execMain,flag_playing = %d",flag_playing);
    NSLog(@"execMain,touch=kinshi = %d",flag_touch_kinshi);
    
    //ゲームが開始されていないとき
    if (flag_playing == NO) {
        
            flag_touch_kinshi = YES;
            shacho2.hidden = YES;
            shacho1.hidden = NO;
            shacho3.hidden = YES;
            zzz1.hidden = NO;
        
        if (tairyoku == 0){
            
            flag_wating = YES;
            NSLog(@"体力が0,flag_waiting");
            
        }
        
        if (tairyoku > 0) {
            
            NSLog(@"体力>0");
        
            [shacho_timer0 invalidate];
            [shacho_timer1 invalidate];
            [shacho_timer2 invalidate];
            moku1.hidden = YES;
            moku2.hidden = YES;
            shacho2.hidden = YES;
            shacho1.hidden = NO;
            zzz1.hidden = NO;
            shacho3.hidden = YES;
            yume_naiyou.hidden = NO;
        
            flag_touch_kinshi = NO;
        
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
            NSTimer *ninmukaishi_timer1 =
            [NSTimer
             scheduledTimerWithTimeInterval:1.0f
             target:self
             selector:@selector(ninmu_kaishi:)
             userInfo:nil
             repeats:NO
             ];
        
            NSLog(@"任務開始");
        
            [ud setBool:YES forKey:@"KEY_flag_playing"];
            [ud synchronize];
        
        
        //タイマー起動しているか判断
            shacho_timer_b = [shacho_timer0 isValid];
            shacho_timer_b1 = [shacho_timer1 isValid];
            shacho_timer_b2 = [shacho_timer2 isValid];
        
                if (shacho_timer_b == NO && shacho_timer_b1 == NO && shacho_timer_b2 == NO ) {
            
                    NSLog(@"タイマー起動");
                    //殿振り向くタイマーを設定
                    NSTimer *shacho_timer_kidou_timer =
                    [NSTimer
                     scheduledTimerWithTimeInterval:4.0f
                     target:self
                     selector:@selector(shacho_timer_kidou:)
                     userInfo:nil
                     repeats:NO
                     ];
                }
        
            
                else{
                    NSLog(@"もう起動してる");
                }
            
            }
        

        
    }
    
    seiko_moji.hidden = YES;
    
    if (flag_playing == YES) {
    
    //タイマー起動しているか判断
    shacho_timer_b = [shacho_timer0 isValid];
    shacho_timer_b1 = [shacho_timer1 isValid];
    shacho_timer_b2 = [shacho_timer2 isValid];

    if (shacho_timer_b == NO && shacho_timer_b1 == NO && shacho_timer_b2 == NO ) {
        
        NSLog(@"タイマー起動");
        //殿振り向くタイマーを設定
        NSTimer *shacho_timer_kidou_timer =
        [NSTimer
         scheduledTimerWithTimeInterval:1.0f
         target:self
         selector:@selector(shacho_timer_kidou:)
         userInfo:nil
         repeats:NO
         ];
    }
    
    else{
        NSLog(@"もう起動してる");
    }
        
        
    }
    
    //ゲージを復元
    iraira_value = (int)[ud integerForKey:@"KEY_iraira_I"];
    
    
    
}



//盗め押下時
-(void)nusume_btn_down{
    
    //タッチ無効化がなされてなかったら動作
    if (flag_touch_kinshi == NO) {
        
        sound_roop1 = YES;
        [self soundBtn_click_r:nil];
        
        //煙
        
        NSArray *imgArray = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"kemuri0.png"],
                             [UIImage imageNamed:@"kemuri1.png"],
                             [UIImage imageNamed:@"kemuri2.png"],
                             [UIImage imageNamed:@"kemuri3.png"],
                             [UIImage imageNamed:@"kemuri4.png"],
                             [UIImage imageNamed:@"kemuri5.png"],
                             [UIImage imageNamed:@"kemuri6.png"],
                             [UIImage imageNamed:@"kemuri7.png"],
                             nil];
        UIImageView *animationView = [[UIImageView alloc] initWithFrame:CGRectMake(150+chosei_w,140+chosei_h,180*chosei_size,210*chosei_size)];
        animationView.animationImages = imgArray;
        animationView.animationDuration = 0.8f; // アニメーション全体で3秒（＝各間隔は0.5秒）
        animationView.animationRepeatCount = 1;
        [self addSubview:animationView];
        [animationView startAnimating]; // アニメーション開始
        

        
    watashi1.hidden = YES;
    watashi2.hidden = NO;
    watashi_me1.hidden = NO;
    
    //ゲージ貯めるタイマー
    gage_timer1 =
    [NSTimer
     scheduledTimerWithTimeInterval:0.1f
     target:self
     selector:@selector(gage_plus:)
     userInfo:nil
     repeats:YES
     ];
        
    }
    
}

//盗め離時
-(void)nusume_btn_up{
    
    sound_roop1 = NO;
    [tm_r1 invalidate];
    
    //煙
    NSArray *imgArray = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:@"kemuri0.png"],
                         [UIImage imageNamed:@"kemuri1.png"],
                         [UIImage imageNamed:@"kemuri2.png"],
                         [UIImage imageNamed:@"kemuri3.png"],
                         [UIImage imageNamed:@"kemuri4.png"],
                         [UIImage imageNamed:@"kemuri5.png"],
                         [UIImage imageNamed:@"kemuri6.png"],
                         [UIImage imageNamed:@"kemuri7.png"],
                         nil];
    UIImageView *animationView = [[UIImageView alloc] initWithFrame:CGRectMake(150+chosei_w,140+chosei_h,180*chosei_size,210*chosei_size)];
    animationView.animationImages = imgArray;
    animationView.animationDuration = 0.8f; // アニメーション全体で3秒（＝各間隔は0.5秒）
    animationView.animationRepeatCount = 1;
    [self addSubview:animationView];
    [animationView startAnimating]; // アニメーション開始
    
    watashi1.hidden = NO;
    watashi2.hidden = YES;
    watashi_me1.hidden = YES;
    
    [gage_timer1 invalidate];
    
    gage_fuel = 0;
}


//盗みが成功したとき
-(void)nusumi_seiko{
    
    
    NSLog(@"盗み成功");
    
    NSString *item_key = [NSString stringWithFormat:@"KEY_item%d",item_num];
    [ud setBool:YES forKey:item_key];
    
    [shacho_timer0 invalidate];
    [shacho_timer1 invalidate];
    [shacho_timer2 invalidate];
    moku1.hidden = YES;
    moku2.hidden = YES;
    shacho2.hidden = YES;
    shacho1.hidden = NO;
    zzz1.hidden = NO;
    shacho3.hidden = YES;
    yume_naiyou.hidden = YES;
    
    [self nusume_btn_up];
    
    //忍者消える
    watashi2.hidden = YES;
    watashi_me1.hidden = YES;
    watashi1.hidden = YES;
    
    
    flag_touch_kinshi = YES;
    
    nusume_btn.userInteractionEnabled = NO;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    seiko_moji.hidden = NO;
    
    //タイマー
    NSTimer *seikou_timer1 =
    [NSTimer
     scheduledTimerWithTimeInterval:3.0f
     target:self
     selector:@selector(seikou_ato:)
     userInfo:nil
     repeats:NO
     ];
    
    //タイマー
    NSTimer *shokika_timer1 =
    [NSTimer
     scheduledTimerWithTimeInterval:4.0f
     target:self
     selector:@selector(shokika:)
     userInfo:nil
     repeats:NO
     ];
    
}

//アイテムゲット画面 seikou_view
-(void)seikou_ato:(NSTimer*)seikou_timer1{
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    nusume_btn.userInteractionEnabled = NO;
    settei_btn.userInteractionEnabled = NO;
    seika_btn.userInteractionEnabled = NO;
    
    //itemu_num(0~)+10をitem_num_sとしてキャスト
    int item_tag = item_num + 10;
    
    UIImage *seikou_bk_i = [UIImage imageNamed:@"seikou_bk"];
    UIImageView *seikou_bk_s = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [seikou_bk_s setImage:seikou_bk_i];
    [self addSubview:seikou_bk_s];
    
    //twitter
    UIImage *t_img = [UIImage imageNamed:@"btn_twi"];  // ボタンにする画像を生成する
    UIButton *t_btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 430+chosei_h, 50, 50)];  // ボタンのサイズを指定する
    [t_btn setBackgroundImage:t_img forState:UIControlStateNormal];  // 画像をセットする
    [t_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンが押された時にhogeメソッドを呼び出す
    t_btn.tag = 4;
    [self addSubview:t_btn];
    
    //favebook
    UIImage *f_img = [UIImage imageNamed:@"btn_fb"];  // ボタンにする画像を生成する
    UIButton *f_btn = [[UIButton alloc]initWithFrame:CGRectMake(150, 430+chosei_h, 50, 50)];  // ボタンのサイズを指定する
    [f_btn setBackgroundImage:f_img forState:UIControlStateNormal];  // 画像をセットする
    [f_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンが押された時にhogeメソッドを呼び出す
    f_btn.tag = 5;
    [self addSubview:f_btn];
    
    
    // 画像を表示する
    NSString* strA = [NSString stringWithFormat : @"%d", (int)item_tag];
    NSDictionary *dict = [DataControl getRyouri:strA];
    NSString *x_length = [dict objectForKey:@"x_l"];
    NSString *y_length = [dict objectForKey:@"y_l"];
    int x_l_f = [x_length intValue];
    int y_l_i = [y_length intValue];
    
    NSString *seika_item_num_s =  [NSString stringWithFormat:@"seika_item%d",item_num];
    UIImage *seika_item = [UIImage imageNamed:seika_item_num_s];
    UIImageView *seika_item_s = [[UIImageView alloc] initWithFrame:CGRectMake(160+chosei_w, 240+chosei_h*1.2, x_l_f * chosei_size, y_l_i *chosei_size)];
    [seika_item_s setImage:seika_item];
    [self addSubview:seika_item_s];
    
    // アニメーション
    [UIView animateWithDuration:1.0f // アニメーション速度2.5秒
                          delay:0.0f // 1秒後にアニメーション
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // 画像を2倍に拡大
                         seika_item_s.transform = CGAffineTransformMakeScale(20.0, 20.0);
                         
                     } completion:^(BOOL finished) {
                         // アニメーション終了時
                         [self juryo_keisan];
                     }];
    
    [self soundBtn_get:nil];
    
    UIImage *tsugi_btn_i = [UIImage imageNamed:@"te1"];
    UIButton *tsugi_btn = [[UIButton alloc] initWithFrame:CGRectMake(240+chosei_w, 400+chosei_h, 70*chosei_size, 90*chosei_size)];
    [tsugi_btn setBackgroundImage:tsugi_btn_i forState:UIControlStateNormal];
    [tsugi_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    [tsugi_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
    tsugi_btn.tag = item_tag;
    [self addSubview:tsugi_btn];
    
    //SeikouView *sv = [SeikouView alloc];
    //[sv SeikouView_hyoji];
    
    
}

-(void)juryo_keisan{
    
    //文字を表示
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300*chosei_size, 40*chosei_size)];
    int omosa = (arc4random() % 100) * 100;
    
    //価値(重さ)計算
    int omosa_goukei = (int)[ud integerForKey:@"KEY_omosa_goukei"];
    int new_omosa_goukei = omosa_goukei + omosa;
    [ud setInteger:new_omosa_goukei forKey:@"KEY_omosa_goukei"];
    [ud synchronize];
    
    NSString *omosa_s = [NSString stringWithFormat:@"今回のお宝の価値 %d 円",omosa];
    Label1.text = omosa_s;
    Label1.textColor = [UIColor blackColor];
    //Label1.backgroundColor = [UIColor blueColor];
    Label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:Label1];
    
    NSTimer *juryo_keisan2 =
    [NSTimer
     scheduledTimerWithTimeInterval:1.0f
     target:self
     selector:@selector(juryo_keisan2:)
     userInfo:nil
     repeats:NO
     ];
    
    
    
}

-(void)juryo_keisan2:(NSTimer *)juryo_keisan2{
    
    //文字を表示
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
    int omosa_goukei = (int)[ud integerForKey:@"KEY_omosa_goukei"];
    
    NSString *omosa_s = [NSString stringWithFormat:@"持っているお宝の総額 %d 円",omosa_goukei];
    Label1.text = omosa_s;
    Label1.textColor = [UIColor blackColor];
    //Label1.backgroundColor = [UIColor blueColor];
    Label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:Label1];
    
    
}

//殿にバレた時
-(void)shacho_okoru{
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [self nusume_btn_up];
    
    flag_touch_kinshi = YES;
    
    flag_bareta = YES;
    
    [shacho_timer0 invalidate];
    [shacho_timer1 invalidate];
    [shacho_timer2 invalidate];
    moku1.hidden = YES;
    moku2.hidden = YES;
    shacho2.hidden = YES;
    shacho1.hidden = YES;
    zzz1.hidden = YES;
    shacho3.hidden = NO;
    yume_naiyou.hidden = YES;
    
    NSTimer *shippai_timer1 =
    [NSTimer
     scheduledTimerWithTimeInterval:2.0f
     target:self
     selector:@selector(shippai1:)
     userInfo:nil
     repeats:NO
     ];
    
    kora_s.hidden = NO;
    //[self bringSubviewToFront:kora_s];
    
    shacho_timer_b = NO;
    
    
    
}

-(void)shippai1:(NSTimer*)shippai_timer1{
    
    NSTimer *shippai_timer2 =
    [NSTimer
     scheduledTimerWithTimeInterval:3.0f
     target:self
     selector:@selector(shippai2:)
     userInfo:nil
     repeats:NO
     ];
    
    kora1_s.hidden = NO;
    
}

-(void)shippai2:(NSTimer*)shippai_timer1{
    
    kora_s.hidden = YES;
    kora1_s.hidden = YES;
    
    //タイマー
    NSTimer *shokika_timer1 =
    [NSTimer
     scheduledTimerWithTimeInterval:0.0f
     target:self
     selector:@selector(shokika:)
     userInfo:nil
     repeats:NO
     ];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
}


//盗むときの動き
-(void)watashi_nusumu1:(NSTimer*)watashi_timer1{
    
    watashi1.hidden = NO;
    watashi2.hidden = YES;
    watashi_me1.hidden = YES;
    
}

//ゲージ貯める
-(void)gage_plus:(NSTimer *)gage_timer1{
    
    if (flag_touch_kinshi == NO) {
    
    gage_fuel = gage_fuel + 0.10;
    //テスト
    //gage_fuel = gage_fuel + 1.20;
    
    iraira_value = iraira_value +0.2 + gage_fuel;
    CGRect newFrame = CGRectMake(44, 57+chosei_h/3, iraira_value*chosei_size+(chosei_size-1)*50, 30*chosei_size);
        
    mater_value_s.frame = newFrame;
    [ud setInteger:iraira_value forKey:@"KEY_iraira_I"];
    [ud synchronize];

    //盗みゲージがマックスになったとき
    if (iraira_value > 230) {
        
        //盗み成功時イベント発生
        [self nusumi_seiko];
    }
    
    if(shacho_miteru == YES){
        
        [self shacho_okoru];
        
    }
        
  }
    
}


//【殿の動き】〜

//社長寝る
-(void)shacho_timer_kidou:(NSTimer*)shacho_timer2{
    
    
    //夢表示
    int x1 = 10 + arc4random() % 1;
    yume_num = x1 * 10;//ランダムを記述
    int x = yume_num + 0;
    
    NSString* strA = [NSString stringWithFormat : @"%d", (int)x];
    NSDictionary *dict = [DataControl getRyouri:strA];
    
    //夢の内容
    //NSString *yume_text1 = [dict objectForKey:@"text"];
    //yume_moji1.text = yume_text1;
    
    NSString *yume_naiyou_s = [dict objectForKey:@"gazo"];
    UIImage *yume_naiyou_i = [UIImage animatedGIFNamed:yume_naiyou_s];
    [yume_naiyou setImage:yume_naiyou_i];
    
    //時間
    NSString *time_s = [dict objectForKey:@"time"];
    float time_f =  [time_s floatValue];
    
    //タイマー
    shacho_timer0 =
    [NSTimer
     scheduledTimerWithTimeInterval:time_f
     target:self
     selector:@selector(shacho_furimuku0:)
     userInfo:nil
     repeats:NO
     ];
    
    shacho1.hidden = NO;
    zzz1.hidden = NO;
    shacho2.hidden = YES;
    
    shacho_miteru = NO;
    
    moku1.hidden = NO;
    
}

//社長起きかけ
-(void)shacho_furimuku0:(NSTimer*)shacho_timer0{
    
    int x = yume_num + 1;
    
    NSString* strA = [NSString stringWithFormat : @"%d", (int)x];
    NSDictionary *dict = [DataControl getRyouri:strA];
    
    //夢の内容
    NSString *yume_text1 = [dict objectForKey:@"text"];
    yume_moji1.text = yume_text1;
    
    //内容画像
    NSString *yume_naiyou_s = [dict objectForKey:@"gazo"];
    UIImage *yume_naiyou_i = [UIImage animatedGIFNamed:yume_naiyou_s];
    [yume_naiyou setImage:yume_naiyou_i];
    
    
    //時間
    NSString *time_s = [dict objectForKey:@"time"];
    float time_f =  [time_s floatValue];
    
    moku1.hidden = YES;
    moku2.hidden = NO;
    
    shacho_timer1 =
    [NSTimer
     scheduledTimerWithTimeInterval:time_f
     target:self
     selector:@selector(shacho_furimuku1:)
     userInfo:nil
     repeats:NO
     ];
    
}

//殿がこっちを見る
-(void)shacho_furimuku1:(NSTimer*)shacho_timer1{
    
    int x = yume_num + 2;
    
    NSString* strA = [NSString stringWithFormat : @"%d", (int)x];
    NSDictionary *dict = [DataControl getRyouri:strA];
    /*
    //夢の内容
    NSString *yume_text1 = [dict objectForKey:@"text"];
    yume_moji1.text = yume_text1;
    */
    //内容画像
    NSString *yume_naiyou_s = [dict objectForKey:@"gazo"];
    UIImage *yume_naiyou_i = [UIImage imageNamed:yume_naiyou_s];
    [yume_naiyou setImage:yume_naiyou_i];
    
    shacho_timer2 =
    [NSTimer
     scheduledTimerWithTimeInterval:2.0f
     target:self
     selector:@selector(shacho_timer_kidou:)
     userInfo:nil
     repeats:NO
     ];
    
    shacho1.hidden = YES;
    zzz1.hidden = YES;
    shacho2.hidden = NO;
    
    shacho_miteru = YES;
    
    moku2.hidden = YES;
    moku1.hidden = YES;
    
}


//〜【社長の動き】

//初期化
-(void)shokika:(NSTimer*)shokika_timer1{
    
    NSString *yume_text1 = [NSString stringWithFormat:@""];
    yume_moji1.text = yume_text1;
    
    iraira_value = 0;
    [ud setInteger:0 forKey:@"KEY_iraira_I"];
    CGRect newFrame = CGRectMake(44, 62, iraira_value, 30);
    mater_value_s.frame = newFrame;
    kora_s.hidden = YES;
    
    //ボタンタッチ有効化
    nusume_btn.userInteractionEnabled = YES;
    
    //タッチ禁止かどうか
    flag_touch_kinshi = NO;
    
    //プレイ中かどうか
    [ud setBool:NO forKey:@"KEY_flag_playing"];
    [ud synchronize];
    
    moku1.hidden = YES;
    moku2.hidden = YES;
    
    if (flag_bareta == YES) {
        
        [self execMain];
        flag_bareta = NO;
        
    }
    
}

//任務開始
-(void)ninmu_kaishi:(NSTimer*)ninmukaishi_timer1{
    
    ninmukaishi.hidden = NO;
    
    NSTimer *ninmukaishi_timer2 =
    [NSTimer
     scheduledTimerWithTimeInterval:3.0f
     target:self
     selector:@selector(ninmu_kaishi2:)
     userInfo:nil
     repeats:NO
     
     ];
    
    NSTimer *ninmukaishi_timer15 =
    [NSTimer
     scheduledTimerWithTimeInterval:1.5f
     target:self
     selector:@selector(ninmu_kaishi15:)
     userInfo:nil
     repeats:NO
     ];
    
}
-(void)ninmu_kaishi15:(NSTimer*)ninmukaishi_timer15{
    
    //体力再表示
    tairyoku = (int)[ud integerForKey:@"KEY_tairyoku"];
    tairyoku = tairyoku - 1;
    [ud setInteger:tairyoku forKey:@"KEY_tairyoku"];
    [ud synchronize];
    
    if (tairyoku == 0) {
        tairyoku1.hidden = YES;
    }
    else if (tairyoku == 1){
        tairyoku2.hidden = YES;
    }
    else if (tairyoku == 2){
        tairyoku3.hidden = YES;
    }
    else if (tairyoku == 3){
        tairyoku4.hidden = YES;
    }
    else if (tairyoku == 4){
        tairyoku5.hidden = YES;
    }
    
    
}

-(void)ninmu_kaishi2:(NSTimer*)ninmukaishi_timer1{
    
    ninmukaishi.hidden = YES;
    
    flag_touch_kinshi = NO;
    
    nusume_btn.userInteractionEnabled = YES;
    settei_btn.userInteractionEnabled = YES;
    seika_btn.userInteractionEnabled = YES;
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    


    
}

- (void)soundBtn_click:(id)sender{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
    
    AudioServicesPlaySystemSound(sound_click1);
        
    }
    
}

- (void)soundBtn_get:(id)sender{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
    
    AudioServicesPlaySystemSound(sound_get1);
        
    }
    
}

- (void)soundBtn_noise:(id)sender{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
    
    AudioServicesPlaySystemSound(sound_noise1);
        
    }
    
}

- (void)soundBtn_click_r:(id)sender{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
    
    AudioServicesPlaySystemSound(sound_coin);
    
    if (sound_roop1 == YES) {
        
        tm_r1 =
        [NSTimer
         scheduledTimerWithTimeInterval:1.15f
         target:self
         selector:@selector(soundBtn_click_r:)
         userInfo:nil
         repeats:NO
         ];

    }
        
    }
    
}


-(void)sound_play{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
    
    NSLog(@"BGM_play");
        NSString *path0 = [[NSBundle mainBundle] pathForResource:@"bgm2" ofType:@"mp3"];
        url0 = [NSURL fileURLWithPath:path0];
        self.sound_bgm1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url0 error:NULL];
        // 音量設定
        self.sound_bgm1.volume = 0.2f;
        self.sound_bgm1.numberOfLoops = -1;

    [self.sound_bgm1 play];
        
    }
}

-(void)sound_stop{
    
    //NSLog(@"2-1");
    
    //NSLog(@"BGM_stop");
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"bgm2" ofType:@"mp3"];
    
    //NSLog(@"2-2");
    url0 = [NSURL fileURLWithPath:path0];
    
    //NSLog(@"2-3");
    self.sound_bgm1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url0 error:NULL];
    // 音量設定
    
    //NSLog(@"2-4");
    self.sound_bgm1.volume = 0.2f;
    self.sound_bgm1.numberOfLoops = -1;
    [self.sound_bgm1 stop];
    
}

-(void)tairyoku_hyoji{
    
    //体力表示
    tairyoku = (int)[ud integerForKey:@"KEY_tairyoku"];
    
    NSLog(@"体力=%d",tairyoku);
    
    if (tairyoku == 0) {
        
    }
    else if (tairyoku == 1){
        tairyoku1.hidden = NO;
        
        
        if (flag_wating == YES) {
            
            NSLog(@"%d",flag_wating);
            flag_wating = NO;
            //[self execMain];
            
        }
         
    }
    else if (tairyoku == 2){
        tairyoku1.hidden = NO;
        tairyoku2.hidden = NO;
        
        if (flag_wating == YES) {
            
            NSLog(@"%d",flag_wating);
            flag_wating = NO;
            //[self execMain];
            
        }
    }
    else if (tairyoku == 3){
        tairyoku1.hidden = NO;
        tairyoku2.hidden = NO;
        tairyoku3.hidden = NO;
        
        if (flag_wating == YES) {
            
            NSLog(@"%d",flag_wating);
            flag_wating = NO;
            //[self execMain];
            
        }
    }
    else if (tairyoku == 4){
        tairyoku1.hidden = NO;
        tairyoku2.hidden = NO;
        tairyoku3.hidden = NO;
        tairyoku4.hidden = NO;
        
        if (flag_wating == YES) {
            
            NSLog(@"%d",flag_wating);
            flag_wating = NO;
            //[self execMain];
            
        }
    }
    else if (tairyoku == 5){
        tairyoku1.hidden = NO;
        tairyoku2.hidden = NO;
        tairyoku3.hidden = NO;
        tairyoku4.hidden = NO;
        tairyoku5.hidden = NO;
        
        if (flag_wating == YES) {
            
            NSLog(@"%d",flag_wating);
            flag_wating = NO;
            //[self execMain];
            
        }
    }
}

-(void)shokai_hyoji{
    
    shokai_b = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,580)];
    shokai_b.backgroundColor = [UIColor blackColor];
    shokai_b.alpha = 0.7;
    
    [self addSubview:shokai_b];
    
    shokai = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,580)];
    
    UIImage *setsumei_i = [UIImage imageNamed:@"shokai"];
    UIImageView *setsumei_v = [[UIImageView alloc]initWithFrame:CGRectMake(10,50,300,400)];
    [setsumei_v setImage:setsumei_i];
    [shokai addSubview:setsumei_v];
    
    UIImage *tsugi_btn_i = [UIImage imageNamed:@"te1"];
    UIButton *tsugi_btn = [[UIButton alloc] initWithFrame:CGRectMake(120+chosei_w, 370+chosei_h*1.2, 70*chosei_size, 90*chosei_size)];
    [tsugi_btn setBackgroundImage:tsugi_btn_i forState:UIControlStateNormal];
    [tsugi_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    [tsugi_btn addTarget:self action:@selector(close_shokai) forControlEvents:UIControlEventTouchUpInside];
    [shokai addSubview:tsugi_btn];
    
    [self addSubview:shokai];
    
    NSLog(@"a");
    
}

-(void)close_shokai{
    
    shokai_b.hidden = YES;
    shokai.hidden = YES;
    
    [ud setBool:YES forKey:@"KEY_Shokai"];
    [ud synchronize];
    
    [self execMain];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
