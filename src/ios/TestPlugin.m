//
//  TestPlugin.m
//  TestPlugin PhoneGap/Cordova plugin
//
//  Created by Coder Dads, LLC.
//  Copyright (c) 2016 Coder Dads, LLC. All rights reserved.
//  MIT Licensed
//

#import "TestPlugin.h"
#import <Cordova/CDV.h>
#import <Photos/Photos.h>

@implementation TestPlugin
@synthesize callbackId;

- (void)multiTag:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    
    // get List of images from arguments path
    NSString* imagePaths = [command.arguments objectAtIndex:0];
    self.imagesToProcess = [[NSJSONSerialization JSONObjectWithData:[imagePaths dataUsingEncoding:NSUTF8StringEncoding]
        options:kNilOptions
        error:nil] mutableCopy];

    // get watermark text from arguments
    self.watermark = [command.arguments objectAtIndex:1];
    self.style = [command.arguments objectAtIndex:2];
    self.size = [command.arguments objectAtIndex:3];
    self.price = [command.arguments objectAtIndex:4];

    // start tagging and saving first image
    [self processImage];
}

- (void)processImage{

    if (!self.imagesToProcess.count)
    {
        NSLog(@"successfully saved image(s)");
        CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:@"Image(s) saved"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
    else
    {
        // process the last image in the list
        NSString* imagePath = [self.imagesToProcess lastObject];
        imagePath = [imagePath stringByReplacingOccurrencesOfString:@"file://"
         withString:@""];
        
        UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
        
        // write watermark on image
        //  create context based on image size
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);

        // draw image on context
        [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];

        // set up font options for watermark
        NSMutableDictionary *watermarkAttributes = [NSMutableDictionary dictionary];
        [watermarkAttributes setObject: [UIFont fontWithName:@"Avenir Book" size:30] forKey: NSFontAttributeName];
        [watermarkAttributes setObject: [UIColor whiteColor] forKey: NSForegroundColorAttributeName];
        [watermarkAttributes setObject: [[UIColor blackColor] colorWithAlphaComponent:0.75f] forKey: NSBackgroundColorAttributeName];

        // create a size object to measure the watermark for placement
        int watermarkPadding = image.size.height/16;
        CGSize watermarkSize = [self.watermark sizeWithAttributes:watermarkAttributes];
        [self.watermark drawAtPoint:CGPointMake(watermarkPadding, image.size.height - watermarkSize.height - watermarkPadding) withAttributes:watermarkAttributes];

        // set up font options for tags
        NSMutableDictionary *tagAttributes = [NSMutableDictionary dictionary];
        [tagAttributes setObject: [UIFont fontWithName:@"Verdana" size:45] forKey: NSFontAttributeName];
        [tagAttributes setObject: [UIColor blackColor] forKey: NSForegroundColorAttributeName];
        //[tagAttributes setObject: [[UIColor whiteColor] colorWithAlphaComponent:0.75f] forKey: NSBackgroundColorAttributeName];

        // create size objects to measure the tags for placement
        CGSize styleSize = [self.style sizeWithAttributes:tagAttributes];
        CGSize sizeSize = [self.size sizeWithAttributes:tagAttributes];
        CGSize priceSize = [self.price sizeWithAttributes:tagAttributes];

        int padding = image.size.width/32;
        int verticalPadding = image.size.height/16;
        int tagStartX = image.size.width/2 + padding;
        int tagStartY = image.size.height/2 + verticalPadding;
        int tagWidth = image.size.width/2 - padding * 2;
        int tagHeight = ((image.size.height/2) - (verticalPadding*4))/3;

        //draw Style 
        [[UIColor whiteColor] set];
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(tagStartX, tagStartY, tagWidth, tagHeight));
        [self.style drawAtPoint:CGPointMake(tagStartX + (tagWidth/2-styleSize.width/2), tagStartY + (tagHeight/2 - styleSize.height/2)) withAttributes:tagAttributes];

        // draw Size
        [[UIColor whiteColor] set];
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(tagStartX, tagStartY+tagHeight+verticalPadding, tagWidth, tagHeight));
        [self.size drawAtPoint:CGPointMake(tagStartX + (tagWidth/2-sizeSize.width/2), tagStartY+tagHeight+verticalPadding + (tagHeight/2 - sizeSize.height/2)) withAttributes:tagAttributes];

        // draw Price
        [[UIColor whiteColor] set];
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(tagStartX, tagStartY+((tagHeight+verticalPadding)*2), tagWidth, tagHeight));
        [self.price drawAtPoint:CGPointMake(tagStartX + (tagWidth/2-priceSize.width/2), tagStartY+((tagHeight+verticalPadding)*2) + (tagHeight/2 - priceSize.height/2)) withAttributes:tagAttributes];

        // create a new image from the context with the overlays
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        // save image to camera roll
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
        {
            PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:newImage];
            changeRequest.creationDate          = [NSDate date];
        }
        completionHandler:^(BOOL success, NSError *error)
        {
            if (success)
            {
                // remove current image
                [self.imagesToProcess removeLastObject];

                // process next image
                [self processImage];
                
            }
            else
            {
                NSLog(@"error saving to photos: %@", error);
                CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString:error.description];
                [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
            }
        }];
    }   
}

- (void)dealloc
{	
	[callbackId release];
    [_imagesToProcess release];
    [super dealloc];
}


@end
