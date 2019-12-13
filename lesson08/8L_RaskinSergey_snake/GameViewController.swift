//
//  GameViewController.swift
//  8L_RaskinSergey_snake
//
//  Created by raskin-sa on 11/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //создали сцену для игры
        let scene = GameScene(size: view.bounds.size)
        //создали экран
        let skView = view as! SKView
        
        //показывать кол-во объектов
        skView.showsNodeCount = true
        skView.showsFPS = true
        skView.ignoresSiblingOrder = true
        //растянули на весь экран
        scene.scaleMode = .resizeFill
        //отправили сцену на экран
        skView.presentScene(scene)
        
    
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
