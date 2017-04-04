//
//  FifteenBoard.swift
//  Fifteen_puzzle
//
//  Created by Kelly Keniston on 2/12/17.
//  Copyright © 2017 edu.wsu.vancouver. All rights reserved.
//

import UIKit

class FifteenBoard: UIView {

    var state : [[Int]] = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 15, 0] // 0 => empty slot
    ]
    
    func scramble(numTimes n : Int) {
        //Choose one of the “slidable” tiles at random and slide it into the
        //empty space; repeat n times. We use this method to start a new game
        //using a large value (e.g., 150) for n.
        for _ in 0...n {
            var notSlid = true
            while notSlid {
                let randomR = Int(arc4random_uniform(4))
                let randomC = Int(arc4random_uniform(4))
                
                if canSlideTile(atRow: randomR, Column: randomC) {
                    notSlid = false
                    slideTile(atRow: randomR, Column: randomC)
                }
            }
        }
        
    }
    
    //Fetch the tile at the given position (0 is used for the space).
    func getTile(atRow r:Int, atColumn c:Int) -> Int {
        return state[r][c]
    }
    
    //Find the position of the given tile (0 is used for the space) – returns
    //tuple holding row and column.
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        for i in 0...3 {
            for j in 0...3 {
                if state[i][j] == tile {
                    return (i, j)
                }
            }
        }
        return (0, 0)
    }
    
    //Determine if puzzle is in solved configuration.
    func isSolved() -> Bool {
        var count = 1
        for i in 0...3 {
            for j in 0...3 {
                if state[i][j] != count && (i != 3 && j != 3) {
                    return false
                }
                count += 1
            }
        }
        return true;
    }
    
    //Determine if the specified tile can be slid up into the empty space.
    func canSlideTileUp(atRow r : Int, Column c : Int) -> Bool {
        return (r != 0 && state[r - 1][c] == 0)
    }
    
    func canSlideTileDown(atRow r : Int, Column c : Int) -> Bool {
        return (r != 3 && state[r + 1][c] == 0)
    }
    
    func canSlideTileLeft(atRow r : Int, Column c : Int) -> Bool {
        return (c != 0 && state[r][c - 1] == 0)
    }
    
    func canSlideTileRight(atRow r : Int, Column c : Int) -> Bool {
        return (c != 3 && state[r][c + 1] == 0)
    }
    
    //Slide the tile into the empty space.
    func canSlideTile(atRow r : Int, Column c : Int) -> Bool {
        return (canSlideTileUp(atRow: r, Column: c) ||
                canSlideTileDown(atRow: r, Column: c) ||
                canSlideTileLeft(atRow: r, Column: c) ||
                canSlideTileRight(atRow: r, Column: c))
    }
    
    func slideTile(atRow r : Int, Column c : Int) {
        var x = 0
        if canSlideTileUp(atRow: r, Column: c) {
            x = state[r][c]
            state[r-1][c] = x
            state[r][c] = 0
        } else if canSlideTileDown(atRow: r, Column: c) {
            x = state[r][c]
            state[r+1][c] = x
            state[r][c] = 0
        } else if canSlideTileLeft(atRow: r, Column: c) {
            x = state[r][c]
            state[r][c-1] = x
            state[r][c] = 0
        } else if canSlideTileRight(atRow: r, Column: c) {
            x = state[r][c]
            state[r][c+1] = x
            state[r][c] = 0
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
