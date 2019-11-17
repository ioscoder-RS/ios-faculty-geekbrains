//main.swift

//  L1_RaskinSergey
//  Created by raskin-sa on 17/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import Foundation

//Функция решения квадратного уравнения
func solve (a:Double, b:Double, c: Double) -> Bool
{
var discr:Double = 0
var x1:Double = 0
var x2:Double = 0

print("\nрешаем уравнение ax^2+bx+c=0")

print("a = "+String(a)+";b = "+String(b)+";c = "+String(c))

//вычисляем дискриминант
discr = b*b-4*a*c
print("Дискриминант = "+String(discr))

if discr < 0 {
    print("Дискриминант меньше 0, у уравнения решений нет!")
    return false
}

else {
x1 = (-(b)+sqrt(discr)) / (2*a)
x2 = (-(b)-sqrt(discr)) / (2*a)
print("Решение: x1 = "+String(x1)+"; x2 = "+String(x2))
}

    return true
}


//функция вычисления треугольника по катетам

func calc_triangle(katet1:Double, katet2: Double) -> Bool {

    var hypotenus:Double
    var square_t:Double
    var perimetr:Double

print("\nрешаем прямоугольный треугольник по двум катетам")

    if (katet1 <= 0)||(katet2 <= 0) {
        print ("Значение каждого из катетов должно быть положительным числом")
        print ("катет1 = " + String(katet1)+" катет2 = " + String(katet2))
        return false
    }

    print ("Дано: Катет 1 = "+String(katet1)+"; Катет2 = "+String(katet2))

    hypotenus = sqrt(katet1*katet1 + katet2*katet2)
    print ("Гипотенуза равна = " + String(hypotenus))

    square_t = (katet1 * katet2)/2
    print ("Площадь равна = " + String(square_t))

    perimetr = katet1 + katet2 + hypotenus
    print ("Периметр равен = " + String(perimetr))

    return true
}

func calc_bank_5y_deposit(amount:Double, interest:Double) -> Double{
    var y_count:Int=1
    var newAmount:Double = amount
    
    print("\nВычисляем размер 5-летнего вклада")
    print ("Дано: Начальный взнос = "+String(amount)+"; % ставка = "+String(interest*100)+"%")

    if (amount <= 0)||(interest <= 0) {
        print ("Значения суммы вклада и процентной ставки должны быть положительными числами")
        print ("Начальный взнос = "+String(amount)+"; % ставка = "+String(interest))
        return -1
    }

    for y_count in (1...5){
        newAmount = newAmount * (1 + interest)
 //       print ("После года № "+String(y_count)+" размер вклада составляет: " + String(newAmount))
    }

    print("Новый размер депозита через 5 лет равен: " + String(newAmount) )

    return newAmount
}

//тело программы

//вызов функции решения квадратного уравнения
solve(a:5,b:3,c:0)

//вызов функции решения треугольника по двум катетам
calc_triangle(katet1: 3, katet2: 5)

//вызов функции расчета вклада c пользовательским вводом
var inputdeposit:Double?=nil
var inputinterest:Double?=nil

while inputdeposit == nil { //не даем ввести неверное значение
    print("\nВведите размер депозита в рублях (разделитель десятичных знаков - точка):\n")
    let dep1 = readLine()
    inputdeposit = Double(dep1!)
}


while inputinterest == nil { //не даем ввести неверное значение
    print("Введите размер процентной ставки (от 0 до 1, разделитель десятичных знаков - точка):\n")
    let int1 = readLine()
    inputinterest = Double(int1!)
}

calc_bank_5y_deposit(amount: inputdeposit!, interest: inputinterest!)


