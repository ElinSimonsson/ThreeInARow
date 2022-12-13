//
//  Board.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-12-02.
//

import Foundation

class Cell {
    var rowAndColumn: Int
    
    init(rowAndColumn: Int) {
        self.rowAndColumn = rowAndColumn
    }
}

// in this game, every cell have a number with both of (row) + (column). see below

// 11,12,13
// 21,22,23
// 31,32,33
