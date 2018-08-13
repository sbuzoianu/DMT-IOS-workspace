//
//  Circle.swift
//  DMT
//
//  Created by Boggy on 04/03/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import UIKit

class Circle: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let raza: Double = Double(rect.width) / 2 - 1
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        path.move(to:CGPoint(x: center.x + CGFloat(raza), y: center.y))
        
        for i in stride(from: 0, to: 361.0, by: 1) {
            let radian = i * Double.pi / 180
            let x = Double(center.x) + raza * cos(radian)
            let y = Double(center.y) + raza * sin(radian)
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        UIColor.white.setStroke()
        Colors.bgWhite.setFill()
        path.lineWidth = 2
        path.fill()
        path.stroke()
    }
}


