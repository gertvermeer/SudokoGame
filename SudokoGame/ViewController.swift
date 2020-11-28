//
//  ViewController.swift
//  SudokoGame
//
//  Created by Vermeer on 22/11/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
 
 var gameController = GameController()
 
 @IBOutlet weak var numberPad: NumberPad!
 
 @IBOutlet weak var gameBoard: UICollectionView!
 
 @IBAction func but1(_ sender: Any) {
  gameController.buttonPressed(value: 1)
 }
 @IBAction func but2(_ sender: Any) {
  gameController.buttonPressed(value: 2)
 }
 @IBAction func but3(_ sender: Any) {
  gameController.buttonPressed(value: 3)
 }
 @IBAction func but4(_ sender: Any) {
  gameController.buttonPressed(value: 4)
 }
 @IBAction func but5(_ sender: Any) {
  gameController.buttonPressed(value: 5)
 }
 @IBAction func but6(_ sender: Any) {
  gameController.buttonPressed(value: 6)
 }
 @IBAction func but7(_ sender: Any) {
  gameController.buttonPressed(value: 7)
 }
 @IBAction func but8(_ sender: Any) {
  gameController.buttonPressed(value: 8)
 }
 @IBAction func but9(_ sender: Any) {
  gameController.buttonPressed(value: 9)
 }
 @IBAction func but0(_ sender: Any) {
 }
 
 @IBAction func butX(_ sender: Any) {
  gameController.cancelMove()
 }
 @IBAction func cancelMove(_ sender: Any) {
  gameController.undoLastMove()
 }
 
 @IBOutlet weak var solLabel: UILabel!
 
 @IBAction func SolveSudoku(_ sender: Any) {
  gameController.solveSudoku()
 }
 
 
 @IBOutlet weak var gameLevel: UISegmentedControl!
 
 @IBAction func newGame(_ sender: Any) {
  gameController.newGame(level: gameLevel.selectedSegmentIndex)
 }
 
 @IBOutlet weak var butXOut: UIButton!
 @IBOutlet weak var but1Out: UIButton!
 @IBOutlet weak var but2Out: UIButton!
 @IBOutlet weak var but3Out: UIButton!
 @IBOutlet weak var but4Out: UIButton!
 @IBOutlet weak var but5Out: UIButton!
 @IBOutlet weak var but6Out: UIButton!
 @IBOutlet weak var but7Out: UIButton!
 @IBOutlet weak var but8Out: UIButton!
 @IBOutlet weak var but9Out: UIButton!
 
 var buttonList: [UIButton] = []
 
 
 @IBOutlet weak var raster: Raster!
 @IBOutlet weak var numPad: NumberPad!
 
 @IBOutlet var muisKlik: UITapGestureRecognizer!
 
 @IBAction func muisKlikAction(_ sender: Any) {
  //GPoint touchPoint = [tapRecognizer locationInView: _tileMap]
  var loc = muisKlik.location(in: nil)
  let locGame = muisKlik.location(in: gameBoard)
  
  if loc.x < numberPad.frame.width/2{
   loc.x = numberPad.frame.width/2
  }
  if loc.x > self.view.frame.width-(numberPad.frame.width/2){
   loc.x = self.view.frame.width-(numberPad.frame.width/2)
  }
  numPad.center = loc
  numPad.isHidden = false
  gameController.mouseClick(location: locGame)
  
 }
 
 

 
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
  return 81
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCVCell
  cell.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
  cell.layer.borderWidth = 1
  gameController.addCell(cell:cell)
  return cell
  
 }
 
 override func viewDidLoad() {
  super.viewDidLoad()
  
  
  let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
  layout.minimumInteritemSpacing = 0
  layout.minimumLineSpacing = 0
  
  solLabel.isHidden = true
  
  gameBoard.layer.borderColor = UIColor.orange.cgColor
  gameBoard.layer.borderWidth = 6.0
  gameBoard.layer.cornerRadius = 6.0
  
  but1Out.isEnabled = false
  let globalPoint = gameBoard.superview?.convert(gameBoard.frame.origin, to: nil)
 
  self.view.bringSubviewToFront(raster)
  self.view.bringSubviewToFront(numPad)
  numPad.isHidden = true
  // Do any additional setup after loading the view.
 
   buttonList.append(butXOut)
   buttonList.append(but1Out)
   buttonList.append(but2Out)
   buttonList.append(but3Out)
   buttonList.append(but4Out)
   buttonList.append(but5Out)
   buttonList.append(but6Out)
   buttonList.append(but7Out)
   buttonList.append(but8Out)
   buttonList.append(but9Out)
  
   gameLevel.setTitle("Leeg", forSegmentAt: 0)
   gameLevel.setTitle("Makkelijk", forSegmentAt: 1)
   gameLevel.setTitle("Moeilijk", forSegmentAt: 2)
 
  gameController.setup(numberPad:numberPad, frame: gameBoard.frame, buttonList: buttonList, solLabel: solLabel)
  
 
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  let columns:CGFloat = 9
  let colwidth: CGFloat = collectionView.bounds.width
  let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
  let space = flowLayout.minimumInteritemSpacing * (columns-1)
  let adjustwith = colwidth-space
  let width:CGFloat = floor(adjustwith/columns)
  return CGSize(width: width, height:width)
 }
 
 
}

