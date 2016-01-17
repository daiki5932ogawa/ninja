//
//  ViewController.m
//  Sample
//
//  Created by MACM001 on 2014/08/05.
//  Copyright (c) 2014年 MACM001. All rights reserved.
//

#import "ViewController.h"
#import "RootView.h"
#import "MainView.h"
#import "SubView.h"
#import "SeikaView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PRView.h"
#import "DataControl.h"

@interface ViewController ()

@end

@implementation ViewController{
    RootView *showView;
    RootView *oldView;
    NSUserDefaults *ud;
    
    NSTimer *tairyoku_kaifuku_t;
    NSTimer *tairyoku_kaifuku_nokori_t;
    
    UIView *mainView;
    UIView *prView;
    UIView *pr2View;
    
    NSURL *url0;
}

@synthesize adg = adg_;

-(void)sound_load{
    
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
        NSLog(@"再生");
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    

    
    /*
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
        
        [self.sound_bgm1 play];
        
    }
    
     */
    
    //Viewのフレーム()
    showViewRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //各Viewを表示させるView
    self->mainView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self->mainView];
    
    self->prView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, 320, 50)];
    self->prView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self->prView];
    
    //バナー広告
    NSDictionary *adgparam = @{
                               @"locationid" : @"10723", //管理画面から払い出された広告枠ID
                               @"adtype" : @(kADG_AdType_Sp), //管理画面にて入力した枠サイズ(kADG_AdType_Sp：320x50, kADG_AdType_Large:320x100, kADG_AdType_Rect:300x250, kADG_AdType_Tablet:728x90, kADG_AdType_Free
                               @"originx" : @(0), //広告枠設置起点のx座標 ※下記参照
                               @"originy" : @(568 - 50), //広告枠設置起点のy座標 ※下記参照
                               @"w" : @(0), //広告枠横幅 ※下記参照
                               @"h" : @(0)  //広告枠高さ ※下記参照
                               };
    ADGManagerViewController *adgvc = [[ADGManagerViewController alloc]initWithAdParams :adgparam :prView];
    self.adg = adgvc;
    adg_.delegate = self;
    [adg_ loadRequest];
    
    self->pr2View = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, 300, 250)];
    self->pr2View.center = self.view.center;
    self->pr2View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self->prView];
    
    
    
    //  通知受信の設定
    NSNotificationCenter*   nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(applicationDidEnterBackground) name:@"applicationDidEnterBackground" object:nil];
    [nc addObserver:self selector:@selector(applicationWillEnterForeground) name:@"applicationWillEnterForeground" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidLaunched)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    //MainView *mv = [MainView alloc];
    //[mv execMain];
    
    ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"NO" forKey:@"KEY_Timer1_B"];
    [ud registerDefaults:defaults];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myFunction)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    tairyoku_kaifuku_t = [NSTimer
     scheduledTimerWithTimeInterval:300.0f
     target:self
     selector:@selector(tairyoku_kaifuku:)
     userInfo:nil
     repeats:YES
     ];
    /*
     残り何分で体力が回復するかを記述。
     面倒なので後で。ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    tairyoku_kaifuku_nokori_t =[NSTimer
                                scheduledTimerWithTimeInterval:60.0f
                                target:self
                                selector:@selector(kaifuku_nokori_hyoji:)
                                userInfo:nil
                                repeats:YES
                                ];
     */
    self->showView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [self->showView addTarget:self action:@selector(onMain:)];
    [self.view addSubview:self->showView];
    
    [self sound_load];
    
}
/*
-(void)kaifuku_nokori_hyoji:(NSTimer *)tairyoku_kaifuku_nokori_t{
    
    
    [ud setInteger:nokori_time forKey:@"nokori_time_i"];
    
    
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onPRView:(PRView *)sender{
    
    if (sender.touchView == 0) {
        
        
        self->oldView = self->showView;
        MainView *mv = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self->showView = mv;
        [self->showView addTarget:self action:@selector(onMain:)];
        [self->mainView addSubview:self->showView];
        
        mv = [MainView alloc];
        [mv execMain];
        
    }
    
}


- (void)onMain:(MainView *)sender{
    if(sender.touchView == 1){
        
        self->oldView = self->showView;
        self->showView = [[MainView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, 320, 568)];
        [self->showView addTarget:self action:@selector(onMain:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
    }
    else if(sender.touchView == 3){
        
        self->oldView = self->showView;
        self->showView = [[SubView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, 568)];
        [self->showView addTarget:self action:@selector(onSub:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
        
        //広告表示
        UIScreen *sc = [UIScreen mainScreen];
        CGRect rect = sc.bounds;
        prView = [[UIView alloc] initWithFrame:CGRectMake(0,rect.size.height - 50,self.view.frame.size.width,50)];
        [self->mainView addSubview:prView];
        
    }
    else if(sender.touchView == 2){
        
        self->oldView = self->showView;
        self->showView = [[SeikaView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, 320, 568)];
        [self->showView addTarget:self action:@selector(onSeika:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
        
        //広告表示
        UIScreen *sc = [UIScreen mainScreen];
        CGRect rect = sc.bounds;
        prView = [[UIView alloc] initWithFrame:CGRectMake(0,rect.size.height - 50,self.view.frame.size.width,50)];
        [self->mainView addSubview:prView];
        
    }
    else if (sender.touchView == 4){
        /*
        ud = [NSUserDefaults standardUserDefaults];
        int ryori = (int)[ud integerForKey:@"KEY_Ryori_I"];
        
        NSLog(@"ryori = %d",ryori);
        
        NSString* strA = [NSString stringWithFormat : @"%d", ryori];
        NSDictionary *dict = [DataControl getRyouri:strA];
        NSString* ryori_name = [dict objectForKey:@"name"];
        
        NSLog(@"名前=%@",ryori_name);
        */
        
        int item_num = (int)[ud integerForKey:@"KEY_Item_num"];
        int item_tag = item_num + 10;
        NSString* strA = [NSString stringWithFormat : @"%d", (int)item_tag];
        NSDictionary *dict = [DataControl getRyouri:strA];
        NSString *item_name = [dict objectForKey:@"name"];
        NSString *text_include_item_name = [NSString stringWithFormat:@"%@をお殿様から盗んだよ！！",item_name];
        
        SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterPostVC setInitialText:text_include_item_name];
        [twitterPostVC addURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.co.jp/"]]];
        [self presentViewController:twitterPostVC animated:YES completion:nil];
        
    }
    else if (sender.touchView ==5){
        /*
        ud = [NSUserDefaults standardUserDefaults];
        int ryori = (int)[ud integerForKey:@"KEY_Ryori_I"];
        
        NSString* strA = [NSString stringWithFormat : @"%d", ryori];
        NSDictionary *dict = [DataControl getRyouri:strA];
        NSString* ryori_name = [dict objectForKey:@"name"];
        */
        int item_num = (int)[ud integerForKey:@"KEY_Item_num"];
        int item_tag = item_num + 10;
        NSString* strA = [NSString stringWithFormat : @"%d", (int)item_tag];
        NSDictionary *dict = [DataControl getRyouri:strA];
        NSString *item_name = [dict objectForKey:@"name"];
        NSString *text_include_item_name = [NSString stringWithFormat:@"%@をお殿様から盗んだよ！！",item_name];
        
        SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookPostVC setInitialText:text_include_item_name];
        [facebookPostVC addImage:[UIImage imageNamed:@"https://www.google.co.jp/"]];
        [self presentViewController:facebookPostVC animated:YES completion:nil];
        
    }
    
    else if (sender.touchView > 9){
        
        self->oldView = self->showView;
        self->showView = [[SeikaView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, 320, 568)];
        [self->showView addTarget:self action:@selector(onSeika:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
        
    }
}

-(void)onSub:(SubView *)sender{
    
    if(sender.touchView == 1){
        self->oldView = self->showView;
        self->showView = [[MainView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, 320, 568)];
        [self->showView addTarget:self action:@selector(onMain:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
        
        MainView *mv = [MainView alloc];
        [mv execMain];
        
        
    }
    else if(sender.touchView == 2){
        self->oldView = self->showView;
        self->showView = [[SubView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, 320, 568)];
        [self->showView addTarget:self action:@selector(onSub:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
    }
    
    else if (sender.touchView == 3){
        
        [self sound_play];
    }
    else if (sender.touchView == 4){
        
        [self sound_stop];
    }

    
}

-(void)onSeika:(SeikaView *)sender{
    
    if(sender.touchView == 1){
        
        int random = arc4random()%2;
        if (random == 0) {
            
        self->oldView = self->showView;
        self->showView = [[MainView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, 320, 568)];
        [self->showView addTarget:self action:@selector(onMain:)];
        [self.view addSubview:self->showView];
        [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self->oldView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
            self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
        } completion:^(BOOL finished) {
            //完了時のコールバック
            [self->oldView removeFromSuperview];
        }];
        
        MainView *mv = [MainView alloc];
        [mv execMain];
            
        }
        
        else{
            
            self->oldView = self->showView;
            PRView *pv = [[PRView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
            self->showView = pv;
            [self->showView addTarget:self action:@selector(onPRView:)];
            [self->mainView addSubview:self->showView];
            [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
                //アニメーションで変化させたい値を設定する（最終的に変更したい値）
                self->oldView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self->oldView.frame.size.height);
                self->showView.frame = CGRectMake(0, 0, self.view.frame.size.width, self->showView.frame.size.height);
            } completion:^(BOOL finished) {
                //完了時のコールバック
                [self->oldView removeFromSuperview];
            }];
            
        }
        
    }
    
}

- (void)applicationDidEnterBackground

{
    
#if defined(DEBUG)
    
    NSLog(@"applicationDidEnterBackground");
    //現在時刻を保存
    NSDate* date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"cdate"];
    
    [tairyoku_kaifuku_t invalidate];
    // バックグラウンド時になった時の実行処理
    
#endif
    
}

//2回目以降のフォアグラウンド実行になった際に呼び出される(Backgroundにアプリがある場合)---------------------------------------------------------------------------------

- (void)applicationWillEnterForeground

{
    
#if defined(DEBUG)
    
    NSLog(@"applicationWillEnterForeground");
    
    // 2回目以降の起動時になった時の実行処理
    
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
            NSLog(@"回復1(BG)");
        }
    }
    //+2する
    else if (mm >= 10 && mm < 15) {
        NSLog(@"回復2(BG)");
        if (tairyoku < 3) {
            tairyoku = tairyoku +2;
        }
        else if(tairyoku >= 3){
            tairyoku = 5;
        }
    }
    
    //+3する
    else if (mm >= 15 && mm < 20) {
        NSLog(@"回復3(BG)");
        if (tairyoku < 2) {
            tairyoku = tairyoku +3;
        }
        else if(tairyoku >= 2){
            tairyoku = 5;
        }
    }
    
    //+4する
    else if (mm >= 20 && mm < 25) {
        NSLog(@"回復4(BG)");
        if (tairyoku < 1) {
            tairyoku = tairyoku +4;
        }
        else if(tairyoku >= 1){
            tairyoku = 5;
        }
    }
    
    //+5する
    else if (mm >= 25 && mm < 30) {
        NSLog(@"回復5(BG)");
        if (tairyoku < 1) {
            tairyoku = tairyoku +5;
        }
        else if(tairyoku >= 1){
            tairyoku = 5;
        }
    }
    
    [ud setInteger:tairyoku forKey:@"KEY_tairyoku"];
    [ud synchronize];
    
    
    NSLog(@"%02d:%02d",hh,mm);
    
    BOOL b = [tairyoku_kaifuku_t isValid];
    //NSLog(@"体力タイマー再起動前＝%d",b);
    
    tairyoku_kaifuku_t = [NSTimer
                          scheduledTimerWithTimeInterval:60.0f
                          target:self
                          selector:@selector(tairyoku_kaifuku:)
                          userInfo:nil
                          repeats:YES
                          ];
    [tairyoku_kaifuku_t fire];
    
    b = [tairyoku_kaifuku_t isValid];
    //NSLog(@"体力タイマー再起動後＝%d",b);
    
    NSLog(@"1体力=%d",tairyoku);
    
    //体力表示更新
    MainView *mv = [MainView alloc];
    [mv tairyoku_hyoji];
    
    [mv execMain];
    
#endif
    
}

-(void)applicationDidLaunched{
    
    NSLog(@"didlaunched");
 
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
            NSLog(@"回復1(BG)");
        }
    }
    //+2する
    else if (mm >= 10 && mm < 15) {
        NSLog(@"回復2(BG)");
        if (tairyoku < 3) {
            tairyoku = tairyoku +2;
        }
        else if(tairyoku >= 3){
            tairyoku = 5;
        }
    }
    
    //+3する
    else if (mm >= 15 && mm < 20) {
        NSLog(@"回復3(BG)");
        if (tairyoku < 2) {
            tairyoku = tairyoku +3;
        }
        else if(tairyoku >= 2){
            tairyoku = 5;
        }
    }
    
    //+4する
    else if (mm >= 20 && mm < 25) {
        NSLog(@"回復4(BG)");
        if (tairyoku < 1) {
            tairyoku = tairyoku +4;
        }
        else if(tairyoku >= 1){
            tairyoku = 5;
        }
    }
    
    //+5する
    else if (mm >= 25 && mm < 30) {
        NSLog(@"回復5(BG)");
        if (tairyoku < 1) {
            tairyoku = tairyoku +5;
        }
        else if(tairyoku >= 1){
            tairyoku = 5;
        }
    }
    
    [ud setInteger:tairyoku forKey:@"KEY_tairyoku"];
    [ud synchronize];
    
    
    NSLog(@"%02d:%02d",hh,mm);
    
    BOOL b = [tairyoku_kaifuku_t isValid];
    //NSLog(@"体力タイマー再起動前＝%d",b);
    
    tairyoku_kaifuku_t = [NSTimer
                          scheduledTimerWithTimeInterval:60.0f
                          target:self
                          selector:@selector(tairyoku_kaifuku:)
                          userInfo:nil
                          repeats:YES
                          ];
    [tairyoku_kaifuku_t fire];
    
    b = [tairyoku_kaifuku_t isValid];
    //NSLog(@"体力タイマー再起動後＝%d",b);
    
    NSLog(@"2体力=%d",tairyoku);
    
    //体力表示更新
    MainView *mv = [MainView alloc];
    [mv tairyoku_hyoji];
    
    [mv execMain];
    

}

- (void)myFunction
{
    NSLog(@"終了メソッド");
    [ud setBool:YES forKey:@"flag_shuryo"];
    [ud synchronize];
    
    [tairyoku_kaifuku_t invalidate];
}

-(void)tairyoku_kaifuku:(NSTimer *)tairyoku_kaifuku_t{
    
    //体力に換算
    int tairyoku = (int)[ud integerForKey:@"KEY_tairyoku"];
    if (tairyoku != 5) {
        tairyoku = tairyoku + 1;
    }
    [ud setInteger:tairyoku forKey:@"KEY_tairyoku"];
    [ud synchronize];
    
    //NSLog(@"体力表示↓");
    MainView *mv = [MainView alloc];
    [mv tairyoku_hyoji];
    //NSLog(@"体力表示↑");
    
    
}


@end
