//
//  TestPlugin.js
//  TestPlugin PhoneGap/Cordova plugin
//
//  Created by Coder Dads, LLC.
//  Copyright (c) 2016 Coder Dads, LLC. All rights reserved.
//  MIT Licensed
//

  module.exports = {
    
    multiTag:function(successCallback, failureCallback, imagePaths, watermark, style, size, price){
       // successCallback required
        if (typeof successCallback != "function") {
            console.log("TestPlugin Error: successCallback is not a function");
        }
        else if (typeof failureCallback != "function") {
            console.log("TestPlugin Error: failureCallback is not a function");
        }
        else {
            return cordova.exec(successCallback, failureCallback, "TestPlugin", "multiTag", [imagePaths, watermark, style, size, price]);
        }
    }
  };
  
