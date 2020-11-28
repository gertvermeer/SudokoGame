//
//  Raster.swift
//  SudokoGame
//
//  Created by Vermeer on 22/11/2020.
//

import UIKit

class Raster: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var line = UIBezierPath()
    var choice = 8 //  geen lijn
    
    fileprivate func drawSingleLine(_ start: CGPoint, _ end: CGPoint) {
        line.removeAllPoints()
        line.move(to: start)
        line.addLine(to: end)
        UIColor.orange.setStroke()
        line.lineWidth=6
        line.stroke()
    }
    
    func drawLine()
    {
        
        let width = bounds.width
        let heigth = bounds.height
        
        
        
        var start = CGPoint(x:width/3,y:0)
        var end = CGPoint(x:width/3,y:heigth)
        drawSingleLine(start, end)
        
        start = CGPoint(x:width*2/3,y:0)
        end = CGPoint(x:width*2/3,y:heigth)
        drawSingleLine(start, end)
        
        start = CGPoint(x:0,y:heigth/3-3)
        end = CGPoint(x:width,y:heigth/3-3)
        drawSingleLine(start, end)
        
        start = CGPoint(x:0,y:heigth*2/3-3)
        end = CGPoint(x:width,y:heigth*2/3-3)
        drawSingleLine(start, end)
    }
    
    
    
        
    
    
    override func draw(_ rect: CGRect) {
 
            self.backgroundColor = UIColor.clear
            drawLine()
            self.setNeedsDisplay()
    }

}
