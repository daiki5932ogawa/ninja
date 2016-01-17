//
//  PRView.h
//  Darumasan
//
//  Created by 小川大暉 on 2015/01/10.
//  Copyright (c) 2015年 DaikiOgawa. All rights reserved.
//

#import "RootView.h"
#import "ADGManagerViewController.h"

@interface PRView : RootView<ADGManagerViewControllerDelegate>
{
    
    ADGManagerViewController *adg2_;
}


@property (nonatomic, retain) ADGManagerViewController *adg2;

@end
