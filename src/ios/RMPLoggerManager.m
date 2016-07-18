#import <UIKit/UIKit.h>
#import "RMPLoggerManager.h"
#import <ROKOMobi/ROKOMobi.h>


@interface RMPLoggerManager () {
}
@end

@implementation RMPLoggerManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)addEvent:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSDictionary *params = command.arguments.count == 2 ? command.arguments[1] : nil;
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failed"];
        
        if (params && params[@"name"]) {
            NSString *eventName = params[@"name"];
            NSDictionary *parameters = [self dictionaryValue:params forKey:@"params"];
            [[ROKOLogger sharedLogger] addEvent:eventName withParameters:parameters];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Done"];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
    }
}

@end
