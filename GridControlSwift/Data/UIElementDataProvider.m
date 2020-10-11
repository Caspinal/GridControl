//
//  PinData.m
//  GridControlSwift
//
//  Created by Connor Aspinall on 07/10/2020.
//

#import "UIElementDataProvider.h"
#import "UIElementData.h"
#import <Cocoa/Cocoa.h>

@implementation UIElementDataProvider


bool iterateActions(AXUIElementRef element){
    
    CFArrayRef actions;
    AXError e =AXUIElementCopyActionNames(element,&actions);
    
    if( e != kAXErrorSuccess){
        return false;
    }
    
    for (int i = 0; i < CFArrayGetCount(actions); i++) {
        CFTypeRef value = CFArrayGetValueAtIndex(actions, i);
         CFComparisonResult r = CFStringCompare(value,kAXPressAction,kCFCompareCaseInsensitive);
        if(r == kCFCompareEqualTo){
        return true;
        }
//        NSLog(@"%@",value);
    }
    return false;
    
}

void iterateChildren(AXUIElementRef parent, int level, NSMutableArray *results){
    
    
    
    CFArrayRef children;
    AXError e =AXUIElementCopyAttributeValues(parent, (__bridge CFStringRef)@"AXChildren", 0, 100, &children);
    
    if( e != kAXErrorSuccess){
        return;
    }
    
    
    
    for (int i = 0; i < CFArrayGetCount(children); i++) {
        
        AXUIElementRef  child = CFArrayGetValueAtIndex(children, i);
        
            CFTypeRef role = NULL;
            CFTypeRef subRole = NULL;
            CFTypeRef title = NULL;
            CFTypeRef position = NULL;
            CFTypeRef size = NULL;
        CFTypeRef enabled = NULL;
        
            AXError er = AXUIElementCopyAttributeValue(child,kAXRoleAttribute, &role);
        
        if(er == kAXErrorSuccess){
            AXUIElementCopyAttributeValue(child,kAXTitleAttribute, &title);
            AXUIElementCopyAttributeValue(child,kAXPositionAttribute, &position);
            AXUIElementCopyAttributeValue(child, kAXSubroleAttribute, &subRole);
            AXUIElementCopyAttributeValue(child, kAXSizeAttribute, &size);
            AXUIElementCopyAttributeValue(child, kAXEnabledAttribute, &enabled);
            
            
            CGPoint pointValue = CGPointMake(0, 0);
            CGSize sizeValue = CGSizeMake(0, 0);
            
            AXValueGetValue(position, kAXValueCGPointType, &pointValue);
            AXValueGetValue(size, kAXValueCGSizeType, &sizeValue);
            
            
            CGRect frame = CGRectMake(pointValue.x, pointValue.y, sizeValue.width, sizeValue.height);
        
        
            CFComparisonResult r = CFStringCompare(role,kAXButtonRole,kCFCompareCaseInsensitive);
                if(r == kCFCompareEqualTo){
                    
                    NSString *rectStr = [NSString stringWithFormat:@"x: %f y: %f w: %f h: %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height];
                    NSLog(@"%@, %@, %@, %@, %@",role,subRole,title,enabled,rectStr);
                
                    if (CFBooleanGetValue(enabled)) {
                        
                    UIElementData *elementData = [[UIElementData alloc] init];
                    elementData.frame = frame;
                    elementData.elementRef = child;
                    elementData.tittle = (NSString*)CFBridgingRelease(title);
                    [results addObject:elementData];
                        
                    }
                    
                }
            iterateChildren(child,level+1,results);
        }
    }
}

pid_t lastApp = -1;

+ (NSMutableArray*)createData {

    pid_t fid = [[NSWorkspace sharedWorkspace] frontmostApplication].processIdentifier;
    
    AXUIElementRef  frontmostAppRep = AXUIElementCreateApplication(fid);
    
    
    if(!frontmostAppRep){
        
        NSDictionary *userInfo = @{
          NSLocalizedDescriptionKey: NSLocalizedString(@"Accessibility Permission Denied", nil),
          NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Could not create accessabilty handle for the target process", nil),
          NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please check your security settings.", nil)
                                  };
        
        NSError *AXPermissionError = [[NSError alloc] initWithDomain:@"Grid Control" code:0 userInfo:userInfo];
        [[NSAlert alertWithError:AXPermissionError] runModal];
        return NULL;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    iterateChildren(frontmostAppRep, 0,array);

    return array;
}

+ (void)createAppSwitchObserver {
    // NSTimer *T =
   [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer *timer) {
        
        
        pid_t fid = [[NSWorkspace sharedWorkspace] frontmostApplication].processIdentifier;
        if(lastApp != fid){
            NSLog(@" %@ %d",[[NSWorkspace sharedWorkspace] frontmostApplication].localizedName,fid);
        }
        lastApp = fid;
    }];
}

@end
