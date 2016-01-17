//
//  RootView.m
//  MatomeSpotting
//

#import "RootView.h"


@implementation RootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor blackColor];
        
        self.screenHeight = frame.size.height;
        self.deviceScreenHeight = 0;
        self.headerHeight = 0;
        self.subHeight = 0;
        self.scaleHeight = [[UIScreen mainScreen] bounds].size.height / 480.0f;
        self.addHeight = (int)([[UIScreen mainScreen] bounds].size.height / 568.0f);
        
        if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7){
            CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
            self.deviceScreenHeight = [[UIScreen mainScreen] bounds].size.height - statusBarViewRect.size.height;
            self.headerHeight = statusBarViewRect.size.height;
            self.subHeight = 0;
        }
        else{
            self.deviceScreenHeight = [[UIScreen mainScreen] bounds].size.height;
            self.headerHeight = 0;
            self.subHeight = 20;
        }
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame controller:(ViewController *)vc{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor blackColor];
        
        self.viewController = vc;
        
        self.screenHeight = frame.size.height;
        self.deviceScreenHeight = 0;
        self.headerHeight = 0;
        self.subHeight = 0;
        self.scaleHeight = [[UIScreen mainScreen] bounds].size.height / 480.0f;
        self.addHeight = (int)([[UIScreen mainScreen] bounds].size.height / 568.0f);
        
        if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7){
            CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
            self.deviceScreenHeight = [[UIScreen mainScreen] bounds].size.height - statusBarViewRect.size.height;
            self.headerHeight = statusBarViewRect.size.height;
            self.subHeight = 0;
        }
        else{
            self.deviceScreenHeight = [[UIScreen mainScreen] bounds].size.height;
            self.headerHeight = 0;
            self.subHeight = 20;
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)removeView
{
    
}

- (void)changeTime
{
    
}

- (IBAction)onSendButton:(id)sender
{
    UIButton *btn = sender;
    self.touchView = btn.tag;
    [[UIApplication sharedApplication] sendAction:self->action to:self->target from:self forEvent:nil];
}

- (void)addTarget:(id)targetP action:(SEL)actionP
{
    self->target = targetP;
    self->action = actionP;
}

@end
