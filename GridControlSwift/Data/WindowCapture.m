//
//  WindowCapture.m
//  GridControlSwift
//
//  Created by Connor Aspinall on 02/07/2020.
//

#import "WindowCapture.h"
#import <Cocoa/Cocoa.h>
#import <ApplicationServices/ApplicationServices.h>
#import "WData.h"



@implementation WindowCapture

+ (nonnull NSMutableDictionary *)captureAllWindowsAndFilter:(Boolean) filter{
   
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    CFArrayRef windowIDList = CGWindowListCreate(kCGWindowListOptionAll, kCGNullWindowID);
    CFArrayRef windowDescList = CGWindowListCreateDescriptionFromArray(windowIDList);
    
    
    CFIndex len = CFArrayGetCount(windowIDList);
    
    for(int i =0; i < len; i++){
        
        CGWindowID winID = (CGWindowID)CFArrayGetValueAtIndex(windowIDList, i);
        CGImageRef imageRef = CGWindowListCreateImage(CGRectNull, kCGWindowListOptionIncludingWindow, winID, kCGWindowImageBestResolution | kCGWindowImageBoundsIgnoreFraming);
        
        NSSize imageRes = NSMakeSize(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
        NSImage *capturedImage = [[NSImage alloc] initWithCGImage:imageRef size:imageRes];
        
        if (imageRef == nil && filter) {
            continue;
        }
        
        WData  *dataOBJ = [[WData alloc] init];
        
        dataOBJ.image = capturedImage;
        
       
        NSString *key = [[NSString alloc] initWithFormat:@"%d",winID];
        [dataDict setObject:dataOBJ forKey:key];
           
    }
    
    
    len = CFArrayGetCount(windowDescList);
    
    for(int i =0; i < len; i++){
        CFDictionaryRef descDic = (CFDictionaryRef)CFArrayGetValueAtIndex(windowDescList, i);
        
        CFStringRef  title = CFDictionaryGetValue(descDic, kCGWindowName);
        CFNumberRef   winNum =  CFDictionaryGetValue(descDic, @"kCGWindowNumber");

        CGWindowID winID;
        
        CFNumberGetValue(winNum, kCFNumberLongType, &winID);
        
        //NSLog(@"%@",title);
        NSString *key = [[NSString alloc] initWithFormat:@"%d",winID];
        WData *dataOBJ = [dataDict objectForKey:key];
        
        if(dataOBJ == nil){
            continue;
        }
        
        dataOBJ.title = CFBridgingRelease(title);
        
        [dataDict setObject:dataOBJ forKey:key];
    }
    
    //NSArray *values =  dataDict.allValues;
    
    return dataDict;
}

+ (nonnull NSArray *)captureDektopPictures { 

    NSMutableArray* results = [[NSMutableArray alloc] init];
    NSMutableDictionary *all = [WindowCapture captureAllWindowsAndFilter:YES];
    
    for (WData *data in all.allValues) {
        
        if ([data.title hasPrefix:@"Desktop Picture - "]) {
            [results addObject:data.image];
        }
        
    }
    
    return results;
}

@end
