//
//  PinView.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 06/10/2020.
//

import Cocoa
import SwiftUI

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: 50, endRadius: 100))
            .mask(self)
    }
}

func lerp( v0:CGFloat,  v1:CGFloat, t:CGFloat) -> CGFloat {
    return (1.0 - t) * v0 + t * v1;
}

func Blerp(p0:CGPoint, p1:CGPoint, t:CGFloat) -> CGPoint{
    
    return CGPoint(x:lerp(v0: p0.x,v1: p1.x,t: t), y:lerp(v0: p0.y,v1: p1.y,t: t))
    
}

class PinView: NSView {

    


    struct Label: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()

            let width = rect.width
            let height = rect.height
            let extent = 1.0/3
            let points = [CGPoint(x: 0.5, y: 0.0),
                                        CGPoint(x: 1.0, y: extent),
                                        CGPoint(x: 1.0, y: 1.0),
                                        CGPoint(x: 0.0, y: 1.0),
                                        CGPoint(x: 0.0, y: extent),
                                        CGPoint(x: 0.5, y: 0.0)]
                       
            var newPoints:[CGPoint] = []
                     
                     
             var n = 0
             while(n < points.count-1){
                 
                 
                 let p0 = CGPoint(x: (points[n].x*CGFloat(width)),
                                  y: (points[n].y*CGFloat(height)))
                 
                 let p1 = CGPoint(x: (points[n+1].x*CGFloat(width)),
                                  y: (points[n+1].y*CGFloat(height)))
                 
                let newP0 = Blerp(p0: p0, p1: p1, t: 0.1)
                let newP1 = Blerp(p0: p0, p1: p1, t: 0.9)
                 
                 newPoints.append(newP0) // start
                 newPoints.append(newP1) // end
                 newPoints.append(p1) //control point
                 
                 n+=1
             }
                     
            var np = 0
            path.move(to: newPoints[np])
            
            while(np < newPoints.count-4){
                
                 path.addLine(to: newPoints[np+1])
                 path.addQuadCurve(to: newPoints[np+3], control: newPoints[np+2])
                 
                np+=3
             }
                 
            let last = newPoints.count-2
            path.addLine(to: newPoints[last])
            path.addQuadCurve(to: newPoints[0], control: newPoints[last+1])

            return path
        }
    }



    struct LabelView: View {
        
        let gradient = Gradient(colors: [.orange, .red])
        let textgradient = Gradient(colors: [.orange, .white])
        
        
        
        
         var body: some View {
        
            Button("Pins", action:{UIElementDataProvider.createData()})
        }
    }
     
       
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let view = NSHostingView(rootView: LabelView())
        view.frame = NSRect(origin: CGPoint(), size: self.frame.size)
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.red.setFill()
        NSBezierPath.fill(dirtyRect)
        
    }
    
}

