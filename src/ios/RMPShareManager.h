#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPShareManager : RMPHelper

- (void)share:(CDVInvokedUrlCommand *)command;
- (void)shareWithUI:(CDVInvokedUrlCommand *)command;
- (void)shareWithChannelType:(CDVInvokedUrlCommand *)command;

@end
