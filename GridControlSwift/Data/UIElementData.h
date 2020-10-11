//
//  UIElementData.h
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIElementData : NSObject
    @property NSRect frame;
    @property AXUIElementRef elementRef;
    @property NSString* tittle;

-(void)pressAction;
@end

NS_ASSUME_NONNULL_END
