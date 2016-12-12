//
//  ROKOPromoCodeListItem+ROKOPromoCodeListItemMapper.m
//  HelloCordova
//
//  Created by Maslov Sergey on 12.12.16.
//
//

#import "ROKOPromoCodeListItem+ROKOPromoCodeListItemMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOPromoCodeListItem (ROKOPromoCodeListItemMapper)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
    [mapping mapPropertiesFromArray:@[@"promoCode"]];
    [mapping hasOne:[ROKOPromoDiscountItem class] forKeyPath:@"discountItem"];
  }];
}

@end
