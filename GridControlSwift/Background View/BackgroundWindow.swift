//
//  BackgroundWindow.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 30/06/2020.
//

import Cocoa




class BackgroundWindow: NSWindow,NSWindowDelegate {

    override func awakeFromNib() {
    
        self.collectionBehavior = [.canJoinAllSpaces,.ignoresCycle,.transient]
            
        self.styleMask = [.closable,.fullSizeContentView]
        
        self.level = .statusBar
        
        
        self.isOpaque = false
        
        self.alphaValue = 0.0
        
        self.delegate = self
    }
    
    
    
}
