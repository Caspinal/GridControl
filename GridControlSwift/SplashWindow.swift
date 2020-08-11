//
//  SplashWindow.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 26/06/2020.
//

import Cocoa

class SplashWindow: NSWindow {

    
       
    override func awakeFromNib() {
        
    
        self.collectionBehavior = [.canJoinAllSpaces,.ignoresCycle,.transient]
            
        self.styleMask = [.closable,.fullSizeContentView]
        
        self.backgroundColor = NSColor.clear
        
        self.isOpaque = false
        //self.isMovableByWindowBackground = true
        self.isRestorable = false
        
        self.level = .statusBar
        
        let winframe = NSScreen.main?.visibleFrame ?? NSZeroRect
       
      
        
        let newpos = NSMakePoint(winframe.midX - (self.frame.size.width*0.5), 20)
        self.setFrameOrigin(newpos)
       
        self.setFrame(NSMakeRect(newpos.x, newpos.y, 240, 180), display: true)
        
        
    }
    
    
    override var canBecomeKey: Bool { return true }
    
    override class func awakeFromNib() {
    
    }
    
    
}
