//
//  GameScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let hudOverlay = HudNode()
    let spawnManager = SpawnManager()
    override init() {
        super.init()
    }
    override init(size: CGSize) {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func sceneDidLoad() {

        let scaleFactor = size.height * 0.25
        spawnManager.spawn(spawnScene: <#T##GameScene#>, mob: <#T##Mob#>, possibleSpawnPositions: <#T##[CGPoint]#>)
    }
    override func didMove(to view: SKView) {

    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }

}

extension GameScene {

    fileprivate func startMusic() {
        guard let musicUrl = SoundAssetUrl.gameMusicUrl else { return }

        let gameMusic = SKAudioNode(url: musicUrl)
        addChild(gameMusic)
    }

    
    func spawnFireball(
        position: CGPoint,
        destination: CGPoint,
        angle: CGFloat
        ) {
    }

    func createBackgroundAnimation() -> SKAction {
        let randomColourAnimationIDontKnow = SKAction.sequence(
            [
                SKAction.colorize(
                    with: UIColor(
                        hue: 0.15,
                        saturation: 1,
                        brightness: 0.5,
                        alpha: 1
                    ),
                    colorBlendFactor: 0.3,
                    duration: 0
                ),
                SKAction.colorize(
                    with: UIColor.black,
                    colorBlendFactor: 0,
                    duration: 0.5
                )
            ]
        )

        return randomColourAnimationIDontKnow
    }

}
// - MARK: Setup helpers
extension GameScene {

    private func setup() {
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        // HUD setup
        hudOverlay.setup(size: size)
        addChild(hudOverlay)
        hudOverlay.resetPoints()

    }
}

// - MARK: Touches responders
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesBegan start")

        print("GameScene:: touchesBegan finish")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesEnded start")

        guard let firstTouch = touches.first else { return }
        let touchLocationInScene = firstTouch.location(in: self)

        print("GameScene:: touchesEnded finish", touchLocationInScene)
    }
}
