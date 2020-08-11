//
//  BackgroundViewController.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 30/06/2020.
//

import Cocoa

class BackgroundViewController: NSWindowController {

    @IBOutlet weak var backingBlur: NSVisualEffectView!
    @IBOutlet weak var backImage: NSImageView!
    
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        self.backingBlur.state = .active
        //self.backingBlur.material = .fullScreenUI
        //self.backingBlur.isEmphasized = true
        self.backImage.image = (WindowCapture.captureDektopPictures().first as! NSImage)
        self.backImage.imageScaling = NSImageScaling.scaleProportionallyDown
        
        
        self.window?.setFrame(NSScreen.main!.frame, display: true)
        self.backImage.setFrameSize((self.window?.frame.size)!)
        self.backImage.setFrameOrigin(NSMakePoint(0, 0))
        
        self.backingBlur.frame = self.backImage.frame
    }
    
    
    override func showWindow(_ sender: Any?) {
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 1.0
        self.window!.animator().alphaValue = 1.0
        NSAnimationContext.endGrouping()
        
        super.showWindow(self)
    }
}
