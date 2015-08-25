//
//  Tile.swift
//  Gametris
//

import SpriteKit

// number of Tiles
let numChar = 26


class Tile: Printable {
    
    var letter: Character
    var x: Int
    var y: Int
    var sprite: SKSpriteNode?
    
    init() {
        letter = " "
        x = 0
        y = 0
    }
    
    convenience init(letter: Character) {
        self.init()
        self.letter = letter
    }
    
    convenience init(letter: Character, x: Int, y: Int) {
        self.init(letter: letter)
        self.x = x
        self.y = y
    }
    
    var description: String {
        return "Tile letter: \(letter), x: \(x), y: \(y)"
    }
    
    var spriteName: String {
        return "\(letter)"
    }
    
    func setRandom() {
        letter = Character(UnicodeScalar(65 + arc4random_uniform(3)))
    }
    
    /*
    func setLetter(letter: Character) {
        self.letter = letter
    }
    
    func setXY(xy: (Int, Int)) {
        self.xy = xy
    }
    */
}
