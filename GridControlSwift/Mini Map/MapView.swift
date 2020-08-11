//
//  MapView.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 29/06/2020.
//

import Cocoa
import Carbon

class MapView: NSView {

    override var canBecomeKeyView: Bool{return true}
    override var acceptsFirstResponder: Bool{return true}
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        
        
    
        NSColor.controlAccentColor.setFill()
        NSColor.controlAccentColor.setStroke()
        
        NSBezierPath.defaultLineWidth = 5
       
        let half1 = NSMakeRect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width*0.5, self.frame.size.height)
        
        let half2 = NSMakeRect(self.frame.origin.x + self.frame.size.width*0.5, self.frame.origin.y, self.frame.size.width*0.5, self.frame.size.height*0.5)
        
        let half21 = NSMakeRect(self.frame.origin.x + self.frame.size.width*0.5, self.frame.origin.y + (self.frame.height*0.5), self.frame.size.width*0.5, self.frame.size.height*0.5)
        
        //NSBezierPath.init(rect: NSInsetRect(half1, 10, 10)).fill()
        
        NSBezierPath.init(roundedRect: NSInsetRect(half1, 10, 10), xRadius: 10, yRadius: 10).fill()
        NSBezierPath.init(roundedRect: NSInsetRect(half2, 12, 12), xRadius: 10, yRadius: 10).stroke()
        NSBezierPath.init(roundedRect: NSInsetRect(half21, 12, 12), xRadius: 10, yRadius: 10).stroke()
    }
    
    override func keyDown(with event: NSEvent) {
        
        if(event.keyCode == kVK_RightArrow){
            print("Right")
        }
        
        if(event.keyCode == kVK_LeftArrow){
            print("Left")
        }
        
        if(event.keyCode == kVK_UpArrow){
            print("Up")
        }
        
        if(event.keyCode == kVK_DownArrow){
            print("Down")
        }
        
        if(event.keyCode == kVK_Escape){
            exit(0)
        }
    }
    
    
}
