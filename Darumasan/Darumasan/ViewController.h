//
//  ViewController.h
//  Sample
//
//  Created by MACM001 on 2014/08/05.
//  Copyright (c) 2014年 MACM001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Social/Social.h>
#import "ADGManagerViewController.h"

@interface ViewController : UIViewController<ADGManagerViewControllerDelegate>
{
    CGRect showViewRect;
    ADGManagerViewController *adg_; //手順2
}
@property AVAudioPlayer *sound_bgm1;
@property (nonatomic, retain) ADGManagerViewController *adg;

@end
