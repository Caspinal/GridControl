//
//  GridMenuView.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

import Cocoa
import SwiftUI

var start:[NSColor] = [#colorLiteral(red: 0.05073811114, green: 0.5163114071, blue: 1, alpha: 1),#colorLiteral(red: 0.7503249049, green: 0.3526417911, blue: 0.9479517341, alpha: 1),#colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 1),#colorLiteral(red: 0.9987440705, green: 0.2721400559, blue: 0.225995779, alpha: 1),#colorLiteral(red: 0.999299109, green: 0.6252407432, blue: 0.03913761675, alpha: 1),#colorLiteral(red: 0.9980487227, green: 0.8374769092, blue: 0.04027340561, alpha: 1),#colorLiteral(red: 0.1912371814, green: 0.8432568908, blue: 0.2952848673, alpha: 1),#colorLiteral(red: 0.5962216258, green: 0.5958494544, blue: 0.6175166368, alpha: 1)]
var stop :[NSColor] = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.2873452604, green: 0, blue: 0.4541208744, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.5620670319, green: 0.04504293203, blue: 0.02683575079, alpha: 1),#colorLiteral(red: 1, green: 0.335842073, blue: 0.03563668206, alpha: 1),#colorLiteral(red: 0.7065551877, green: 0.4224473834, blue: 0, alpha: 1),#colorLiteral(red: 0.1264905334, green: 0.4138234556, blue: 0.3003304005, alpha: 1),#colorLiteral(red: 0.3094345629, green: 0.3063327372, blue: 0.3205113411, alpha: 1)]

struct menuItemView: View {
    var body: some View {
        
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(LinearGradient(gradient: Gradient(colors: [Color(start[4]),Color(stop[4])]), startPoint: .top, endPoint: .bottom)).frame(width: 72, height:72).shadow(radius: 4)
                     
    
    }
}

struct menuView: View {
 
    let tags = TagWindowController()
    
     var body: some View {
        HStack{
            Spacer()
            VStack{
                Button(action: {tags.showTagOverlay()}){
                menuItemView().overlay(Image(systemName:"tag").font(.system(size: 36)))
                }.buttonStyle(PlainButtonStyle())
                
                Text("Tags")
            }
            
            Spacer()
            
            VStack{
                Button(action: {}){
                menuItemView().overlay(Image(systemName:"macwindow.on.rectangle").font(.system(size: 36.0)))
                }.buttonStyle(PlainButtonStyle())
                
                Text("Switcher")
            }
            
            Spacer()
            
            VStack{
                Button(action: {}){
                menuItemView().overlay(Image(systemName:"uiwindow.split.2x1").font(.system(size: 36.0)))
                }.buttonStyle(PlainButtonStyle())
                
                Text("Arrange")
            }
            
            Spacer()
        }
     }
    
}


class GridMenuView: NSView {

    override func viewDidMoveToWindow() {
        let host = NSHostingView(rootView: menuView())
        host.frame = self.frame
        self.addSubview(host)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
