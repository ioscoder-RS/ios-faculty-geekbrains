//
//  GameScene.swift
//  8L_RaskinSergey_snake
//
//  Created by raskin-sa on 11/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategory{
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead:UInt32 = 0x1 << 1
    static let Apple:UInt32 = 0x1 << 2
    static let EdgeBody:UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var snake:Snake?
    
    //private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var isEndGame: Bool = false
    
    let shiftForButton:CGFloat = 45
    //края игры
    private var xStartPosition:CGFloat = 0.0
    private var yStartPosition:CGFloat = 0.0
    private var gameRectWidth:CGFloat = 0.0
    private var gameRectHeight:CGFloat = 0.0
     private var gameRect:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    //текстовое поле в центре экрана
     var risedTextNode = SKLabelNode(fontNamed: "Chalkduster")
     var risedScoreNode = SKLabelNode(fontNamed: "Chalkduster")
    
    
    //счет игры
    var score:Int = 0
    
    var apple : SKShapeNode?
    
    override func didMove(to view: SKView) {
        // первое появление сцены на экране
        backgroundColor = SKColor.black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
//////////
////////// кнопка поворачивает змейку против часовой стрелки
/////////
           let leftCounterClockwiseButton = SKShapeNode()
           //форма кнопки - круглая
               leftCounterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
          //координаты размещения нашей кнопки
               leftCounterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30) // 30 - отступ от нижнего левого угла экрана
           //цвет кнопки
               leftCounterClockwiseButton.fillColor = UIColor.gray
           //цвет рамки
               leftCounterClockwiseButton.strokeColor = UIColor.gray
           //ширина
               leftCounterClockwiseButton.lineWidth = 10
           //имя кнопки
           leftCounterClockwiseButton.name = "leftCounterClockwiseButton"
           //добавляем на экран
           self.addChild(leftCounterClockwiseButton)
        
//////////
//////////  кнопка поворачивает змейку по часовой стрелки
/////////
           let clockWiseButton = SKShapeNode()
           //форма кнопки - круглая
               clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
            //координаты размещения нашей кнопки
          clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX-80, y: view.scene!.frame.minY+30) // 30 - отступ от нижнего левого угла экрана
            //цвет кнопки
                clockWiseButton.fillColor = UIColor.gray
            //цвет рамки
                clockWiseButton.strokeColor = UIColor.gray
            //ширина
                clockWiseButton.lineWidth = 10
            //имя кнопки
            clockWiseButton.name = "clockWiseButton"
           self.addChild(clockWiseButton)
           
           //края сцены c учетом кнопок
           xStartPosition = view.scene!.frame.minX
           yStartPosition = view.scene!.frame.minY+shiftForButton
           gameRectWidth = view.scene!.frame.maxX - xStartPosition
            gameRectHeight = view.scene!.frame.maxY - yStartPosition - 100
        
           gameRect = CGRect(x: xStartPosition, y: yStartPosition, width: gameRectWidth, height: gameRectHeight)
        
//////////
////////            физический объект прямоугольник с краями игры, касание которого приводит к окончанию игры
///////
            let quad = SKShapeNode(rect: gameRect)
           quad.position = CGPoint(x:xStartPosition, y: yStartPosition) // задаем позицию.
           quad.lineWidth = 4 // задаем размер линий.
           quad.strokeColor = UIColor.green // задаем цвет контура.
           quad.fillColor = UIColor.black // задаем цвет внутренности.
           
           quad.physicsBody = SKPhysicsBody(edgeLoopFrom: gameRect)
           quad.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody //края экрана
           quad.physicsBody?.collisionBitMask = CollisionCategory.Snake|CollisionCategory.SnakeHead
           quad.name = "Quad" // задаем имя.
           self.addChild(quad) // добавляем наш объект на нашу сцену.
        
///////////////
 ////////// //  текст сообщения о конце игры
////////////
        risedTextNode.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY)  // задаем позицию.
        risedTextNode.fontSize = 18; // задаем размер шрифта.
        risedTextNode.fontColor = UIColor.white // задаем цвет шрифта.
        risedTextNode.color = UIColor.blue // задаем цвет (Нужен для сочетание с colorBlendFactor).
        risedTextNode.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        risedTextNode.numberOfLines = 3
        risedTextNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center  // задаем способ выравнивание текста.
        risedTextNode.name = "First" // задаем имя спрайта
    // !!! но на экран не выводим раньше времени, пока игра не закончилась
        
