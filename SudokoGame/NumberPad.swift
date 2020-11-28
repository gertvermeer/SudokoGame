//
//  numberPad.swift
//  SudokoGame
//
//  Created by Vermeer on 22/11/2020.
//

import UIKit

class NumberPad: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
        
    override func draw(_ rect: CGRect) {
        self.layer.zPosition = 1;
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }


}
