//
//  RMPHelper.m
//  HelloRoko
//
//  Created by Maslov Sergey on 15.04.16.
//
//

#import "RMPHelper.h"
#import <ROKOMobi/ROKOMobi.h>

NSString *const kRokoErrorBadCredentals = @"Bad RokoMobi apiToken/basURL";
NSString *const kBaseURLKey = @"baseURL";
NSString *const kApiTokenKey = @"apiToken";

@implementation RMPHelper

- (BOOL)parseCommand:(CDVInvokedUrlCommand *)command {
    self.command = command;
    
    if ([command arguments].count > 1) {
        NSDictionary *settings = [command arguments][0];
        
        NSString *baseURL = settings[kBaseURLKey];
        NSString *apiToken = settings[kApiTokenKey];
        
        if (baseURL && apiToken) {
            [ROKOComponentManager sharedManager].apiToken = apiToken;
            [ROKOComponentManager sharedManager].baseURL = baseURL;
            return YES;
        }
    }
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:kRokoErrorBadCredentals];
    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
    return NO;
}

- (ROKOLinkType)numberToROKOLinkType:(NSNumber *)linkType {
    if (!linkType) {
        return ROKOLinkTypeManual;
    }
    
    if ([linkType intValue] > ROKOLinkTypeShare) {
        return ROKOLinkTypeManual;
    }
    
    return [linkType intValue];
}

- (NSDictionary *)dictionaryValue:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSDictionary *value = [dictionary valueForKey:key];
    if (![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return value;
}

- (void)handleError:(NSError *)error {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
    NSLog(@"%@", error.description);
    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
}
@end
