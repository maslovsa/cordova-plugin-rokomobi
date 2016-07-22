#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPPushManager : RMPHelper

- (void)promoCodeFromNotification:(CDVInvokedUrlCommand *)command;

@end
