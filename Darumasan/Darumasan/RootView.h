//
//  RootView.h
//  MatomeSpotting
//

#import <UIKit/UIKit.h>
//#import "ADGManagerViewController.h"
//#import "SoundButton.h"

@class ViewController;

@protocol OriViewDalegate <NSObject>

- (void)showIndicator;
- (void)hiddenIndicator;

@end

@interface RootView : UIView{
    @protected
    id target;
    SEL action;
}

@property(nonatomic ,assign) id<OriViewDalegate> delegate;
@property(nonatomic, retain) ViewController *viewController;
@property(nonatomic, retain) NSUserDefaults *userDefaults;
@property(nonatomic, retain) UIImageView *ivBack;
@property(nonatomic) float screenHeight;
@property(nonatomic) float deviceScreenHeight;
@property(nonatomic) float headerHeight;
@property(nonatomic) float subHeight;
@property(nonatomic) float scaleHeight;
@property(nonatomic) int addHeight;
@property(nonatomic) int touchView;

- (id)initWithFrame:(CGRect)frame controller:(ViewController *)vc;

- (void)removeView;
- (void)changeTime;
- (IBAction)onSendButton:(id)sender;
- (void)addTarget:(id)targetP action:(SEL)actionP;

@end
