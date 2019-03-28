//
//  GameScene.swift
//  Jump
//
//  Created by macbook on 2019-02-14.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
 //   private var label : SKLabelNode?
 //   private var spinnyNode : SKShapeNode?
    
    var  sky: EndLessBackground!
    var forest: EndLessBackground!
    var ground: EndLessBackground!
    var girl: SKSpriteNode!
    var dino: SKSpriteNode!
    
    var isOver = false
    var score = 0
    
    
    override func didMove(to view: SKView) {
        
        ground = EndLessBackground(parent: self, sprite: self.childNode(withName: "ground") as! SKSpriteNode, speed: 6)
        forest = EndLessBackground(parent: self, sprite: self.childNode(withName: "forest") as! SKSpriteNode, speed: 3)
        sky = EndLessBackground(parent: self, sprite: self.childNode(withName: "sky") as! SKSpriteNode, speed: 1)
        
        girl = self.childNode(withName:"girl") as! SKSpriteNode!
        dino = self.childNode(withName:"dino") as! SKSpriteNode!

        
        let backgroundMusic = SKAudioNode(fileNamed: "theme.mp3")
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        
        let dino_move = SKAction.moveTo(x: -783, duration: 6)
        dino.run(dino_move, withKey: "dino_run")
        
        physicsWorld.contactDelegate = self
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        ground.update()
        ground.update()
        ground.update()
        
        updateDino()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if girl.physicsBody?.velocity.dy == 0 && !isOver {
            self.run(SKAction.playSoundFileNamed("hit.wav", waitForCompletion: false))
        girl.physicsBody?.applyImpulse((CGVector(dx:0, dy: 90)))
        }
            if isOver {
                for touch in touches {
                    let homeButton = self.childNode(withName: "home") as! SKSpriteNode
                    
                    if homeButton.contains(touch.location (in: self)) {
                        // move player to the Menu Scene
                        
                        
                        if let scene = SKScene(fileNamed: "MenuScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFit
                            
                            // Present the scene
                            
                            self.view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 1))
                        }
                    }
                }
            }
        }
    
    
    func updateDino(){
      if dino.position.x + dino.size.width < 0
        
    {
         self.run(SKAction.playSoundFileNamed("dinosuar.wav", waitForCompletion: false))
         dino.position.x = self.size.width
        
        score += 1
        let scoreLabel = self.childNode(withName: "score") as! SKLabelNode
        
        scoreLabel.text = "Score: \(score)"
        
        dino.removeAction(forKey: "dino_run")
        
        let randomTime = TimeInterval(arc4random_uniform(6) + 3)
        let dino_move = SKAction.moveTo(x: -783, duration: randomTime)
        dino.run(dino_move, withKey: "dino_run")
    }
        
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask  | contact.bodyB.categoryBitMask
  
       if contactMask == 2 | 4 {
               gameOver()
        }
  
    }
  
    func gameOver() {
        isOver = true 
        dino.removeAllActions()
        girl.removeAllActions()
  
        ground.stop()
        forest.stop()
        sky.stop()
        showGameOver()
    }
    
    func showGameOver() {
        let gameOverLabel = self.childNode(withName: "gameover") as! SKLabelNode
        let homeButton = self.childNode(withName: "home") as! SKSpriteNode
        
        gameOverLabel.position.x = (self.view?.center.x)!
        
        homeButton.position.x = (self.view?.center.x)!
        
        
    }
    
    
    
}
