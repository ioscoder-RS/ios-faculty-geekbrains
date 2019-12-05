//
//  main.swift
//  6L_RaskinSergey
//
//  Created by raskin-sa on 04/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import Foundation

//протокол и расширение для красивой печати
protocol consolePrintable:CustomStringConvertible {
    func printDescription()
    }

extension consolePrintable{
    func printDescription(){
        print(description)
    }
}

//протокол, содержащий стоимость для классов
protocol pricevalue {
    var price: Double {get set}
    var inputString: String {get set}
}

//делаем класс: строка со стоимостью
class ClassArrayString:pricevalue{

    var price: Double
    var inputString: String
    
  
    init(inputString: String, price:Double){
//        self.localstring = inputString
        self.inputString = inputString
        self.price = price
    }
}

//наследник для работы с массивами Int
class ClassArrayInt:ClassArrayString{
    
    init(inputInt:Int, price:Double){
        super .init(inputString: String(inputInt), price: price)
    }
}



//Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

struct Queue<Element:pricevalue>: consolePrintable {                                   // коллекция типа "очередь": Last In First Out
    private var elements = [Element]()

    mutating func push(_ item: Element) { // добавляем элемент в конец массив а
        elements.append(item)
    }
    mutating func pop() -> Element? {      // извлекаем первый элемент из массива
        return elements.removeFirst()
    }
    
    //Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
    
    //функция, заданная через замыкание будет считать суммарную стоимость массива
    var totalPrice : Double {
        var price = 0.0
        for element in elements {
            price += element.price
        }
        return price
    }// var totalPrice definition
    
    //функция, заданная через замыкание будет выводить все элементы на печать
    var description: String {
        var lstr = "Элементы: "
        for element in elements {
            lstr += (" \(element.inputString)")
        }
        lstr += ". Суммарная стоимость массива: \(totalPrice)"
          return lstr
    }//var description definition

  //  *Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

     subscript(elements: Int) -> Bool? {

         if elements > self.elements.count {
         return nil
         }
         return true
     }
    
}// struct definition


print("Массив строчных значений и его стоимость")
var tempArrayString = Queue<ClassArrayString>()
//var tempArrayInt = Queue<Int>()

tempArrayString.push(ClassArrayString(inputString: "Один", price: 1.0))
tempArrayString.push(ClassArrayString(inputString: "Семь", price: 12.0 ))
tempArrayString.printDescription()

print("Массив числовых значений и его стоимость")
var tempArrayInt = Queue<ClassArrayInt>()
tempArrayInt.push(ClassArrayInt(inputInt: 1, price: 1.0))
tempArrayInt.push(ClassArrayInt(inputInt: 7, price: 12.0 ))
tempArrayInt.printDescription()

print("проверяем сабскрипт c правильным индексом")
var correctindex = tempArrayString[2]
print("\(String(describing: correctindex))")

print("проверяем сабскрипт c неправильным индексом")
correctindex = tempArrayInt[3]
print("\(String(describing: correctindex))")

print("проверяем сабскрипт на пустом массиве")
tempArrayString.pop()
tempArrayString.pop()
correctindex = tempArrayString[1]
print("\(String(describing: correctindex))")
