//
//  Sudoko.swift
//  SudokoGame
//
//  Created by Vermeer on 25/11/2020.
//

import Foundation


class Sudoko{
    
    var sudoku:[[Int]] = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    
    func getSudoko() -> [[Int]]{
        return sudoku
    }
    
    func get(y:Int,x:Int) -> Int {
        return sudoku[y][x]
    }
    
    func set(input:[[Int]])  {
        sudoku = input
    }
    
    func setField(y:Int, x:Int, value:Int){
        self.sudoku[y][x] = value
    }
    
    func findfirstEmpty(findEmptySudoku:[[Int]])->Int{
        for y in 0...8{
            for x in 0...8{
                if findEmptySudoku[y][x] == 0  {
                    return (x+(y*9))
                }
            }
        }
        return -1
    }
    
    func cleanBoard(){
        sudoku = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                  [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                  [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    }
    
    func validMove(move:Int, value:Int, checkSud:[[Int]])-> Bool{
        let x:Int = move%9
        let y:Int = move/9
        
        for t in 0...8{
            if checkSud[t][x] == value || checkSud[y][t] == value{
                return false
            }
        }
        
        let xc = Int(x/3)
        let yc = Int(y/3)
        
        for x in 0...2{
            for y in 0...2{
                if checkSud[yc*3+x][xc*3+y] == value{
                    return false
                }
            }
        }
        return true
    }
    
    
    
    func emptyFields(findEmpty:Bool)->[Int]{
        var empty:[Int] = []
        for y in 0...8 {
            for x in  0...8{
                if sudoku[x][y] == 0 && findEmpty{
                    empty.append(x+(y*9))
                }
                if sudoku[x][y] != 0 && !findEmpty{
                    empty.append(x+(y*9))
                }
            }
        }
        return empty.shuffled()
    }
    
    
    func findValidMoves(findValidSud:[[Int]], move:Int)-> [Int]{
        
        var validMoves=[1,2,3,4,5,6,7,8,9]
        
        for validMove in validMoves {
            if !self.validMove(move: move, value:validMove, checkSud: findValidSud) {
                validMoves = validMoves.filter{$0 != validMove}
            }
        }
        return validMoves
    }
    
    func solv() -> (sud:[[Int]], solved:Bool){
        return findSolution(solutionSudoku: sudoku, toFill: self.emptyFields(findEmpty:true).count)
    }
    
    
    func findSolution(solutionSudoku:[[Int]], toFill:Int ) -> (sud:[[Int]], solved:Bool){
        var locSudoko = solutionSudoku
        let move:Int  = findfirstEmpty(findEmptySudoku: locSudoko)
        
        if move == -1 {
            return (locSudoko, false)
        }
        
        let validMoves = self.findValidMoves(findValidSud:locSudoko, move:move ).shuffled()
        for validMove in validMoves {
            print (move/9, move%9)
            locSudoko[move/9][move%9] = validMove
            if toFill-1 == 0 {
                return(locSudoko, true)
            } else {
                let solRes = findSolution(solutionSudoku: locSudoko, toFill: (toFill - 1 ))
                if solRes.solved {
                    return (sud: solRes.sud, solved:true)
                }
            }
            locSudoko[move/9][move%9] = 0
        }
        return (sudoku, false)
    }
}



