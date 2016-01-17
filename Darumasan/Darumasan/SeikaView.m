//
//  SeikaView.m
//  Darumasan
//
//  Created by 小川大暉 on 2014/10/22.
//  Copyright (c) 2014年 DaikiOgawa. All rights reserved.
//

#import "SeikaView.h"
#import "DataControl.h"
#import <AudioToolbox/AudioToolbox.h>

UIScreen *sc;

int i;

UIButton *back_btn;
UIButton *next_btn;
UIButton *prev_btn;

//詳細表示View
UIView *item_group1_v;
UIView *item_group2_v;
UIView *item_group3_v;
UIImageView *view_bk;
UIButton *back_btn2;
int nextbtn_tag;
int prevbtn_tag;

//表示是非
BOOL shosai_hyoji_b;

NSUserDefaults *ud;

UILabel *lName;
UILabel *lDetail;
UIImageView *image_inShosai;

//効果音
SystemSoundID sound_click1;

@implementation SeikaView
//成果画面

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
        
        //ゲットしたかどうかBOOL
        ud = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
        /*
        [defaults setObject:@"NO" forKey:@"KEY_item0"];
        [defaults setObject:@"NO" forKey:@"KEY_item1"];
        [defaults setObject:@"NO" forKey:@"KEY_item2"];
        [defaults setObject:@"NO" forKey:@"KEY_item3"];
        [defaults setObject:@"NO" forKey:@"KEY_item4"];
        [defaults setObject:@"NO" forKey:@"KEY_item5"];
        [defaults setObject:@"NO" forKey:@"KEY_item6"];
        [defaults setObject:@"NO" forKey:@"KEY_item7"];
        [defaults setObject:@"NO" forKey:@"KEY_item8"];
        [defaults setObject:@"NO" forKey:@"KEY_item9"];
        [defaults setObject:@"NO" forKey:@"KEY_item10"];
        [defaults setObject:@"NO" forKey:@"KEY_item11"];
        [defaults setObject:@"NO" forKey:@"KEY_item12"];
        [defaults setObject:@"NO" forKey:@"KEY_item13"];
        [defaults setObject:@"NO" forKey:@"KEY_item14"];
        [defaults setObject:@"NO" forKey:@"KEY_item15"];
        [defaults setObject:@"NO" forKey:@"KEY_item16"];
        [defaults setObject:@"NO" forKey:@"KEY_item17"];
        [defaults setObject:@"NO" forKey:@"KEY_item18"];
        [defaults setObject:@"NO" forKey:@"KEY_item19"];
        [defaults setObject:@"NO" forKey:@"KEY_item21"];
        */
        [defaults setObject:@"YES" forKey:@"KEY_item0"];
        [defaults setObject:@"YES" forKey:@"KEY_item1"];
        [defaults setObject:@"YES" forKey:@"KEY_item2"];
        [defaults setObject:@"YES" forKey:@"KEY_item3"];
        [defaults setObject:@"YES" forKey:@"KEY_item4"];
        [defaults setObject:@"YES" forKey:@"KEY_item5"];
        [defaults setObject:@"YES" forKey:@"KEY_item6"];
        [defaults setObject:@"YES" forKey:@"KEY_item7"];
        [defaults setObject:@"YES" forKey:@"KEY_item8"];
        [defaults setObject:@"YES" forKey:@"KEY_item9"];
        [defaults setObject:@"YES" forKey:@"KEY_item10"];
        [defaults setObject:@"YES" forKey:@"KEY_item11"];
        [defaults setObject:@"YES" forKey:@"KEY_item12"];
        [defaults setObject:@"YES" forKey:@"KEY_item13"];
        [defaults setObject:@"YES" forKey:@"KEY_item14"];
        [defaults setObject:@"YES" forKey:@"KEY_item15"];
        [defaults setObject:@"YES" forKey:@"KEY_item16"];
        [defaults setObject:@"YES" forKey:@"KEY_item17"];
        [defaults setObject:@"YES" forKey:@"KEY_item18"];
        [defaults setObject:@"YES" forKey:@"KEY_item19"];
        [defaults setObject:@"YES" forKey:@"KEY_item21"];
        [defaults setObject:@"YES" forKey:@"KEY_item22"];
        [defaults setObject:@"YES" forKey:@"KEY_item23"];
        [defaults setObject:@"YES" forKey:@"KEY_item24"];
        [defaults setObject:@"YES" forKey:@"KEY_item25"];
        [ud registerDefaults:defaults];
        
        nextbtn_tag = 2;
        prevbtn_tag = 0;
        
        //テスト用
        /*
        for (int x = 0; x < 10; x++) {
            NSString *itemnumx = [NSString stringWithFormat:@"KEY_item%d",x];
           [ud setBool:YES forKey:itemnumx];
            [ud synchronize];
        }
         */

        
        //背景
        UIImage *hannari_i = [UIImage imageNamed:@"seika_bk"];
        UIImageView *hannari1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [hannari1 setImage:hannari_i];
        [self addSubview:hannari1];
        
        UIImage *back_btn_i = [UIImage imageNamed:@"modoru.png"];
        back_btn = [[UIButton alloc] initWithFrame:CGRectMake(120+chosei_w, 380+chosei_h*3/5, 480*1/5, 620/5)];
        [back_btn setBackgroundImage:back_btn_i forState:UIControlStateNormal];
        [back_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [back_btn addTarget:self action:@selector(onSendButton:) forControlEvents:UIControlEventTouchUpInside];
        back_btn.tag = 1;
        [self addSubview:back_btn];
        
        
        UIImage *next_btn_i = [UIImage imageNamed:@"te1.png"];
        next_btn = [[UIButton alloc] initWithFrame:CGRectMake(220+chosei_w, 380+chosei_h*3/5, 80, 100)];
        [next_btn setBackgroundImage:next_btn_i forState:UIControlStateNormal];
        [next_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [next_btn addTarget:self action:@selector(nextBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        next_btn.tag = 11;
        [self addSubview:next_btn];
        
        
        UIImage *prev_btn_i = [UIImage imageNamed:@"te2.png"];
        prev_btn = [[UIButton alloc] initWithFrame:CGRectMake(20+chosei_w, 380+chosei_h*3/5, 80, 100)];
        [prev_btn setBackgroundImage:prev_btn_i forState:UIControlStateNormal];
        [prev_btn addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [prev_btn addTarget:self action:@selector(preBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        prev_btn.tag = 12;
        [self addSubview:prev_btn];
        
        
        //アイテムグループ１
        item_group1_v = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 260, 330)];
        //item_group1_v.backgroundColor = [UIColor redColor];
        [self addSubview:item_group1_v];
        
        UIImage *item_bk1 = [UIImage imageNamed:@"item_group1"];
        UIImageView *item_bk1_v = [[UIImageView alloc]initWithFrame:CGRectMake(0+chosei_w, 40+chosei_h*3/5, 260, 290)];
        [item_bk1_v setImage:item_bk1];
        [item_group1_v addSubview:item_bk1_v];
        
        //アイテムグループ2
        item_group2_v = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 260, 330)];
        //item_group1_v.backgroundColor = [UIColor redColor];
        [self addSubview:item_group2_v];
        
        UIImage *item_bk2 = [UIImage imageNamed:@"item_group2"];
        UIImageView *item_bk2_v = [[UIImageView alloc]initWithFrame:CGRectMake(0+chosei_w, 40+chosei_h*3/5, 260, 290)];
        [item_bk2_v setImage:item_bk2];
        [item_group2_v addSubview:item_bk2_v];
        item_group2_v.hidden = YES;
        
        //アイテムグループ3
        item_group3_v = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 260, 330)];
        [self addSubview:item_group3_v];
        
        UIImage *item_bk3 = [UIImage imageNamed:@"item_group3"];
        UIImageView *item_bk3_v = [[UIImageView alloc]initWithFrame:CGRectMake(0+chosei_w, 40+chosei_h*3/5, 260, 290)];
        [item_bk3_v setImage:item_bk3];
        [item_group3_v addSubview:item_bk3_v];
        item_group3_v.hidden = YES;
        
//        UIView *seika_view = [[UIImageView alloc]initWithFrame:CGRectMake(30, 70, 260, 290)];
//        //seika_view.backgroundColor = [UIColor redColor];
//        [self addSubview:seika_view];
        
        UIImage *label_bk_i = [UIImage imageNamed:@"gray"];
        UIImageView *label_bk = [[UIImageView alloc]initWithFrame:CGRectMake(10+chosei_w, 60, 300*chosei_size, 40*chosei_size)];
        [label_bk setImage:label_bk_i];
        [self addSubview:label_bk];
        
    //スコア
        UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(10+chosei_w, 60, 300*chosei_size, 40*chosei_size)];
        int omosa_goukei = (int)[ud integerForKey:@"KEY_omosa_goukei"];
        
        NSString *omosa_s = [NSString stringWithFormat:@"持っているお宝の総額 %d 円",omosa_goukei];
        Label1.text = omosa_s;
        Label1.textColor = [UIColor blackColor];
        //Label1.backgroundColor = [UIColor blueColor];
        Label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:Label1];
        
    //アイテム
        /*
        BOOL item0_b = [ud boolForKey:@"KEY_item0"];
        if (item0_b == YES) {
            
            UIImage *seika0_i = [UIImage imageNamed:@"seika_item0.png"];
            UIButton *seika0 = [[UIButton alloc] initWithFrame:CGRectMake(130+chosei_w, 250+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika0 setBackgroundImage:seika0_i forState:UIControlStateNormal];
            [seika0 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika0.tag = 10;
            [self addSubview:seika0];
            
        }
         */
        
        BOOL item1_b = [ud boolForKey:@"KEY_item1"];
        if (item1_b == YES) {
            
        UIImage *seika1_i = [UIImage imageNamed:@"seika_item1.png"];
        UIButton *seika1 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, -20+chosei_h, 80*chosei_size, 130*chosei_size)];
        [seika1 setBackgroundImage:seika1_i forState:UIControlStateNormal];
        [seika1 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [seika1 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
        seika1.tag = 11;
        [item_group1_v addSubview:seika1];
            
        }
        
        else{
            
            UIImage *seika1_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika1 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika1 setBackgroundImage:seika1_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika1];
            
        }
        
        BOOL item2_b = [ud boolForKey:@"KEY_item2"];
        if (item2_b == YES) {
        
        UIImage *seika2_i = [UIImage imageNamed:@"seika_item2.png"];
        UIButton *seika2 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 0+chosei_h, 70*chosei_size, 90*chosei_size)];
        [seika2 setBackgroundImage:seika2_i forState:UIControlStateNormal];
        [seika2 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [seika2 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
        seika2.tag = 12;
        [item_group1_v addSubview:seika2];
        
        }
        
        else{
            
            UIImage *seika2_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika2 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika2 setBackgroundImage:seika2_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika2];
            
        }
        
        BOOL item3_b = [ud boolForKey:@"KEY_item3"];
        if (item3_b == YES) {
            
        UIImage *seika3_i = [UIImage imageNamed:@"seika_item3.png"];
        UIButton *seika3 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 0+chosei_h, 80*chosei_size, 90*chosei_size)];
        [seika3 setBackgroundImage:seika3_i forState:UIControlStateNormal];
        [seika3 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [seika3 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
        seika3.tag = 13;
        [item_group1_v addSubview:seika3];
            
        }
        
        else{
            
            UIImage *seika3_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika3 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika3 setBackgroundImage:seika3_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika3];
            
        }
        
        BOOL item4_b = [ud boolForKey:@"KEY_item4"];
        if (item4_b == YES) {
            
            UIImage *seika4_i = [UIImage imageNamed:@"seika_item4.png"];
            UIButton *seika4 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 70+chosei_h, 80*chosei_size, 80*chosei_size)];
            [seika4 setBackgroundImage:seika4_i forState:UIControlStateNormal];
            [seika4 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika4 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika4.tag = 14;
            [item_group1_v addSubview:seika4];
            
        }
        
        else{
            
            UIImage *seika4_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika4 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika4 setBackgroundImage:seika4_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika4];
            
        }
        
        BOOL item5_b = [ud boolForKey:@"KEY_item5"];
        if (item5_b == YES) {
            
            UIImage *seika5_i = [UIImage imageNamed:@"seika_item5.png"];
            UIButton *seika5 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika5 setBackgroundImage:seika5_i forState:UIControlStateNormal];
            [seika5 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika5 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika5.tag = 15;
            [item_group1_v addSubview:seika5];
            
        }
        
        else{
            
            UIImage *seika5_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika5 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika5 setBackgroundImage:seika5_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika5];
            
        }
        
        BOOL item6_b = [ud boolForKey:@"KEY_item6"];
        if (item6_b == YES) {
            
            UIImage *seika6_i = [UIImage imageNamed:@"seika_item6.png"];
            UIButton *seika6 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 70+chosei_h, 90*chosei_size, 90*chosei_size)];
            [seika6 setBackgroundImage:seika6_i forState:UIControlStateNormal];
            [seika6 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika6 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika6.tag = 16;
            [item_group1_v addSubview:seika6];
            
        }
        
        else{
            
            UIImage *seika6_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika6 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika6 setBackgroundImage:seika6_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika6];
            
        }
        
        BOOL item7_b = [ud boolForKey:@"KEY_item7"];
        if (item7_b == YES) {
            
            UIImage *seika7_i = [UIImage imageNamed:@"seika_item7.png"];
            UIButton *seika7 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika7 setBackgroundImage:seika7_i forState:UIControlStateNormal];
            [seika7 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika7 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika7.tag = 17;
            [item_group1_v addSubview:seika7];
            
        }
        
        else{
            
            UIImage *seika7_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika7 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika7 setBackgroundImage:seika7_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika7];
            
        }
        
        BOOL item8_b = [ud boolForKey:@"KEY_item8"];
        if (item8_b == YES) {
            
            UIImage *seika8_i = [UIImage imageNamed:@"seika_item8.png"];
            UIButton *seika8 = [[UIButton alloc] initWithFrame:CGRectMake(90+chosei_w, 130+chosei_h, 90*chosei_size, 130*chosei_size)];
            [seika8 setBackgroundImage:seika8_i forState:UIControlStateNormal];
            [seika8 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika8 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika8.tag = 18;
            [item_group1_v addSubview:seika8];
            
        }
        
        else{
            
            UIImage *seika8_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika8 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika8 setBackgroundImage:seika8_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika8];
            
        }
        
        BOOL item9_b = [ud boolForKey:@"KEY_item9"];
        if (item9_b == YES) {
            
            UIImage *seika9_i = [UIImage imageNamed:@"seika_item9.png"];
            UIButton *seika9 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika9 setBackgroundImage:seika9_i forState:UIControlStateNormal];
            [seika9 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika9 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika9.tag = 19;
            [item_group1_v addSubview:seika9];
            
        }
        
        else{
            
            UIImage *seika9_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika9 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika9 setBackgroundImage:seika9_i forState:UIControlStateNormal];
            [item_group1_v addSubview:seika9];
            
        }
        
        //2ページ目
        BOOL item21_b = [ud boolForKey:@"KEY_item11"];
        if (item21_b == YES) {
            
            UIImage *seika1_i = [UIImage imageNamed:@"seika_item11.png"];
            UIButton *seika1 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika1 setBackgroundImage:seika1_i forState:UIControlStateNormal];
            [seika1 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika1 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika1.tag = 21;
            [item_group2_v addSubview:seika1];
            
        }
        
        else{
            
            UIImage *seika1_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika1 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika1 setBackgroundImage:seika1_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika1];
            
        }
        
        BOOL item22_b = [ud boolForKey:@"KEY_item12"];
        if (item22_b == YES) {
            
            UIImage *seika2_i = [UIImage imageNamed:@"seika_item12.png"];
            UIButton *seika2 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika2 setBackgroundImage:seika2_i forState:UIControlStateNormal];
            [seika2 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika2 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika2.tag = 2+20;
            [item_group2_v addSubview:seika2];
            
        }
        
        else{
            
            UIImage *seika2_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika2 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika2 setBackgroundImage:seika2_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika2];
            
        }
        
        BOOL item23_b = [ud boolForKey:@"KEY_item13"];
        if (item23_b == YES) {
            
            UIImage *seika3_i = [UIImage imageNamed:@"seika_item13.png"];
            UIButton *seika3 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, -20+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika3 setBackgroundImage:seika3_i forState:UIControlStateNormal];
            [seika3 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika3 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika3.tag = 3+20;
            [item_group2_v addSubview:seika3];
            
        }
        
        else{
            
            UIImage *seika3_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika3 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika3 setBackgroundImage:seika3_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika3];
            
        }
        
        BOOL item24_b = [ud boolForKey:@"KEY_item14"];
        if (item24_b == YES) {
            
            UIImage *seika4_i = [UIImage imageNamed:@"seika_item14.png"];
            UIButton *seika4 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika4 setBackgroundImage:seika4_i forState:UIControlStateNormal];
            [seika4 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika4 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika4.tag = 4+20;
            [item_group2_v addSubview:seika4];
            
        }
        
        else{
            
            UIImage *seika4_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika4 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika4 setBackgroundImage:seika4_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika4];
            
        }
        
        BOOL item25_b = [ud boolForKey:@"KEY_item15"];
        if (item25_b == YES) {
            
            UIImage *seika5_i = [UIImage imageNamed:@"seika_item15.png"];
            UIButton *seika5 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 79+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika5 setBackgroundImage:seika5_i forState:UIControlStateNormal];
            [seika5 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika5 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika5.tag = 5+20;
            [item_group2_v addSubview:seika5];
            
        }
        
        else{
            
            UIImage *seika5_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika5 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika5 setBackgroundImage:seika5_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika5];
            
        }
        
        BOOL item26_b = [ud boolForKey:@"KEY_item16"];
        if (item26_b == YES) {
            
            UIImage *seika6_i = [UIImage imageNamed:@"seika_item16.png"];
            UIButton *seika6 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 70+chosei_h, 80*chosei_size, 80*chosei_size)];
            [seika6 setBackgroundImage:seika6_i forState:UIControlStateNormal];
            [seika6 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika6 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika6.tag = 6+20;
            [item_group2_v addSubview:seika6];
            
        }
        
        else{
            
            UIImage *seika6_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika6 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika6 setBackgroundImage:seika6_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika6];
            
        }
        
        BOOL item27_b = [ud boolForKey:@"KEY_item17"];
        if (item27_b == YES) {
            
            UIImage *seika7_i = [UIImage imageNamed:@"seika_item17.png"];
            UIButton *seika7 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 150+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika7 setBackgroundImage:seika7_i forState:UIControlStateNormal];
            [seika7 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika7 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika7.tag = 7+20;
            [item_group2_v addSubview:seika7];
            
        }
        
        else{
            
            UIImage *seika7_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika7 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika7 setBackgroundImage:seika7_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika7];
            
        }
        
        BOOL item28_b = [ud boolForKey:@"KEY_item18"];
        if (item28_b == YES) {
            
            UIImage *seika8_i = [UIImage imageNamed:@"seika_item18.png"];
            UIButton *seika8 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 150+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika8 setBackgroundImage:seika8_i forState:UIControlStateNormal];
            [seika8 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika8 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika8.tag = 8+20;
            [item_group2_v addSubview:seika8];
            
        }
        
        else{
            
            UIImage *seika8_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika8 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika8 setBackgroundImage:seika8_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika8];
            
        }
        
        BOOL item29_b = [ud boolForKey:@"KEY_item19"];
        if (item29_b == YES) {
            
            UIImage *seika9_i = [UIImage imageNamed:@"seika_item19.png"];
            UIButton *seika9 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 150+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika9 setBackgroundImage:seika9_i forState:UIControlStateNormal];
            [seika9 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika9 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika9.tag = 9+20;
            [item_group2_v addSubview:seika9];
            
        }
        
        else{
            
            UIImage *seika9_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika9 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika9 setBackgroundImage:seika9_i forState:UIControlStateNormal];
            [item_group2_v addSubview:seika9];
            
        }
        
        //3ページ目
        BOOL item31_b = [ud boolForKey:@"KEY_item21"];
        if (item31_b == YES) {
            
            UIImage *seika1_i = [UIImage imageNamed:@"seika_item21.png"];
            UIButton *seika1 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika1 setBackgroundImage:seika1_i forState:UIControlStateNormal];
            [seika1 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika1 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika1.tag = 31;
            [item_group3_v addSubview:seika1];
            
        }
        
        else{
            
            UIImage *seika1_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika1 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika1 setBackgroundImage:seika1_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika1];
            
        }
        
        BOOL item32_b = [ud boolForKey:@"KEY_item22"];
        if (item32_b == YES) {
            
            UIImage *seika2_i = [UIImage imageNamed:@"seika_item22.png"];
            UIButton *seika2 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, -15+chosei_h, 75*chosei_size, 95*chosei_size)];
            [seika2 setBackgroundImage:seika2_i forState:UIControlStateNormal];
            [seika2 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika2 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika2.tag = 2+30;
            [item_group3_v addSubview:seika2];
            
        }
        
        else{
            
            UIImage *seika2_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika2 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika2 setBackgroundImage:seika2_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika2];
            
        }
        
        BOOL item33_b = [ud boolForKey:@"KEY_item23"];
        if (item33_b == YES) {
            
            UIImage *seika3_i = [UIImage imageNamed:@"seika_item23.png"];
            UIButton *seika3 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika3 setBackgroundImage:seika3_i forState:UIControlStateNormal];
            [seika3 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika3 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika3.tag = 3+30;
            [item_group3_v addSubview:seika3];
            
        }
        
        else{
            
            UIImage *seika3_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika3 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, -10+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika3 setBackgroundImage:seika3_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika3];
            
        }
        
        BOOL item34_b = [ud boolForKey:@"KEY_item24"];
        if (item34_b == YES) {
            
            UIImage *seika4_i = [UIImage imageNamed:@"seika_item24.png"];
            UIButton *seika4 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika4 setBackgroundImage:seika4_i forState:UIControlStateNormal];
            [seika4 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika4 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika4.tag = 4+30;
            [item_group3_v addSubview:seika4];
            
        }
        else{
        
        UIImage *seika4_i = [UIImage imageNamed:@"hatena.png"];
        UIButton *seika4 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
        [seika4 setBackgroundImage:seika4_i forState:UIControlStateNormal];
        [item_group3_v addSubview:seika4];
        
        }
    
        BOOL item35_b = [ud boolForKey:@"KEY_item25"];
        if (item35_b == YES) {
            
            UIImage *seika5_i = [UIImage imageNamed:@"seika_item25.png"];
            UIButton *seika5 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika5 setBackgroundImage:seika5_i forState:UIControlStateNormal];
            [seika5 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika5 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika5.tag = 5+30;
            [item_group3_v addSubview:seika5];
            
        }
        
        else{
            
            UIImage *seika5_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika5 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika5 setBackgroundImage:seika5_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika5];
            
        }
        
        BOOL item36_b = [ud boolForKey:@"KEY_item26"];
        if (item36_b == YES) {
            
            UIImage *seika6_i = [UIImage imageNamed:@"seika_item26.png"];
            UIButton *seika6 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika6 setBackgroundImage:seika6_i forState:UIControlStateNormal];
            [seika6 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika6 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika6.tag = 6+30;
            [item_group3_v addSubview:seika6];
            
        }
        
        else{
            
            UIImage *seika6_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika6 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 70+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika6 setBackgroundImage:seika6_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika6];
            
        }
        
        BOOL item37_b = [ud boolForKey:@"KEY_item27"];
        if (item37_b == YES) {
            
            UIImage *seika7_i = [UIImage imageNamed:@"seika_item27.png"];
            UIButton *seika7 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika7 setBackgroundImage:seika7_i forState:UIControlStateNormal];
            [seika7 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika7 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika7.tag = 7+30;
            [item_group3_v addSubview:seika7];
            
        }
        
        else{
            
            UIImage *seika7_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika7 = [[UIButton alloc] initWithFrame:CGRectMake(10+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika7 setBackgroundImage:seika7_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika7];
            
        }
        
        BOOL item38_b = [ud boolForKey:@"KEY_item28"];
        if (item38_b == YES) {
            
            UIImage *seika8_i = [UIImage imageNamed:@"seika_item28.png"];
            UIButton *seika8 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika8 setBackgroundImage:seika8_i forState:UIControlStateNormal];
            [seika8 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika8 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika8.tag = 8+30;
            [item_group3_v addSubview:seika8];
            
        }
        
        else{
            
            UIImage *seika8_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika8 = [[UIButton alloc] initWithFrame:CGRectMake(100+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika8 setBackgroundImage:seika8_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika8];
            
        }
        
        BOOL item39_b = [ud boolForKey:@"KEY_item29"];
        if (item39_b == YES) {
            
            UIImage *seika9_i = [UIImage imageNamed:@"seika_item29.png"];
            UIButton *seika9 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika9 setBackgroundImage:seika9_i forState:UIControlStateNormal];
            [seika9 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            [seika9 addTarget:self action:@selector(shosai_hyoji:) forControlEvents:UIControlEventTouchUpInside];
            seika9.tag = 9+30;
            [item_group3_v addSubview:seika9];
            
        }
        else{
            
            UIImage *seika9_i = [UIImage imageNamed:@"hatena.png"];
            UIButton *seika9 = [[UIButton alloc] initWithFrame:CGRectMake(180+chosei_w, 140+chosei_h, 80*chosei_size, 100*chosei_size)];
            [seika9 setBackgroundImage:seika9_i forState:UIControlStateNormal];
            [item_group3_v addSubview:seika9];
            
        }



    //詳細画面
        
        UIImage *view_bk_i = [UIImage imageNamed:@"waku2"];
        view_bk = [[UIImageView alloc]initWithFrame:CGRectMake(8, 150, 300, 350)];
        [view_bk setImage:view_bk_i];
        [self addSubview:view_bk];
        view_bk.hidden = YES;
        
        UIImage *back_btn2_i = [UIImage imageNamed:@"tojiru1.png"];
        back_btn2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 420, 80, 40)];
        [back_btn2 setBackgroundImage:back_btn2_i forState:UIControlStateNormal];
        [back_btn2 addTarget:self action:@selector(soundBtn_click:) forControlEvents:UIControlEventTouchUpInside];
        [back_btn2 addTarget:self action:@selector(shosai_hi_hyoji) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:back_btn2];
        back_btn2.hidden = YES;
        

        
        
    }
    return self;
}

