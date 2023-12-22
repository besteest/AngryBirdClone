//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Beste on 23.10.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    
    var birdOriginalPosition = CGPoint()
    
    var box1OriginalPosition = CGPoint()
    var box2OriginalPosition = CGPoint()
    var box3OriginalPosition = CGPoint()
    var box4OriginalPosition = CGPoint()
    var box5OriginalPosition = CGPoint()
    
    //çarpışma olunca skor arttırıcaz bu yüzden scoreLabel oluşturuyoruz görünüm içerisine kodla
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32{
        
        //2'nin kuvveti olması gerek
        case Bird = 1
        case Box = 2
        //case Ground = 4
        //case Tree = 8
        
    }
    
    override func didMove(to view: SKView) {
        
        //kodla tasarım
        /*let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: -(self.frame.width / 3), y: -(self.frame.height / 5))
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)*/
        
        //kuş yere değince dursun -> çerçeve yapıyoruz
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        //kuş yere düşünce ekranın çok aşağısında kalıyor -> .aspectFit
        self.scene?.scaleMode = .aspectFit
        //çarpışma için
        self.physicsWorld.contactDelegate = self
        
        //bird
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        let birdTexture = SKTexture(imageNamed: "bird")
        
        //kuşun fiziksel vücudunu yazıyoruz. Yarıçap verdik kuşun boyutunu belirlemek için
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 15)
        //kuşun vücudu yer çekiminden etkilenicek mi başlangıçta -> hayır dokununca -> evet
        bird.physicsBody?.affectedByGravity = false
        //kuşun vücudu hareket edicek mi
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        //kuşun başlangıç konumu
        birdOriginalPosition = bird.position
        
        //çarpışma algılama -> çarpışma yaşandığında bize bildirim verir -> UInt32 istiyor -> enum kullanmak en iyi yol
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        //kiminle çarpışabilir onu söylicez
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        //hangisiyle çarpışabilir, değebilir onu söylicez
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        //boxes
        let boxTexture = SKTexture(imageNamed: "brick")
        let boxSize = CGSize(width: boxTexture.size().width / 7, height: boxTexture.size().height / 7)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        //kuş kutuya çarpınca kutu sağa sola savrulsun istiyoruz
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.2
        
        //kutu ve kuş çarpışsın -> collisionBitMask
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.2
        
        //kutu ve kuş çarpışsın -> collisionBitMask
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.2
        
        //kutu ve kuş çarpışsın -> collisionBitMask
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.2
        
        //kutu ve kuş çarpışsın -> collisionBitMask
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.2
        
        //kutu ve kuş çarpışsın -> collisionBitMask
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box1OriginalPosition = box1.position
        box2OriginalPosition = box2.position
        box3OriginalPosition = box3.position
        box4OriginalPosition = box4.position
        box5OriginalPosition = box5.position
        
        //scoreLabel
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height/4)
        scoreLabel.zPosition = 2
        scoreLabel.fontColor = .black
        self.addChild(scoreLabel)
        
        
        
    }
    
    //çarpışma fonksiyonu
    func didBegin(_ contact: SKPhysicsContact) {
        
        //bodyA & bodyB çarpışan 2 nesne için kullanılıyor
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            //print("contact") -> çarpışma olunca yazıyor ama duvara çarpsa da oluyor
            score += 1
            scoreLabel.text = "Score: \(score)"
            
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    //kuşu uçurma burda yapıcaz dokunmaya başladığı an
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //bir vektör çizerek güç uygulama -> applyForce
        //applyImpulse -> etki uygula
        //bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        //yer çekiminden etkilenmeye dokununca başlasın
        //bird.physicsBody?.affectedByGravity = true
        
        //aynısını touchesMoved & touchesEnded fonksiyonuna da yazıyoruz.
        if gameStarted == false {
            //dokunulan yere kuşu taşıma
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            //gerçekten kuşa dokunuyo mu diye kontrol ediyoruz ekranın herhangi bir yerine de dokunabilir çünkü
                            if sprite == bird {
                                
                                bird.position = touchLocation
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    //kuşu geri çekip yön vermek
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            //dokunulan yere kuşu taşıma
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            //gerçekten kuşa dokunuyo mu diye kontrol ediyoruz ekranın herhangi bir yerine de dokunabilir çünkü
                            if sprite == bird {
                                
                                bird.position = touchLocation
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    //kuşu fırlatmak
    //çektiği yerin tersine fırlatıcaz ve bıraktığı anda fırlatıcaz
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            //dokunulan yere kuşu taşıma
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            //gerçekten kuşa dokunuyo mu diye kontrol ediyoruz ekranın herhangi bir yerine de dokunabilir çünkü
                            if sprite == bird {
                                //başlangıçtan nereye kadar çekti ona göre etki vericez çünkü
                                let dx = -(touchLocation.x - birdOriginalPosition.x)
                                let dy = -(touchLocation.y - birdOriginalPosition.y)
                                //etki
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    //kuş düşünce yerine geri dönsün -> sürekli kontrol edilmesi gerektiği için buraya yazıcaz
    override func update(_ currentTime: TimeInterval) {
        
        //bird.physicsBody optional olmasın
        if let birdPhysicsBody = bird.physicsBody {
            
            //kuşun hızı -> bu if bloğunda diyoruz ki kuş durmak üzereyse -> angularVelocity -> açısal hız
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                birdPhysicsBody.affectedByGravity = false
                
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                birdPhysicsBody.angularVelocity = 0
                box1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                box1.physicsBody?.angularVelocity = 0
                box2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                box2.physicsBody?.angularVelocity = 0
                box3.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                box3.physicsBody?.angularVelocity = 0
                box4.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                box4.physicsBody?.angularVelocity = 0
                box5.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                box5.physicsBody?.angularVelocity = 0
                
                bird.position = birdOriginalPosition
                box1.position = box1OriginalPosition
                box2.position = box2OriginalPosition
                box3.position = box3OriginalPosition
                box4.position = box4OriginalPosition
                box5.position = box5OriginalPosition
                bird.zPosition = 0
                gameStarted = false
                score = 0
                scoreLabel.text = "Score: \(score)"
                
            }
            
        }
        
    }
}
