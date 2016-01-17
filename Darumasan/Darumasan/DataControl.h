//
//  DataControl.h
//  orekano
//
//  Created by MACM001 on 2014/09/16.
//  Copyright (c) 2014年 CCW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootView.h"

@interface DataControl : RootView

+ (void)initializeData;
+ (NSDictionary *)getRyouri:(NSString *)rid;

@end
