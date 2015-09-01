//
//  GameViewController.swift
//  Gametris


import UIKit
import SpriteKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate, GametrisDelegate {
    
    var scene: GameScene!
    var gametris: Gametris!
    var refPoint: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        gametris = Gametris()
        gametris.delegate = self
        gametris.beginGame()

        skView.presentScene(scene)
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
    }
    
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.locationInView(self.view).x - self.view.center.x
        
        if let refPoint = refPoint {
            let dx = currentPoint - refPoint
            if abs(dx) > (BlockSize * 0.3) {
                gametris.moveMultile(Int(round(currentPoint / BlockSize)) + 4)
                self.refPoint = currentPoint
            }
        } else if sender.state == .Began {
            refPoint = currentPoint
        }
        
        if sender.state == .Ended {
            gametris.landMultile()
        }
    }
    
    //@IBAction func didSwipe(sender: UISwipeGestureRecognizer) {

    //}
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    /* We favor the gestureRecognizer over otherGestureRecognizer */
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if let swipeRec = gestureRecognizer as? UISwipeGestureRecognizer {
            if let panRec = otherGestureRecognizer as? UIPanGestureRecognizer {
                return true    /* prioritize swipe over pan */
            }
        } else if let panRec = gestureRecognizer as? UIPanGestureRecognizer {
            if let tapRec = otherGestureRecognizer as? UITapGestureRecognizer {
                return true    /* prioritize pan over tap */
            }
        }
        return false
    }
    
    func gameNextMultile() {
        let newShapes = gametris.nextMultile()
        
        scene.addNextMultileToScene(newShapes)
    }
    
    func gameDidBegin(gametris: Gametris) {
        // do things
        
        gameNextMultile()
    }

    func gameMultileDidLand(gametris: Gametris) {
        scene.redrawShape(gametris.newMultile) {
            self.gameNextMultile()
        }
    }
    
    func gameMultileDidMove(gametris: Gametris) {
        scene.redrawShape(gametris.newMultile)
    }
}
