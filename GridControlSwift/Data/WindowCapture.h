//
//  WindowCapture.h
//  GridControlSwift
//
//  Created by Connor Aspinall on 02/07/2020.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface WindowCapture : NSWindow


+(NSMutableDictionary*)captureAllWindowsAndFilter:(Boolean) filter;

+(NSArray*)captureDektopPictures;

@end

NS_ASSUME_NONNULL_END
