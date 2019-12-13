//
//  Messages.swift
//  8L_RaskinSergey_snake
//
//  Created by raskin-sa on 12/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit
import Foundation

class GameMessage :UIViewController {
    
    convenience init (titleText: String, messageText:String) {
        
        self.init()
    
    // Создаем контроллер
     let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
     // Создаем кнопку для UIAlertController
     let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     // Добавляем кнопку на UIAlertController
     alert.addAction(action)
     // Показываем UIAlertController
     present(alert, animated: true, completion: nil)
    } //convenience init
    
}
