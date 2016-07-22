var RokoMobiSettings = {baseURL: "rmsws.qa.rokolabs.com/external/v1", 
apiToken: "weNVx82HThJ4OO7arNtbUfeahnM8bWMsQhm+jfzwH6o="};



module.exports = {
    // Param - link, Success - "name", "createDate", "updateDate", "shareChannel", "vanityLink", "customDomainLink", "type"(ROKOLinkType), "referralCode", "promo" 
    handleDeepLink: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "LinkManager", "handleDeepLink", [settings || RokoMobiSettings, param]);
    },
    // Param - "name", "type"(ROKOLinkType), "sourceURL", "channelName", "sharingCode", "advancedSettings", Success - "linkURL", "linkId"
    createLink: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "LinkManager", "createLink", [settings || RokoMobiSettings, param]);
    },
    // Param - "displayMessage", "text", "contentTitle", "contentURL", "ShareChannelTypeFacebook" (and other text fo different Sharing Types)
    share: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ShareManager", "share", [settings || RokoMobiSettings, param]);
    },
    // Param - "displayMessage", "text", "contentTitle", "contentURL", "ShareChannelTypeFacebook" (and other text fo different Sharing Types)
    shareWithUI: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ShareManager", "shareWithUI", [settings || RokoMobiSettings, param]);
    },
    // Param - "name", "params"-Dictionary
    addEvent: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "LoggerManager", "addEvent", [settings || RokoMobiSettings, param]);
    },
    // Param - promoCode, Success - array of objects: "applicability", "startDate", "endDate", "isAlwaysActive", "isSingleUseOnly", "autoApplyOnAppOpen", "cannotBeCombined"
    loadPromo: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PromoManager", "loadPromo", [settings || RokoMobiSettings, param]);
    },
    // Param - promoCode, OPTIONAL: "valueOfPurchase", "valueOfDiscount", deliveryType(ROKOPromoDeliveryType)
    markPromoCodeAsUsed: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PromoManager", "markPromoCodeAsUsed", [settings || RokoMobiSettings, param]);
    },    
    // Param - Empty, Success - array of objects: "createDate", "updateDate", "value", "limit", "type", "canBeUsed"
    loadReferralDiscountsList: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "loadReferralDiscountsList", [settings || RokoMobiSettings, param]);
    },
    // Param - discountId
    markReferralDiscountAsUsed: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "markReferralDiscountAsUsed", [settings || RokoMobiSettings, param]);
    },
    // Param - "code", Success - "active", "name", "recipientDiscount"-Dictionary, "rewardDiscount"-Dictionary
    loadDiscountInfoWithCode: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "loadDiscountInfoWithCode", [settings || RokoMobiSettings, param]);
    },
    // Param - "code", Success - discountId
    activateDiscountWithCode: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "activateDiscountWithCode", [settings || RokoMobiSettings, param]);
    },
    // Param - "code", Sucess - "discountId", "referrerId"
    completeDiscountWithCode: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "completeDiscountWithCode", [settings || RokoMobiSettings, param]);
    },
    // Param - "userName", "password"
    login: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "login", [settings || RokoMobiSettings, param]);
    },
    // Param - "userName", OPTIONAL: "referralCode", "shareChannel"
    setUser: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "setUser", [settings || RokoMobiSettings, param]);
    },
    // Param - Empty
    logout: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "logout", [settings || RokoMobiSettings, param]);
    },// Param - "userName", "email", "password", OPTIONAL: "ambassadorCode", "linkShareChannel"
    signupUser: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "signupUser", [settings || RokoMobiSettings, param]);
    },
    // Param - Empty, Success - ["version", "applicationName"]
    getPortalInfo: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "getPortalInfo", [settings || RokoMobiSettings, param]);
    },
    // Param - Empty, Success - ["sessionKey", "expirationDate", "expirationDate", "user"-Dictionary]
    getSessionInfo: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "getSessionInfo", [settings || RokoMobiSettings, param]);
    },
    // Param - Empty, Success - ["objectId", "createDate", "email", "firstLoginTime", "lastLoginTime", "phone", "photoFile", "referralCode", "updateDate", "username"
    getUserInfo: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "getUserInfo", [settings || RokoMobiSettings, param]);
    },
    // Param - Sring of push data, Success - promoCode
    promoCodeFromNotification: function (param, successCallback, errorCallback, settings) {
        cordova.exec(successCallback, errorCallback, "PushManager", "promoCodeFromNotification", [settings || RokoMobiSettings, param]);
    },
    ROKOLinkType: {
        ROKOLinkTypeManual: 0,
        ROKOLinkTypePromo: 1,
        ROKOLinkTypeReferral: 2,
        ROKOLinkTypeShare: 3
    },
    ROKOPromoDeliveryType: {
        ROKOPromoDeliveryTypeUnknown: 0,
        ROKOPromoDeliveryTypePush: 1,
        ROKOPromoDeliveryTypeEvent: 2,
        ROKOPromoDeliveryTypeLink: 3
    }
};