///////////////
////////// // //текст сообщения о счете игры
////////////
        risedScoreNode.position =  CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.minY+30) // задаем позицию = между двумя кнопками
        risedScoreNode.fontSize = 18; // задаем размер шрифта.
        risedScoreNode.fontColor = UIColor.white // задаем цвет шрифта.
        risedScoreNode.color = UIColor.blue // задаем цвет (Нужен для сочетание с colorBlendFactor).
        risedScoreNode.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        risedScoreNode.text = "счет: \(score)" // задаем текст.
        risedScoreNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center  // задаем способ выравнивание текста.
        risedScoreNode.name = "Score" // задаем имя спрайта
        self.addChild(risedScoreNode) // добавляем наш спрайт на нашу сцену.
        //инициализация змейки и яблока
        startGame()
        
    }//func didMove
    
    func createApple(){
        let randX =  CGFloat(arc4random_uniform(UInt32(gameRect.maxX)))
        
        var randY:UInt32
        randY = arc4random_uniform(UInt32(gameRect.maxY))
        if randY <= 100{randY = 101} //чтобы яблоко не попадало за пределы прямоугольника
        
        
        apple = Apple(position: CGPoint(x: randX, y: CGFloat(randY)))
        self.addChild(apple!)
        
        //отладочный принт
     //   print("randX = \(randX),randY = \(randY) gameRect.minX = \(gameRect.minX), gameRect.maxX= \(gameRect.maxX), gameRect.minY = \(gameRect.minY),gameRect.maxY = \(gameRect.maxY), gameRect.width = \(gameRect.width), gameRect.height = \(gameRect.height),xStartPosition = \(xStartPosition), yStartPosition = \(yStartPosition), shiftForButton = \(shiftForButton)")
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches{
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "leftCounterClockwiseButton" || touchesNode.name == "clockWiseButton" else{
                return
            }
            
            touchesNode.fillColor = UIColor.green
            
            //если конец игры наступил, то левая кнопка - начинает игру заново
            if touchesNode.name == "leftCounterClockwiseButton"{
                if isEndGame{
                    isEndGame = false
                    startGame()
                }else{
                snake!.moveCounterClockwise()
                }
            }else if touchesNode.name == "clockWiseButton"{
                snake!.moveClockwise()
            }
        }
    }//func touchesBegan
    
 
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //если касаемся кнопки - красим кнопку в зеленый цвет
        for touch in touches{
            let touchLocation = touch.location(in: self)
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "leftCounterClockwiseButton" || touchesNode.name == "clockWiseButton" else{
                return
            }
            
            touchesNode.fillColor = UIColor.gray
            
        }
   
    }//func touchesEnded
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
 
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // если не выставлен флаг конец игры, то змея двигается. Иначе - нет
        if !isEndGame{
            snake!.move()
        }
    }

//функция инициализирует элементы сцены и вначале и когда надо начать новую игру после поражения
    func startGame(){
        risedTextNode.removeFromParent()
        snake?.removeFromParent()
        apple?.removeFromParent()
        score = 0
        riseScoreMessage(iScore: score)
        createApple()
        //
        snake = Snake(atPoint: CGPoint(x: (view?.scene!.frame.midX)!, y: (view?.scene!.frame.midY)!))
        
        self.addChild(snake!)
    }// func startGame
    
    func riseMessage(messageText:String) {
      risedTextNode.text = messageText // задаем текст.
      self.addChild(risedTextNode) // добавляем наш спрайт на нашу сцену.
    }// func riseMessage
    
    func riseScoreMessage(iScore: Int) {
       risedScoreNode.text = "счет: \(iScore)" // задаем текст.
     }// func riseScoreMessage
}//class GameScene


extension GameScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
      let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
      let collisionObject = bodyes ^ CollisionCategory.SnakeHead
    var appleNode: SKNode?
    
    appleNode = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
    
      switch collisionObject {
      case CollisionCategory.Apple: //голова столкнулась с яблоком

          snake?.addBodyPart()
          
          appleNode?.removeFromParent()
          score += 1
          riseScoreMessage(iScore: score)
          createApple()
          
      case CollisionCategory.EdgeBody:
          isEndGame = true
          appleNode?.removeFromParent()
          //к сожалению, для многострочного текста надо вручную будет выставлять координаты каждой последующей строки
          //решил код не перегружать, поэтому текст простой
          riseMessage(messageText: "Конец игры! Нажмите левую кнопку")
        
          //передаем управление функции нажатия левой кнопки -> func touchesBegan
        
      default: break
        
      }//switch
  }//func
}//extension
