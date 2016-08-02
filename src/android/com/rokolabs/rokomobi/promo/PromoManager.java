package com.rokolabs.rokomobi.promo;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.sdk.RokoMobi;
import com.rokolabs.sdk.promo.ResponsePromo;
import com.rokolabs.sdk.promo.RokoPromo;
import com.rokolabs.sdk.promo.RokoPromoDeliveryType;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class PromoManager extends BasePlugin {
    private static final String loadPromo = "loadPromo";
    private static final String markPromoCodeAsUsed = "markPromoCodeAsUsed";
    private static final String promoCodeFromNotification = "promoCodeFromNotification";

    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (loadPromo.equals(action)) {
            try {
                String promoCode = args.getString(0);
                RokoPromo.loadPromoDiscountWithPromoCode(promoCode, new RokoPromo.CallbackDiscountLoaded() {
                    @Override
                    public void success(ResponsePromo responsePromo) {
                        callbackContext.success(gson.toJson(responsePromo.data));
                    }

                    @Override
                    public void failure(ResponsePromo responsePromo) {
                        callbackContext.error("Promo code not found");
                    }
                });
            } catch (JSONException e) {
                e.printStackTrace();
            }
            return true;
        }
        if (markPromoCodeAsUsed.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        MarkPromoCodeAsUsed model = gson.fromJson(args.getJSONObject(0).toString(), MarkPromoCodeAsUsed.class);
                        RokoPromoDeliveryType type = RokoPromoDeliveryType.UNKNOWN;
                        switch (model.deliveryType) {
                            case 1:
                                type = RokoPromoDeliveryType.PUSH;
                                break;
                            case 2:
                                type = RokoPromoDeliveryType.EVENT;
                                break;
                            case 3:
                                type = RokoPromoDeliveryType.LINK;
                                break;

                        }

                        RokoPromo.markPromoCodeAsUsed(model.promoCode, model.valueOfPurchase, model.valueOfDiscount, type, new RokoPromo.CallbackPromoMarkedAsUsed() {
                            @Override
                            public void success(String s) {
                                callbackContext.success(s);
                            }

                            @Override
                            public void failure(String s) {
                                callbackContext.error(s);
                            }
                        });
                    } catch (JSONException ex) {

                    }
                }
            });
            return true;
        }
        if (promoCodeFromNotification.equals(action)) {
            
            return true;
        }
        return false;
    }

}