//
//  main.swift
//  3L_RaskinSergey
//
//  Created by raskin-sa on 19/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import Foundation

//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
struct automobile {
    //2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
    let v_type: String="Легковой"
    var v_mark:String
    var model: String
    var year: Int
    var trunc_v:Double
    var e_status:engine_status
    var w_status:window_status
    var trunc_filled:Double
    
    enum engine_status{
        case on, off
    }

    enum window_status{
        case opened, closed
    }

    //3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
    enum vehicle_todo{

        enum engine{
            case off
            case on
        }
        
        enum window{
            case closed
            case opened
        }
        enum load{
            case put(weight:Double)
            case take(weight:Double)
        }
    }

    //4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    mutating func switch_engine(iEngine_status:engine_status){
        self.e_status = iEngine_status
        }
    
    //функция добавляет объем заполненного багажника на величину add_volume
    mutating func put_to_trunc(add_volume:Double){
        self.trunc_filled += add_volume
    }
    //функция уменьшает объем заполненного багажника на величину get_volume
    mutating func get_from_trunc(get_volume:Double){
        self.trunc_filled -= get_volume
    }
    
       
    func description()
        {
         var str_back:String
            if ((trunc_filled/trunc_v) <= 0.5) //хулиганство в зав. от объема загрузки двигателя
            {
                if trunc_filled == 0{
                      str_back = "багажник - пустой"
                }
                else{
                     str_back = "багажник почти пустой - в багажник загружено всего : \(trunc_filled) литров"
                }
              
            }
            else{
                str_back = "багажник заполнен - загружено: \(trunc_filled) литров"
            }
            print("Вид транспортного средства: \(v_type), Марка: \(v_mark), Модель: \(model), год: \(year), объем багажника: \(trunc_v) литров, статус двигателя: \(self.e_status), окна: \(self.w_status), \(str_back)")
    }
    
} //конец описания структуры automobile

struct truck {
    //2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
    let v_type: String="Грузовик"
    var v_mark:String
    var model: String
    var year: Int
    var trunc_v:Double
    var e_status:engine_status
    var w_status:window_status
    var trunc_filled:Double
    
    enum engine_status{
        case on, off
    }

    enum window_status{
        case opened, closed
    }

    //Для грузовика не будем создавать структуру с действиями, но добавим два конструктора:
    //для обобщенного грузовика, по дефолту, чтобы не вводить параметры
    init(){
        v_mark = "обобщенный"
        model = "-"
        year = 2000
        trunc_v = 10000
        e_status = engine_status.off
        w_status = window_status.closed
        trunc_filled = 0
    }
    //для грузовика с параметрами
    init(iv_mark:String, imodel: String, iyear: Int, itrunc_v:Double, ie_status:engine_status, iw_status:window_status, itrunc_filled:Double){
        self.v_mark = iv_mark
        self.model = imodel
        self.year = iyear
        self.trunc_v = itrunc_v
        self.e_status = ie_status
        self.w_status = iw_status
        trunc_filled = itrunc_filled
    }
       

    //4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    mutating func switch_engine(iEngine_status:engine_status){
        self.e_status = iEngine_status
        }
    
    //функция добавляет объем заполненного багажника на величину add_volume
    mutating func put_to_trunc(add_volume:Double){
        self.trunc_filled += add_volume
    }
    //функция уменьшает объем заполненного багажника на величину get_volume
    mutating func get_from_trunc(get_volume:Double){
        self.trunc_filled -= get_volume
    }
    
    //функция красиво печатает свойства машины
    func description()
        {
         var str_back:String
            if ((trunc_filled/trunc_v) <= 0.5) //хулиганство в зав. от объема загрузки двигателя
            {
                if trunc_filled == 0{
                      str_back = "багажник - пустой"
                }
                else{
                     str_back = "багажник почти пустой - в багажник загружено всего : \(trunc_filled) литров"
                }
              
            }
            else{
                str_back = "багажник заполнен - загружено: \(trunc_filled) литров"
            }
            print("Вид транспортного средства: \(v_type), Марка: \(v_mark), Модель: \(model), год: \(year), объем багажника: \(trunc_v) литров, статус двигателя: \(self.e_status), окна: \(self.w_status), \(str_back)")
    }
} //конец описания структуры truck

//***************
//ТЕЛО ПРОГРАММЫ
//***************

var honda = automobile (v_mark: "Honda", model: "Civic", year:2018, trunc_v:1500, e_status: .off, w_status: .closed, trunc_filled: 0)
var man = truck (iv_mark: "Man", imodel: "TGA", iyear:2015, itrunc_v:15000, ie_status: .off, iw_status: .closed, itrunc_filled: 12000)
var default_truck = truck()

//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия
//6. Вывести значения свойств экземпляров в консоль.

print("Печатаем свойства машин AS IS")
honda.description()
default_truck.description()
man.description()
print("\nВключаем двигатель хонды")
honda.switch_engine(iEngine_status: automobile.engine_status.on)
print("уменьшаем загрузку MAN")
man.get_from_trunc(get_volume: 500)
print("увеличиваем загрузку обобщенного грузовика")
default_truck.put_to_trunc(add_volume: 3000)
print("\nПечатаем свойства машин по итогам изменений")
honda.description()
man.description()
default_truck.description()
