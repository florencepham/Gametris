//
//  Gametris.swift
//  Gametris


let NumColumns = 9
let NumRows = 15

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

let PointsPerLine = 10
let LevelThreshold = 1000

protocol GametrisDelegate {
//    func gameDidEnd(gametris: Gametris)
    func gameDidBegin(gametris: Gametris)
    func gameMultileDidMove(gametris: Gametris)
    func gameMultileDidLand(gametris: Gametris)
//    func gameShapeDidDrop(gametris: Gametris)
//    func gameDidLevelUp(gametris: Gametris)
}

class Gametris {
    
    var board: Board
    var newMultile: Multile
    var delegate: GametrisDelegate!
    
    var score: Int
    var level: Int
    
    init() {
        board = Board()
        newMultile = Multile(numTiles: 1)
        score = 0
        level = 1
    }
    
    func beginGame() {
        println("beginGame")
        delegate.gameDidBegin(self)
    }
    
    func nextMultile() -> Multile {
        println("nextMultile")
        newMultile = OneTile()
        return newMultile
    }
    
    func moveMultile(x: Int) {
        println("moveMultile")
        for tile in newMultile.tiles {
            tile.x = min(max(x, 0), 8)
        }
        delegate.gameMultileDidMove(self)
    }
    
    func crash() {} //TODO: rename
    
    func landMultile() {
        println("landMultile")
        for tile in newMultile.tiles {
            let foundTile = find(board.table[tile.x]) {
                (tile: Tile) -> Bool in
                tile.letter == " "
            }

            let landY = (foundTile != nil) ? foundTile!.y : 0
            //println("xv2: \(tile.x) yv2: \(tile.y)")

            tile.y = (landY)
            board.placeTile(tile)
        }
        
        delegate.gameMultileDidMove(self)     //TODO: later, use a different animation
        delegate.gameMultileDidLand(self)
    }
}

func find<T>(arr: Array<T>, pred: T -> Bool) -> T? {
    println("Find")
    for i in 0..<arr.count {
        if pred(arr[i]) { return arr[i] }
    }
    return nil
}