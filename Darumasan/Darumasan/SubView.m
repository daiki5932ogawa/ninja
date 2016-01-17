//
//  SubView.m
//  Sample
//
//  Created by MACM001 on 2014/08/05.
//  Copyright (c) 2014年 MACM001. All rights reserved.
//

#import "SubView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainView.h"

UIScreen *sc;
UIButton *oto_btn;
UIButton *oto_btn2;

UIButton *tsuchi_btn;
UIButton *tsuchi_btn2;

NSUserDefaults *ud;

//効果音
SystemSoundID sound_click1;

@implementation SubView
//設定画面

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor blackColor];
        
        //画面サイズ
        sc = [UIScreen mainScreen];
        CGRect rect = sc.bounds;
        int chosei_w = (rect.size.width - 320)/2;
        int chosei_h = (rect.size.height - 480)/2;
        float chosei_size = (rect.size.width+320)/640;
        
        //効果音
        //効果音ファイル読み込み
        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"mekuru" ofType:@"mp3"];
        NSURL *url1 = [NSURL fileURLWithPath:path1];
        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url1), &sound_click1);
        
        //背景
        UIImage *hannari_i = [UIImage imageNamed:@"settei_bk"];
        UIImageView *hannari1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [hannari1 setImage:hannari_i];
        [self addSubview:hannari1];
        
        UIImage *back_btn_i = [UIImage imageNamed:@"modoru.png"];
        UIButton *back_btn = [[UIButton alloc] initWithFrame:CGRectMake(120+chosei_w, 380+chosei_h*3/5, 480*1/5, 620/5)];
        [back_btn setBackgroundImage:back_btn_i forState:UIControlStateNormal];
        [back_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [back_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
        back_btn.tag = 1;
        [self addSubview:back_btn];
        
        //音をオフにするボタン
        UIImage *oto_btn_i = [UIImage imageNamed:@"oto_off.png"];
        oto_btn = [[UIButton alloc] initWithFrame:CGRectMake(60+chosei_w, 100+chosei_h*1.2, 200*chosei_size, 50*chosei_size)];
        [oto_btn setBackgroundImage:oto_btn_i forState:UIControlStateNormal];
        //[oto_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [oto_btn addTarget:self action:@selector(oto_off) forControlEvents:UIControlEventTouchUpInside];
        [oto_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
        oto_btn.tag = 4;
        [self addSubview:oto_btn];
        //oto_btn.hidden = NO;
        
        //音をオンにするボタン
        UIImage *oto_btn2_i = [UIImage imageNamed:@"oto_on.png"];
        oto_btn2 = [[UIButton alloc] initWithFrame:CGRectMake(70+chosei_w, 100+chosei_h*1.2, 200*chosei_size, 50*chosei_size)];
        [oto_btn2 setBackgroundImage:oto_btn2_i forState:UIControlStateNormal];
        [oto_btn2 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [oto_btn2 addTarget:self action:@selector(oto_on) forControlEvents:UIControlEventTouchUpInside];
        [oto_btn2 addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
        oto_btn2.tag = 3;
        [self addSubview:oto_btn2];
        //oto_btn2.hidden = YES;

        
        //通知をオフにするボタン
        UIImage *tsuchi_btn_i = [UIImage imageNamed:@"tsuchi.png"];
        tsuchi_btn = [[UIButton alloc] initWithFrame:CGRectMake(60+chosei_w, 250+chosei_h*1.2, 200*chosei_size, 50*chosei_size)];
        [tsuchi_btn setBackgroundImage:tsuchi_btn_i forState:UIControlStateNormal];
        //[oto_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [tsuchi_btn addTarget:self action:@selector(tsuchi_off) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tsuchi_btn];
        
        //通知をオンにするボタン
        UIImage *tsuchi_btn2_i = [UIImage imageNamed:@"tsuchi.png"];
        tsuchi_btn2 = [[UIButton alloc] initWithFrame:CGRectMake(70+chosei_w, 250+chosei_h*1.2, 100*chosei_size, 50*chosei_size)];
        [tsuchi_btn2 setBackgroundImage:tsuchi_btn2_i forState:UIControlStateNormal];
        [tsuchi_btn2 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [tsuchi_btn2 addTarget:self action:@selector(tsuchi_on) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tsuchi_btn2];
        //oto_btn2.hidden = YES;
        
        [self on_off_handan];
        
        
    }
    return self;
}

-(void)on_off_handan{
    
    NSLog(@"オンオフ判断");
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
     
        oto_btn2.hidden = YES;
        oto_btn.hidden = NO;
        
    }
    else if (oto_onoff == NO){
        
        oto_btn2.hidden = NO;
        oto_btn.hidden = YES;
        
    }
    
    BOOL tsuchi_onoff = [ud boolForKey:@"KEY_Tsuchi"];
    
    NSLog(@"tsuchi=%d",tsuchi_onoff);
    
    if (tsuchi_onoff == YES) {
        
        NSLog(@"YES");
        
        tsuchi_btn2.hidden = YES;
        tsuchi_btn.hidden = NO;
        
    }
    else if (oto_onoff == NO){
        
        
        NSLog(@"NO");
        
        tsuchi_btn2.hidden = NO;
        tsuchi_btn.hidden = YES;
        
    }
    
}

-(void)oto_on{
    
    NSLog(@"オン");
    
    oto_btn.hidden = NO;
    oto_btn2.hidden = YES;
    
    [ud setBool:YES forKey:@"KEY_oto"];
    [ud synchronize];
    
    MainView *mv = [MainView alloc];
    
    [mv sound_play];
     
}

-(void)oto_off{
    
    NSLog(@"オフ");
    
    oto_btn.hidden = YES;
    oto_btn2.hidden = NO;
    
    //NSLog(@"1");
    
    [ud setBool:NO forKey:@"KEY_oto"];
    [ud synchronize];
    
    //NSLog(@"2");
    
    MainView *mv = [MainView alloc];
    
    //NSLog(@"3");
    [mv sound_stop];
    
    //NSLog(@"4");
}

- (void)soundBtn_click:(id)sender{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
        
    AudioServicesPlaySystemSound(sound_click1);
    
    }
}

-(void)tsuchi_on{
    
    //BOOL tsuchi = YES;
    [ud setBool:YES forKey:@"KEY_Tsuchi"];
    [ud synchronize];
    
    tsuchi_btn.hidden = NO;
    tsuchi_btn2.hidden = YES;
    
}
-(void)tsuchi_off{
    
    //BOOL tsuchi = NO;
    [ud setBool:NO forKey:@"KEY_Tsuchi"];
    [ud synchronize];
    
    tsuchi_btn2.hidden = NO;
    tsuchi_btn.hidden = YES;
    
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
