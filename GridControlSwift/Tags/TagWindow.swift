//
//  TagWindow.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

import Cocoa

class TagWindow: NSWindow {
    
    
    override func keyDown(with event: NSEvent) {
        let controller = self.windowController as! TagWindowController
        controller.keyDown(with: event)
    }
    
    override var canBecomeKey: Bool{
        return true
    }
    
    override var canBecomeMain: Bool{
        return true
    }
    
    override func awakeFromNib() {
    
        self.collectionBehavior = [.canJoinAllSpaces,.ignoresCycle,.transient]
            
        self.styleMask = [.closable,.fullSizeContentView]
        
        self.level = .statusBar
        
        self.backgroundColor = NSColor.clear
        
        self.isOpaque = false
        
        self.alphaValue = 1.0
        
        //self.delegate = self
    }
}
