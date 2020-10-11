//
//  TagView.swift
//  GridControlSwift
//
//  Created by Connor Aspinall on 10/10/2020.
//

import Cocoa
import SwiftUI

extension CGFloat{
    
    static func lerp( v0:CGFloat,  v1:CGFloat, t:CGFloat) -> CGFloat {
        return (1.0 - t) * v0 + t * v1;
    }
}

extension CGPoint{

    static func lerp(p0:CGPoint, p1:CGPoint, t:CGFloat) -> CGPoint{
    
        return CGPoint(x:CGFloat.lerp(v0: p0.x,v1: p1.x,t: t),
                       y:CGFloat.lerp(v0: p0.y,v1: p1.y,t: t))
    }
        
    
}

extension View {
    public func gradientForeground(colors: [Color],rad:CGFloat) -> some View {
        self.overlay(RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: rad*0.25, endRadius: rad*0.5))
            .mask(self)
    }
    
}

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
             
            let newP0 = CGPoint.lerp(p0: p0, p1: p1, t: 0.1)
            let newP1 = CGPoint.lerp(p0: p0, p1: p1, t: 0.9)
             
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
    
    @State var startCol:NSColor
    @State var stopCol:NSColor
    @State var letter:String
    @State var Rotation:Double
    
     var body: some View {
    
            GeometryReader{ geometry in
                
                ZStack{
                   
                    Label().rotation(Angle(degrees: Rotation))
                        .fill(RadialGradient(gradient: Gradient(colors: [Color(startCol),Color(stopCol)]), center: .center, startRadius: 10, endRadius: geometry.size.width*0.75)).shadow(radius: 4)
                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                    HStack{
                        VStack{
                        
                            Text(letter).font(.system(size: geometry.size.height*0.65))
                                .gradientForeground(colors: [.white, Color(startCol)],rad: geometry.size.height*0.65).shadow(radius: 4).padding(.top,4)
                            
                    
                        }
                    }
                
                }
                
            }
    }
}

class TagView: NSView {

    var angle:Double = 0
    var text:String = "Q"
    var startColour:NSColor = .controlAccentColor
    var stopColour:NSColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    
    func create(){
        
        let host = NSHostingView(rootView: LabelView(startCol: self.startColour, stopCol: self.stopColour, letter: self.text, Rotation: self.angle))
        host.frame = NSRect(origin: CGPoint(), size: self.frame.size)
        self.addSubview(host)
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
//        self.startColour.setFill()
//        NSBezierPath.fill(dirtyRect)
//
//        NSString(string: self.text).draw(in: dirtyRect, withAttributes: nil)
        
    }
    
}
