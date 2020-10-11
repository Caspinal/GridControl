//
//  PinWindowController.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 05/10/2020.
//

import Cocoa

class PinWindowController: NSWindowController {

    
    
    func test(){
        let view = PinView(frame: NSRect(x: 20, y: 20, width: 50, height: 50))
        self.window?.contentView?.addSubview(view)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
      
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
