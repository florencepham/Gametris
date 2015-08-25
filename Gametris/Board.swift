//
//  Board.swift
//  Gametris
//
//  Created on 7/6/15.
//  Copyright (c) 2015 Asterisk. All rights reserved.
//

import Foundation

class Board {
    
    var table = Array<Array<Tile?>>()
        
    init() {
        for x in 0..<NumColumns {
            table.append(Array<Tile?>())
            for y in 0..<NumRows {
                table[x].append(nil)
            }
        }
    }
    
    var description: String {
        return table.reduce("") {
            $0 + "\n" + $1.reduce("") {
                $0 + " | " + $1.description
            }
        }
    }
    
    /* Places a tile into the board. */
    func placeTile(tile: Tile) {
        table[tile.x][tile.y] = tile
    }
    
    /* Remove a tile. */
    func clearTile(tile: Tile) {
        tile.letter = "."
    }
    
    /* Remove an array of tiles. */
    func clearTiles(tiles: [Tile]) {
        for tile in tiles {
            clearTile(tile)
        }
    }
    
    /* Clear all tiles. */
    func updateShift() {
        for row in table {
            for tile in row {
                if (tile.letter == ".") {
                    //TODO: other things
                    tile.letter = " "
                }
            }
        }
    }
}

