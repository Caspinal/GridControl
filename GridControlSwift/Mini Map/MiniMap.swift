//
//  miniMap.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 27/06/2020.
//

import Cocoa

class MiniMap: NSView {

    override init(frame frameRect: NSRect) {
      
        super.init(frame: frameRect)
    }
    
    override var canBecomeKeyView:Bool{return true}
    
    
    let roundLayer: CALayer = CALayer()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //self.layer = roundLayer
        self.wantsLayer = true
        self.layer?.cornerRadius = 20
        self.layer?.bounds = self.bounds
        self.layer?.masksToBounds = true
        //self.layer?.backgroundColor = NSColor.clear.cgColor
        self.layer?.backgroundColor = NSColor.black.cgColor
        
        let vs = NSVisualEffectView();
        vs.frame = self.frame
        vs.state = .active
        vs.material = .popover
        
        let mini = MapView(frame: self.frame)
        
        
//        let content = ContentView()
//        let cv = NSHostingView(rootView: content)
//        cv.bounds = self.bounds
//        cv.frame = self.frame
        
        self.addSubview(vs)
        self.addSubview(mini)
        //self.addSubview(cv)
        
        //self.window?.invalidateShadow()

    }
    
    override func draw(_ dirtyRect: NSRect) {
        
        super.draw(dirtyRect)
        
        //NSBezierPath.init(rect: NSInsetRect(half2, 10, 10)).stroke()
        
       
        
        
    }
    
//    override func keyDown(with event: NSEvent) {
//        print("Boop")
//    }
}



