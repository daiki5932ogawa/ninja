//
//  MainView.h
//  Sample
//
//  Created by MACM001 on 2014/08/05.
//  Copyright (c) 2014年 MACM001. All rights reserved.
//

#import "RootView.h"
#import <AVFoundation/AVFoundation.h>



@interface MainView : RootView

@property AVAudioPlayer *sound_bgm1;

-(void)execMain;

-(void)tairyoku_hyoji;

-(void)sound_stop;

-(void)sound_play;

@end
