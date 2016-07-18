#import <UIKit/UIKit.h>
#import "RMPShareManager.h"
#import <ROKOMobi/ROKOMobi.h>
#import <ROKOMobi/ROKOShareViewController.h>

@interface RMPShareManager () <ROKOShareDelegate> {

}
@end

@implementation RMPShareManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)share:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSDictionary *params = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (params) {
            ROKOShareViewController *controller = [ROKOShareViewController buildControllerWithContentId:[[NSUUID UUID] UUIDString]];
            ROKOShare *shareManager = controller.shareManager;
            shareManager.delegate = self;
            
            if (params[@"displayMessage"]) {
                controller.displayMessage = params[@"displayMessage"];
            }
            
            if (params[@"text"]) {
                shareManager.text = params[@"text"];
            }
            
            if (params[@"contentTitle"]) {
                shareManager.contentTitle = params[@"contentTitle"];
            }
            
            id url = params[@"contentURL"];
            
            if (url && url != [NSNull null] && [url isKindOfClass:[NSURL class]]) {
                shareManager.contentURL = params[@"contentURL"];
            }
            
            if (params[@"ShareChannelTypeFacebook"]) {
                [shareManager setText:params[@"ShareChannelTypeFacebook"] forShareChannel:ROKOShareChannelTypeFacebook];
            }
            
            if (params[@"ShareChannelTypeTwitter"]) {
                [shareManager setText:params[@"ShareChannelTypeTwitter"] forShareChannel:ROKOShareChannelTypeTwitter];
            }
            
            if (params[@"ShareChannelTypeMessage"]) {
                [shareManager setText:params[@"ShareChannelTypeMessage"] forShareChannel:ROKOShareChannelTypeMessage];
            }
            
            [self.viewController presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (void)shareWithChannelType:(CDVInvokedUrlCommand *)command {

}

- (void)shareManager:(ROKOShare *)manager didFinishWithActivityType:(ROKOShareChannelType)activityType result:(ROKOSharingResult)result {
    CDVPluginResult *pluginResult = nil;
    
    switch (result) {
    case ROKOSharingResultDone:
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Done"];
        break;
        
    case ROKOSharingResultCancelled:
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Canceled"];
        break;
        
    case ROKOSharingResultFailed:
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failed"];
        break;
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
}

- (void)shareManager:(ROKOShare *)shareManager willApplyScheme:(ROKOShareScheme *)scheme {

}

- (void)shareManager:(ROKOShare *)shareManager willShowSharingMessageComposer:(id)messageComposer forShareChannelType:(ROKOShareChannelType)channelType {

}

@end
