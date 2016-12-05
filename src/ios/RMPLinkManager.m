#import <UIKit/UIKit.h>
#import "RMPLinkManager.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOLink+ROKOLinkMapper.h"

NSString *const kNameKey = @"name";
NSString *const kTypeKey = @"type";
NSString *const kSourceURLKey = @"sourceURL";
NSString *const kChannelNameKey = @"channelName";
NSString *const kSharingCodeKey = @"sharingCode";
NSString *const kAdvancedSettingsKey = @"advancedSettings";

NSString *const kLinkURLKey = @"linkURL";
NSString *const kLinkIdKey = @"linkId";

@interface RMPLinkManager () <ROKOLinkManagerDelegate> {
    ROKOLinkManager *_linkManager;
}
@end

@implementation RMPLinkManager

- (void)pluginInitialize {
    [super pluginInitialize];
    _linkManager = [[ROKOLinkManager alloc] init];
}

- (void)handleDeepLink:(CDVInvokedUrlCommand *)command {
    [self parseCommand:command];
    NSString *link = command.arguments[0];
    
    if (link) {
        NSURL *nsurl = [[NSURL alloc] initWithString:link];
        
        if (nsurl) {
            _linkManager.delegate = self;
            [_linkManager handleDeepLink:nsurl];
        }
    }
}

- (void)createLink:(CDVInvokedUrlCommand *)command {
    [self parseCommand:command];
    NSDictionary *params = command.arguments[0];

    if (params) {
        _linkManager.delegate = self;
        __weak __typeof__(self) weakSelf = self;
        
        ROKOLinkType linkType = [params[kTypeKey] intValue];
        NSString *sourceURL = params[kSourceURLKey];
        if (sourceURL == (NSString *)[NSNull null] ) {
            sourceURL = nil;
        }

        NSString *channelName = params[kChannelNameKey];
        if (channelName == (NSString *)[NSNull null] ) {
            channelName = nil;
        }
        
        NSString *sharingCode = params[kSharingCodeKey];
        if (sharingCode == (NSString *)[NSNull null] ) {
            sharingCode = nil;
        }
        
        NSDictionary *advancedSettings = params[kAdvancedSettingsKey];
        
        [_linkManager createLinkWithName:params[kNameKey]
         type: linkType
         sourceURL: sourceURL
         channelName: channelName
         sharingCode: sharingCode
         advancedSettings: advancedSettings
         completionBlock:^(NSString *_Nullable linkURL, NSNumber *_Nullable linkId, NSError *_Nullable error) {
            if (error) {
                [weakSelf handleError:error];
            } else {
                NSMutableDictionary *dictionary = [NSMutableDictionary new];
                
                if (linkURL) {
                    dictionary[kLinkURLKey] = linkURL;
                }
                
                if (linkId) {
                    dictionary[kLinkIdKey] = linkId;
                }
                
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictionary];
                [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
            }
        }];
    }

}

- (void)linkManager:(nonnull ROKOLinkManager *)manager didOpenDeepLink:(nonnull ROKOLink *)link {
    NSDictionary *representation = [EKSerializer serializeObject:link withMapping:[ROKOLink objectMapping]];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
    
}

- (void)linkManager:(nonnull ROKOLinkManager *)manager didFailToOpenDeepLinkWithError:(nullable NSError *)error {
    [self handleError:error];
}

@end
