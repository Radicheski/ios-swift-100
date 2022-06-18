//
//  GameScene.swift
//  Project11
//
//  Created by Erik Radicheski da Silva on 18/06/22.
//

import SpriteKit

class GameScene: SKScene {

    var editLabel: SKLabelNode!

    var editingMode = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }

    var newGameLabel: SKLabelNode!

    var availableBallColors = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]

    var scoreLabel: SKLabelNode!

    var ballLimit = 5

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

        physicsWorld.contactDelegate = self

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)

        newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
        newGameLabel.text = "New Game"
        newGameLabel.position = CGPoint(x: 530, y: 700)
        addChild(newGameLabel)
    }

    func makeBouncer( at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.position = position
        bouncer.physicsBody?.isDynamic = false

        addChild(bouncer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let objects = nodes(at: location)
            if objects.contains(editLabel) {
                editingMode.toggle()
                return
            } else if objects.contains(newGameLabel) {
                ballLimit = 5
                score = 0
                children.filter { $0.name == "obstacle" }.forEach { destroy($0) }
                return
            }

            if editingMode {
                createBox(at: location)
            } else {
                createBall(at: location)
            }
        }
    }

    func createBox(at location: CGPoint) {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        let box = SKSpriteNode(color: color, size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location

        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false

        box.name = "obstacle"

        addChild(box)
    }

    func createBall(at location: CGPoint) {
        if ballLimit <= 0 { return }

        guard let ballColor = availableBallColors.randomElement() else { return }
        let ball = SKSpriteNode(imageNamed: ballColor)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.restitution = 1.01
        var position = CGPoint(x: location.x, y: 0.8 * frame.height)
        ball.position = position

        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0

        ball.name = "ball"

        ballLimit -= 1

        addChild(ball)
    }

    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }

        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        slotBase.position = position
        slotGlow.position = position

        addChild(slotBase)
        addChild(slotGlow)

        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            score += 1
            ballLimit += 1
            destroy(ball)
        } else if object.name == "bad" {
            score -= 1
            destroy(ball)
        } else if object.name == "obstacle" {
            destroy(object)
        }
    }

    func destroy(_ node: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = node.position
            addChild(fireParticles)
        }
        node.removeFromParent()
    }

}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node else { return }
        guard let bodyB = contact.bodyB.node else { return }

        if bodyA.name == "ball" {
            collision(between: bodyA, object: bodyB)
        } else if bodyB.name == "ball" {
            collision(between: bodyB, object: bodyA)
        }
    }

}
