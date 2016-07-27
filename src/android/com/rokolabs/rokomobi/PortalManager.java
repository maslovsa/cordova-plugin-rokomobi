package com.rokolabs.rokomobi;

import com.rokolabs.rokomobi.base.BasePlugin;
import com.rokolabs.rokomobi.base.Settings;
import com.rokolabs.rokomobi.base.User;
import com.rokolabs.sdk.RokoMobi;
import com.rokolabs.sdk.account.RokoAccount;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

public class PortalManager extends BasePlugin {
    private static final String SET_USER = "setUser";


    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (SET_USER.equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        User user = gson.fromJson(args.getJSONObject(0).toString(), User.class);
                        RokoAccount.setUser(RokoMobi.getInstance().getApplicationContext(), user.userName, user.referralCode, user.shareChannel, null);
                        callbackContext.success();
                    } catch (JSONException ex) {
                        callbackContext.error("Error parse json");
                    }
                }
            });
            return true;
        }
        callbackContext.error("User not set");
        return false;
    }
}
