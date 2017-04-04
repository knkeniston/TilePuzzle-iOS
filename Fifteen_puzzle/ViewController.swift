//
//  ViewController.swift
//  Fifteen_puzzle
//
//  Created by Kelly Keniston on 2/12/17.
//  Copyright © 2017 Kelly Keniston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var boardView: BoardView!
    
    @IBAction func tileSelected(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board // get model from app delegate
        let pos = board!.getRowAndColumn(forTile: sender.tag)
        let buttonBounds = sender.bounds
        var buttonCenter = sender.center
        var slide = true
        if board!.canSlideTileUp(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.y -= buttonBounds.size.height
        } else if board!.canSlideTileDown(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.y += buttonBounds.size.height
        } else if board!.canSlideTileLeft(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.x -= buttonBounds.size.width
        } else if board!.canSlideTileRight(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.x += buttonBounds.size.width
        } else {
            slide = false
        }
        UIView.animate(withDuration: 0.5, animations: {sender.center = buttonCenter})
        if slide { // update model and view
            board!.slideTile(atRow: pos!.row, Column: pos!.column)
            sender.center = buttonCenter // animate later
            if (board!.isSolved()) { /*throwAPartyOnWin()*/ }
            //...
        }
    }
    
    @IBAction func shuffleTiles(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board
        board?.scramble(numTimes: appDelegate.numShuffles)
        self.boardView.setNeedsLayout() // will trigger layoutSubviews to be invoked
    }
    
    /*override func awakeFromNib() {
        let tileImage = UIImage(named: "Tile")
        for tag in 1 ... 15 {
            //let button = self.viewWithTag(tag) as! UIButton
            //button.setBackgroundImage(tileImage, for: UIControlState())
            //button.backgroundColor = UIColor.clear // transparent
        }
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

