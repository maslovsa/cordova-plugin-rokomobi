#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPPromoManager : RMPHelper

- (void)loadPromo:(CDVInvokedUrlCommand *)command;
- (void)markPromoCodeAsUsed:(CDVInvokedUrlCommand *)command;
- (void)loadUserPromoCodes:(CDVInvokedUrlCommand *)command;

@end
