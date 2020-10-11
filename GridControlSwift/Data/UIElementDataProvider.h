//
//  PinData.h
//  GridControlSwift
//
//  Created by Connor Aspinall on 07/10/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIElementDataProvider : NSObject

@property NSMutableArray* elements;
+(NSMutableArray*)createData;
+(void)createAppSwitchObserver;



@end

NS_ASSUME_NONNULL_END
