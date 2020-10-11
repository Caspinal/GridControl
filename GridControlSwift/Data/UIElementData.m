//
//  UIElementData.m
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

#import "UIElementData.h"

@implementation UIElementData

- (void)pressAction {
    
    AXUIElementPerformAction(self.elementRef, kAXPressAction);
}

@end