-(void)shosai_hyoji:(id)sender{
    
if(shosai_hyoji_b == NO){
    
    back_btn.userInteractionEnabled = NO;
    next_btn.userInteractionEnabled = NO;
    prev_btn.userInteractionEnabled = NO;
    
    view_bk.hidden = NO;
    back_btn2.hidden = NO;
    
    for (int x=1; x<=9; x++) {
        
        
        
    }
    
    //sender経由でボタンを取得
    UIButton *button = (UIButton *)sender;
    //tagにセットしていた引数を格納
    NSLog(@"%d", (int)button.tag);
    
    NSString* strA = [NSString stringWithFormat : @"%d", (int)button.tag];
    NSDictionary *dict = [DataControl getRyouri:strA];
    
    //名前
    lName = [[UILabel alloc] initWithFrame:CGRectMake(50, 160, 200, 40)];
    lName.text = [dict objectForKey:@"name"];
    lName.textAlignment = NSTextAlignmentCenter;
    //NSLog(@"%@",lName.text);
    
    //lName.backgroundColor = [UIColor blueColor];
    
    [self addSubview:lName];
    
    //詳細
    lDetail = [[UILabel alloc] initWithFrame:CGRectMake(50, 260, 220, 200)];
    lDetail.text = [dict objectForKey:@"detail"];
    lDetail.numberOfLines = 4;
    lName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lDetail];
    
    //画像
    NSString *lImage_name = [dict objectForKey:@"Image_name"];
    NSString *x_length = [dict objectForKey:@"x_l"];
    NSString *y_length = [dict objectForKey:@"y_l"];
    int x_leng = [x_length intValue];
    int y_leng = [y_length intValue];
    image_inShosai = [[UIImageView alloc] initWithFrame:CGRectMake(70, 190, x_leng*18, y_leng*18)];
    UIImage *image_is = [UIImage imageNamed:lImage_name];
    [image_inShosai setImage:image_is];
    [self addSubview:image_inShosai];
        
    }
    
    shosai_hyoji_b = YES;
    
}

