//
//  TagWindowController.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

import Cocoa

class TagWindowController: NSWindowController {

    
    
    init() {
        let tagWindow = TagWindow()
        tagWindow.awakeFromNib() // this aint great needs to be moved to another built in callback
        tagWindow.setFrame(NSScreen.main!.frame, display: true)
        super.init(window: tagWindow)
        self.window = tagWindow
        self.window?.windowController = self
    }
    
    func showTagOverlay(){
        self.addTags()
        self.showWindow(self)
        
    }
    
    var TaggedPairs:[String: UIElementData] = [:]
    
    func addTags(){
        
        self.TaggedPairs = [:]
        let elements:[UIElementData] = UIElementDataProvider.createData() as! [UIElementData];
        let screenHeight = NSScreen.main?.frame.height
        var i = 0
        let letters = "QWERTYUIOP"
        for e in elements {
            
            let tagSize:CGFloat = 32
            //center tag                offset to UI target center
            let xoffset =  (e.frame.origin.x - (tagSize*0.5)) + (e.frame.width * 0.5)
            let yoffset = (screenHeight!-e.frame.origin.y) - (e.frame.height + tagSize)
            
            let tag = TagView(frame:NSRect(x: xoffset, y: yoffset, width: tagSize, height: tagSize))
            
            tag.text = String(letters[letters.index(letters.startIndex, offsetBy:i)])
            i+=1
          
            tag.angle = 0
            tag.create()
            
            self.TaggedPairs.updateValue(e, forKey: tag.text)
            
            self.window?.contentView?.addSubview(tag)
        }
      
    }
    
    override func keyDown(with event: NSEvent) {
        
        let key = String((event.characters?.first)!).uppercased()
        let value = self.TaggedPairs[key]
        
        value?.pressAction()
        self.window?.close()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented because the dev is a pleb")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

    }

}
