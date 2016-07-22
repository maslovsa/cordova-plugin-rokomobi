#import <UIKit/UIKit.h>
#import "RMPPushManager.h"
#import <ROKOMobi/ROKOMobi.h>


@interface RMPPushManager () {
}
@end

@implementation RMPPushManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)promoCodeFromNotification:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSString *jsonString = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (jsonString) {
            NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json) {
                ROKOPush *push = [[ROKOPush alloc] init];
                NSString *promoCode = [push promoCodeFromNotification: json];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: promoCode];
                [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
            } else {
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Bad JSON Parsing"];
                [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
            }
        } else {
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Bad Param"];
            [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
        }
    }
}
@end
