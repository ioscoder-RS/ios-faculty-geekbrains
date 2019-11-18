//
//  main.swift
//  2l_RaskinSergey
//
//  Created by raskin-sa on 17/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import Foundation
//функция определяет число четное или нет
func IsEven(in_digit:Int)->Bool
{
    if in_digit%2 == 0{
        return true
        }
    else{
        return false
    }
}

//функция определяет число делится на три или нет
func IsDividedByThree (in_digit:Int)->Bool{
    if in_digit%3 == 0{
        return true
        }
    else{
        return false
    }
}

//функция добавляет число Фибоначчи в массив на входе
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
var initial_set100:Set<Int>=[0] //для будущего массива простых чисел

for i in (1...100){
    workarray.append(i)
    initial_set100.insert(i)//пригодится в задаче для массива простых чисел
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

//Задача сформировать массив простых чисел
print("Создаем массив простых чисел")

//print(initial_set100.count)//в это множество ранее закачали числа от 1 до 100
var set_to_remove:Set<Int>=[0] //в это множество закачиваем "не простые" числа, которые потом вычеркнем
var i_step:Int=2

i = 0

for i in (2...100){
    if initial_set100.contains(i)// в это множество ранее мы закачали числа от 1 до 100
    {
        for i_step in stride(from: i, to: 101, by: i)//удаляем цифры последовательно с шагом 2,3,4... после вычитания множеста set_to_remove в исхоном множестве останутся только простые числа
        {
            if i_step != i { //что-бы само простое число не удалить
            set_to_remove.insert(i_step)
            }
        }//for
        initial_set100 = initial_set100.subtracting(set_to_remove)
    }//if initial_set100.contains(i)
    
  //  print("i= " + String(i))
 //   print(initial_set100)
}
//print("Результирующее множество простых чисел от 1 до 100")
//print(initial_set100)

//копируем в массив
curr_array.removeAll() //обнуляем то, что раньше в нем было
for i in (0...100)
{
    if initial_set100.contains(i)
    {
    curr_array.append(Double(i))
    }
}
print("Результирующий массив простых чисел от 1 до 100")
print(curr_array)
