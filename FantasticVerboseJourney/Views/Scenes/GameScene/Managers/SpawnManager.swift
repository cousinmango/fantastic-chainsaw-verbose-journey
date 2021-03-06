//
//  SpawnManager.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit
// Only need to know the initial position? Propotional coordinate system

//extension CGSize {
//    static func *(point: CGSize, scalar: CGFloat) -> CGSize {
//        // multiplied proportion.
//        return CGSize(
//            width: point.width * scalar,
//            height: point.height * scalar
//        )
//    }
//}
class SpawnManager {
    weak var spawnScene: GameScene! // zzzzzzzz
    // let customSeedNumberGenerator
    init(spawnScene: GameScene) {
        self.spawnScene = spawnScene // for adding child.... ruh roh
    }
}

extension SpawnManager {
    func spawn(
        spawnMob: Mob,
        possibleSpawnPositions: [CGPoint] // can have an array of size 1.
    ) {
        let size = spawnScene.size

        // Cheating using CGSize for now.
        guard let scaledSpawn = getScaledSpawn(
            size: size,
            possiblePositions: possibleSpawnPositions
        ) else { return }

        // safe immutable
        guard let node = spawnMob.node.copy() as? SKSpriteNode else {
            fatalError("Node reference type can't copy as SKSpriteNode")
        }

        // CGPoint makes more sense. Validate -300 +300 anchor point positioning coordinate system.
        let scaledSpawnPosition = CGPoint(x: scaledSpawn.width, y: scaledSpawn.height)

        node.position = scaledSpawnPosition

        // the most dangerous part.
        // spawn by adding child to the game scene.
        spawnScene.addChild(node) // NSEXception if adding same reference node to the same scene more than once.
        // initial animation to give life to the sprites
        node.run(spawnMob.initAnimation)
        // - TODO: the little jump boop animation gives a different UX feel depending on the size of the sprite
        // Boop animation should also scale depending on the size.
        // 
    }

    // -- FIXME: Cheating using CGSize when just want the x and y coordinate...
    private func getScaledSpawn(size: CGSize, possiblePositions: [CGPoint]) -> CGSize? {
        let invalidPositionsWarning: String = """
            Array is empty.
            Possible spawn points should be passed as a parameter.
        """
        if possiblePositions.isEmpty {
            fatalError(invalidPositionsWarning)
        }

        // Pick a random spawn position out of possible spawns.
        guard let selectedSpawnPosition = possiblePositions.randomElement() else { return nil } // can use a seed random generator for reproducibility and unit testing consistency. Conform to protocol with predicted .next()

        // recalculating unnecessarily... optimising opportunity cache
        let scaledSpawn = size * selectedSpawnPosition

        // probs won't work .. -340..+340 ???

        return scaledSpawn
    }

}
