//
//  Multile.swift
//  Gametris
//
//  Created by Nga Pham on 7/20/15.
//  Copyright (c) 2015 Asterisk. All rights reserved.
//

import SpriteKit


enum Orientation: Int, Printable {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        return "\(self.rawValue)"
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue: Int(arc4random_uniform(3)))!
    }
}

class Multile {
    
    var tiles = Array<Tile>()
    var numTiles: Int!
    var orientation: Orientation
    
    init(numTiles: Int) {
        self.numTiles = numTiles
        orientation = Orientation.random()
        for i in 0 ..< numTiles {
            tiles.append(Tile())
            tiles[i].setRandom()
            tiles[i].x = 4      // fix later for 2+ blocks
            tiles[i].y = 14
        }
    }
    
    var description: String {
        return tiles.map{$0.description}.reduce("", combine: +)
    }
    
    func rotate() {
        orientation = Orientation(rawValue: ((orientation.rawValue + 1) % 4))!
    }
    
}

