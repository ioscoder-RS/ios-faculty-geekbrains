//
//  main.swift
//  2l_RaskinSergey
//
//  Created by raskin-sa on 17/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import Foundation

func IsEven(in_digit:Int)->Bool
{
    if in_digit%2 == 0{
        return true
        }
    else{
        return false
    }
}

func IsDividedByThree (in_digit:Int)->Bool{
    if in_digit%3 == 0{
        return true
        }
    else{
        return false
    }
}

//добавляем число Фибоначчи в массив на входе
func add_fib(input_array:[Double])->[Double]
{
var fib_1: Double
var fib_2: Double
var fib_sum: Double
let fib_max_index:Int = input_array.count
var new_array : [Double] = input_array

fib_1 = input_array[fib_max_index-1]
fib_2 = input_array[fib_max_index-2]
//print("fib_1= " + String(fib_1)+" fib_2= " + String(fib_2))
fib_sum = fib_1 + fib_2
new_array.append(fib_sum)

return new_array
}

///
///ТЕЛО ПРОГРАММЫ
///
////

print("Создаем массив от 1 до 100 с удаленными четными числами и числами, не делящимися на 3")
//создаем массив из 100 чисел
var workarray = [Int]()
var i:Int
var maxIndex:Int = 99

for i in (1...100){
    workarray.append(i)
}

//удаляем четные числа
for i in (0...99){
    if i>maxIndex {
        break
    }
    if IsEven(in_digit: workarray[i]) {
        workarray.remove(at:i)
        maxIndex -= 1
    }
    }

//удаляем числа, не делящиеся на 3
i = 0
maxIndex = workarray.count - 1

while i < maxIndex
    {
        if !(IsDividedByThree(in_digit: workarray[i])){
 //       print("Удаляем элемент с №: " + String(i) + " его значение = " + String(workarray[i]))
        workarray.remove(at:i)
        maxIndex -= 1
        }else{
        i += 1
        }
}

print(workarray)// это массив от 1 до 100 с удаленными четными числами и числами, не делящимися на 3


//создаем новый пустой массив Double для 100 чисел Фибоначчи
//в Int - не помещается
var curr_array = [Double]()
var prev_array :[Double] = [1,2]

print("добавляем 100 чисел Фибоначчи")

for _ in (1...100){
    curr_array = add_fib(input_array:prev_array)
    prev_array = curr_array
}
print(curr_array)



