//
//  SwitcherView.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 29/06/2020.
//

import Cocoa
import SwiftUI

struct EffectViewRep:NSViewRepresentable{
    func makeNSView(context: Context) -> NSVisualEffectView {
        let vs = NSVisualEffectView()
        vs.blendingMode = .withinWindow
        vs.material = .headerView
        vs.state = .active
        
        return vs
        
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        
    }
    
    typealias NSViewType = NSVisualEffectView
    
    
    
    
    
    
}



struct ItemView:View{
    
    var im:WData
    var body: some View{
        ZStack{
            
            HStack{
                Image(nsImage: im.image).resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
        
            Text(im.title).font(.system(Font.TextStyle.headline)).padding(.all, 6).background(EffectViewRep()).cornerRadius(10.0)
            
        }
    }
    
}


struct ContentView:View{
    
    let images = WindowCapture.captureAllWindowsAndFilter(true).allValues
    
    var body: some View{
        
        VStack{
            Spacer()
                HStack{
                    Image("icon").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 32, height: 32, alignment: .center)
                    Text("App Tittle")
                    
                }
            ScrollView{
//            LazyVStack{
//               //
//                ForEach(0..<images.count){i in
//
//                        //GeometryReader { geometry in
//                            HStack{
//                                Spacer()
//                                ItemView(im: images[i] as! WData ) .frame(height: 340)
//                                Spacer()
//                            }
//                        //}
//
//               }
//
//            //}
//            }
            }
        }
                
       
        
    }
    
}

class SwitcherView: NSView {



        override init(frame frameRect: NSRect) {
          
            super.init(frame: frameRect)
        }
        
        override var canBecomeKeyView:Bool{return true}
        override var acceptsFirstResponder: Bool{return true}
        
    var vs:NSVisualEffectView?
    var cv:NSHostingView<ContentView>?
    
        let roundLayer: CALayer = CALayer()
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
//            self.layer = roundLayer
//            self.wantsLayer = true
//            self.layer?.cornerRadius = 20
//            self.layer?.bounds = self.bounds
//            self.layer?.masksToBounds = true
//            self.layer?.backgroundColor = NSColor.clear.cgColor
            
            self.vs = NSVisualEffectView();
            self.vs?.frame = self.frame
            self.vs?.state = .active
            self.vs?.material = .popover
            
            
            //let content = ContentView()
           let host = NSHostingView(rootView: ContentView())
            self.cv = host
            self.cv?.bounds = self.bounds
            self.cv?.frame = self.frame
            
            self.addSubview((self.vs)!)
            self.addSubview((self.cv)!)
            
            //self.window?.invalidateShadow()

        }
        
        override func draw(_ dirtyRect: NSRect) {
            
            NSColor.gray.setFill()
            NSBezierPath.init(rect: self.bounds).fill()
            
         
        }
        
        override func keyDown(with event: NSEvent) {
            print("Boop")
        }
    
    override func viewDidEndLiveResize() {
        self.vs?.frame = self.frame
        self.cv?.frame = self.frame
    }
    
    }


struct MiniMap_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
