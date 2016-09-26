# Cordova RokoMobi Plugin

Plugin allows to integrate with RokoMobi Portal

## Using
Clone the plugin

    $ git clone https://github.com/maslovsa/cordova-plugin-rokomobi.git

Create a new Cordova Project

    $ cordova create hello com.example.helloapp Hello
    
Install the plugin

    $ cd hello
    $ cordova plugin add ../cordova-plugin-rokomobi
    

Edit `www/js/index.js` and add the following code inside `onDeviceReady`

```js
    var success = function(message) {
        console.log(message)
    }
    var failure = function(error) {
        var errorText =  "Error calling Roko Plugin" + error
        console.log(errorText);
    }
    var dictionary = {userName: "alex",
                referralCode: "JAFPII213A",
                     shareChannel: "Facebook"}
    rokomobi.setUser(dictionary, success, failure);
```

Install iOS or Android platform

    cordova platform add ios
    cordova platform add android
    
Run the code

    cordova run 

## More Info

For more information about RokoMobi integration[the documentation](hhttp://docs.roko.mobi/docs/cordova)
