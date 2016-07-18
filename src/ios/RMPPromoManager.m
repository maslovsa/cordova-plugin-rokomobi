#import <UIKit/UIKit.h>
#import "RMPPromoManager.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOPromoDiscountItem+ROKOPromoDiscountItemMapper.h"

NSString *const kPromoCodeKey = @"promoCode";
NSString *const kValueOfPurchaseKey = @"valueOfPurchase";
NSString *const kValueOfDiscountKey = @"valueOfDiscount";
NSString *const kDeliveryTypeKey = @"deliveryType";

@interface RMPPromoManager () {

}
@end

@implementation RMPPromoManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)loadPromo:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSString *promoCode = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (promoCode) {
            NSLog(@"load Promocode - %@", promoCode);
            ROKOPromo *promo = [[ROKOPromo alloc] init];
            __weak __typeof__(self) weakSelf = self;
            
            [promo loadPromoDiscountWithPromoCode:promoCode completionBlock:^(ROKOPromoDiscountItem *discount, NSError *error) {
                if (error) {
                    [weakSelf handleError:error];
                } else {
                    NSDictionary *representation = [EKSerializer serializeObject:discount withMapping:[ROKOPromoDiscountItem objectMapping]];
                    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
                    [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                }
            }];
        }
    }
}

- (void)markPromoCodeAsUsed:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSDictionary *params = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (params) {
            __weak __typeof__(self) weakSelf = self;
            
            NSString *promoCode = params[kPromoCodeKey];
            NSNumber *valueOfPurchase = params[kValueOfPurchaseKey];
            NSNumber *valueOfDiscount = params[kValueOfDiscountKey];
            NSNumber *deliveryType = params[kDeliveryTypeKey];
            
            ROKOPromo *promo = [[ROKOPromo alloc] init];
            
            if (promoCode) {
                [promo markPromoCodeAsUsed:promoCode valueOfPurchase:valueOfPurchase valueOfDiscount:valueOfDiscount deliveryType:[deliveryType intValue] completionBlock:^(NSError *error) {
                    if (error) {
                        [weakSelf handleError:error];
                    } else {
                        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
                        [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                    }
                }];
            }
        }
    }
}

@end