-(void)shosai_hi_hyoji{
    
    view_bk.hidden = YES;
    back_btn2.hidden = YES;
    lName.hidden = YES;
    lDetail.hidden = YES;
    image_inShosai.hidden = YES;
    
    shosai_hyoji_b = NO;
    
    back_btn.userInteractionEnabled = YES;
    next_btn.userInteractionEnabled = YES;
    prev_btn.userInteractionEnabled = YES;
}

- (void)soundBtn_click:(id)sender{
    
    BOOL oto_onoff = [ud boolForKey:@"KEY_oto"];
    
    if (oto_onoff == YES) {
    
    AudioServicesPlaySystemSound(sound_click1);
    
    }
}

-(void)nextBtn_click:(id)sender{
    
    if (nextbtn_tag == 2) {
       
        item_group1_v.hidden = YES;
        item_group2_v.hidden = NO;
        
        nextbtn_tag++;
        prevbtn_tag++;

        
    }
    else if(nextbtn_tag == 3){
        
        item_group2_v.hidden = YES;
        item_group3_v.hidden = NO;
        
        nextbtn_tag++;
        prevbtn_tag++;
        

    }

}

-(void)preBtn_click:(id)sender{
    
    if (prevbtn_tag == 1) {
        
        item_group1_v.hidden = NO;
        item_group2_v.hidden = YES;
        
        nextbtn_tag--;
        prevbtn_tag--;
        
    
    }
    else if (prevbtn_tag == 2){
        
        item_group2_v.hidden = NO;
        item_group3_v.hidden = YES;
        
        nextbtn_tag--;
        prevbtn_tag--;
        
        
    }
    

    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
