//
//  GridMenuWindowController.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

import Cocoa

class GridMenuWindowController: NSWindowController {

    init() {
        let win = NSWindow(contentRect: NSRect(x: 10, y: 10, width: 300, height: 200), styleMask: [.titled,.closable], backing: .buffered, defer: true)
        super.init(window: win)
        self.window?.contentView?.addSubview(GridMenuView(frame:NSRect(x: 0, y: 0, width: 300, height: 200)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
