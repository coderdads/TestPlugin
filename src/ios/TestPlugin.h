//
//  TestPlugin.h
//  TestPlugin PhoneGap/Cordova plugin
//
//  Created by Coder Dads, LLC.
//  Copyright (c) 2016 Coder Dads, LLC. All rights reserved.
//  MIT Licensed
//

#import <Cordova/CDVPlugin.h>

@interface TestPlugin : CDVPlugin
{
	NSString* callbackId;
}

@property (nonatomic, copy) NSString* callbackId;
@property (nonatomic, retain) NSMutableArray* imagesToProcess;
@property (nonatomic, copy) NSString* style;
@property (nonatomic, copy) NSString* size;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* watermark;

- (void)multiTag:(CDVInvokedUrlCommand*)command;
@end
