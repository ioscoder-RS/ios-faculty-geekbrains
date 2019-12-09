//
//  main.swift
//  7L_RaskinSergey
//
//  Created by raskin-sa on 09/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

enum dealerCenterError: Error {
    case invalidSelection (modelRequested:String)
    case insufficientAmonut(amountNeeded:Double)
    case outOfStock
}

struct autoItem{
    var price:Double //в миллионах
    var count:Int
}

class dealerCenter{
    var car = [
        "Polo": autoItem(price: 0.9, count: 20),
        "Jetta": autoItem(price: 1.2, count: 25),
        "Golf": autoItem(price: 2.0, count: 0)
    ]
    
    var amountPaid = 0.0
    
    func buyAuto(autoItem name:String) throws{
        guard let autoItem = car[name] else {
            throw dealerCenterError.invalidSelection (modelRequested: name)
        }
        guard autoItem.count > 0 else {
            throw dealerCenterError.outOfStock
        }
        guard autoItem.price <= amountPaid else {
            throw dealerCenterError.insufficientAmonut(amountNeeded: autoItem.price - amountPaid)
        }
        
        amountPaid -= autoItem.price
        
        var newItem = autoItem
        newItem.count -= 1
        car[name] = newItem
        print("Выдали: \(name)")
        
    }//func buyAuto throws
}//class dealerCenter

let favoriteCar = [
    "Ivan":"Golf",
    "Katya":"Polo",
    "Oleg":"Tiguan", //его нет = ошибка
]

func byFavoriteCar(person: String, carToBuy: dealerCenter) throws -> String {
    let carName = favoriteCar[person] ?? "other"
    try carToBuy.buyAuto(autoItem: carName)
    return carName //не используется, но как пример синтаксиса
}

var localDealer = dealerCenter()
localDealer.amountPaid = 2.0


do{
  
     try  byFavoriteCar(person: "Oleg", carToBuy: localDealer)
}catch dealerCenterError.invalidSelection(let carName) {
    //к сожалению внутри catch переменные не умеют использовать значения, полученные в try. Результат можно использовать только вовне do-try-catch
    print("ошибка выбора. В салоне нет такой модели \(carName)")
} catch dealerCenterError.outOfStock{
    print("Автомобилей больше нет")
} catch dealerCenterError.insufficientAmonut(let amountNeeded){
    print ("Недостаточно средств. Пожалуйста добавьте еще \(amountNeeded) рублей")
}


