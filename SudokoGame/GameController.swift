//
//  GameController.swift
//  SudokoGame
//
//  Created by Vermeer on 25/11/2020.
//

import UIKit
import Foundation

class GameController{
    
    struct Move {
        init(y:Int,x:Int){
            self.x = x
            self.y = y
        }
        var y: Int = 0
        var x: Int = 0
    }
    
    var moveList:[Move]  = []
    var numberPad = NumberPad()
    var frame = CGRect()
    
    var solLabel = UILabel()
    
    var collectionViewList: [CellCVCell] = []
    
    var cellX = -1
    var cellY = -1
    
    var sudoko = Sudoko()
    
    var buttonList : [UIButton] = []
    
    func setup(numberPad : NumberPad, frame:CGRect, buttonList: [UIButton], solLabel: UILabel){
        self.numberPad = numberPad
        self.frame = frame
        self.buttonList = buttonList
        self.solLabel = solLabel
    }
    
    func addCell(cell: CellCVCell){
        collectionViewList.append(cell)
    }
    
    func buttonPressed(value:Int){
        numberPad.isHidden = true
        sudoko.setField(y: cellY, x: cellX, value: value)
        collectionViewList[cellY+(cellX*9)].setLabel(input: String(value))
        moveList.append(Move(y:cellY,x:cellX))
    }
    
    
    func cancelMove(){
        print("cancelMove")
        sudoko.setField(y: cellY, x: cellX, value: 0)
        collectionViewList[cellY+(cellX*9)].setLabel(input: String(""))
        moveList = moveList.filter{ $0.x != cellX || $0.y != cellY}
        print (moveList)
        numberPad.isHidden = true
    }
    
    func undoLastMove(){
        if moveList.count > 0 {
            let move = moveList.popLast()
            sudoko.setField(y: move!.y, x: move!.x, value: 0)
            collectionViewList[move!.y+(move!.x*9)].setLabel(input: String(""))
        }
        
    }
    
    
    func mouseClick(location:CGPoint){
        numberPad.isHidden = false
        cellY = Int(location.x/(frame.width/9))
        cellX = Int(location.y/(frame.height/9))
        if sudoko.get(y: cellY, x: cellX) > 0 {
            for button in 1...9 {
                buttonList[button].isEnabled = false
            }
            buttonList[0].isEnabled = true
        } else {
            determineMoves()
        }
        
        
    }
    
    
    func determineMoves(){
        var sol = [1,2,3,4,5,6,7,8,9]

        for t in 0...8{
            sol = sol.filter{$0 != sudoko.get(y: cellY, x: t)}
            sol = sol.filter{$0 != sudoko.get(y: t, x: cellX)}
            buttonList[t+1].isEnabled = false
        }
        
        let xc = Int(cellX/3)
        let yc = Int(cellY/3)
        
        for x in 0...2{
            for y in 0...2{
                sol = sol.filter{$0 != sudoko.sudoku[xc*3+x][yc*3+y]}
            }
        }
                
        for button in sol {
            buttonList[button].isEnabled = true
        }
        buttonList[0].isEnabled = false

    }
    
    func newGame(level:Int){
        solLabel.isHidden = true
        sudoko.cleanBoard();
        moveList = []
        collectionViewList.forEach{s in s.setLabel(input:"")}
        if level == 0{
            return
        }
        
        var emptyFields = 0
        
        if level == 1 {
            emptyFields = 43
        } else {
            emptyFields = 55
        }
        let sol = sudoko.solv()
        for y in 0...8{
            for x in 0...8{
                collectionViewList[(x*9)+y].setLabel(input:String(sol.sud[y][x]))
            }
        }
        sudoko.set(input: sol.sud)
        let toRemove = sudoko.emptyFields(findEmpty: false).prefix(emptyFields)
        toRemove.forEach{
            cell in
            collectionViewList[cell].setLabel(input: "")
            sudoko.setField(y:cell%9,x:cell/9, value:0)
        }
    }
    
    
    func solveSudoku(){
        numberPad.isHidden = true
        let solution = sudoko.solv()
        if solution.solved {
            for t in 0...80 {
                collectionViewList[t].setLabel(input:String(solution.sud[t%9][t/9]))
                sudoko.set(input: solution.sud)
            }
        } else {
            solLabel.isHidden = false

        }
        
        
    }
    
    
}
