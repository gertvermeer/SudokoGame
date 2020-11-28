//
//  CellCVCell.swift
//  SudokoGame
//
//  Created by Vermeer on 22/11/2020.
//

import UIKit

class CellCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    
  
    
    func setLabel(input: String){
        label.text = input
    }
}
