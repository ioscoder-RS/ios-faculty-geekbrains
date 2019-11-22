//
//  main.swift
//  4L_RaskinSergey
//
//  Created by raskin-sa on 22/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//



    
//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportCar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

class Car {
    
        //Берем перечисление из прошлого урока, переписываем в объединенное перечисление, которое потом будем переопределять
    enum engine_status:CustomStringConvertible
    {
           case on, off
        
        var description: String
        {
        switch self{
        case .on: return "включен"
        case .off: return "выключен"
        }
    }
    }//enum engine_status
    
    enum window_status:CustomStringConvertible
    {
           case open, close
        
        var description: String
        {
            switch self
            {
            case .open : return "открыто"
            case .close: return "закрыто"
            }
        }
    }// enum window_status
        
        enum action
        {
            case SwitchEngine(engine_status)
            case SwitchWindow(window_status)
            case put_to_trunc(Double) //будет только для грузовиков
            case get_from_trunc(Double)//будет только для грузовиков
            case SwitchTurbo(Bool)//будет только для спорткаров
            case AddAxle(Bool)//будет только для спорткаров
        }
    
    let v_type: String //легковой или грузовой
    let v_mark:String
    let model: String
    let transmission: String
    var year: Int
    var trunc_v:Double
    var e_status: engine_status
    var w_status: window_status
    var trunc_filled:Double
    
    init(
        iv_type: String,
        iv_mark: String,
        imodel: String,
        itransmission: String,
        iyear: Int,
        itrunc_v: Double,
        ie_status: engine_status,
        iw_status: window_status,
        itrunc_filled: Double
    )
    {
        self.v_type = iv_type
        self.v_mark = iv_mark
        self.model = imodel
        self.transmission = itransmission
        self.year = iyear
        self.trunc_v = itrunc_v
        self.e_status = ie_status
        self.w_status = iw_status
        self.trunc_filled = itrunc_filled
        
    }

    convenience init //упрощенный конструктор для легковых
        (
           iv_mark: String,
           imodel: String,
           itransmission: String,
           iyear: Int)
    {
        self.init(
            iv_type: "Легковой",
            iv_mark: iv_mark,
            imodel: imodel,
            itransmission: itransmission,
            iyear: iyear,
            itrunc_v:  1500.0,
            ie_status: engine_status.off,
            iw_status: window_status.close,
            itrunc_filled: 0.0
        )
    }

    func perform(action:action){
        switch action{
            case .SwitchEngine(let status):
            e_status = status
        case .SwitchWindow(let status):
            w_status = status
        case .put_to_trunc(let volume):
            trunc_filled += volume
        case .get_from_trunc(let volume):
            self.trunc_filled -= volume
            if self.trunc_filled <= 0 {self.trunc_filled = 0}
        case .SwitchTurbo:
            return //будем переопределять
        case .AddAxle:
            return //будем переопределять
        }
    }



    func p_description()
        {

            print("Вид транспортного средства: \(v_type), Марка: \(v_mark), Модель: \(model), Коробка передач : \(transmission), год: \(year), объем багажника: \(trunc_v) литров,            статус двигателя: \(self.e_status), окна: \(self.w_status)")
    }
    
} //конец описания класса Car

class SportCar: Car {
    var turbo_pump: Bool

        let l_trunc_v:Double = 0
        let lv_type: String = "Спорткар"

    init
    (iv_mark: String,
    imodel: String,
    itransmission: String,
    iyear: Int, iturbo_pump: Bool)
    {
  
        self.turbo_pump = iturbo_pump
        print("Спорткар \(iv_mark) инициализирован. Турбонаддув: \(iturbo_pump)")
        super.init(iv_type: lv_type, iv_mark: iv_mark, imodel: imodel, itransmission: itransmission, iyear: iyear, itrunc_v: l_trunc_v,  ie_status: .off, iw_status: .close, itrunc_filled: 0.0)
   
        
    }
    
    //переопределяем функцию perform
    override func perform(action:action){
           switch action{
               case .SwitchEngine(let status):
               e_status = status
           case .SwitchWindow(let status):
               w_status = status
           case .put_to_trunc(let _):
               print ("\nПопытка изменения объема багажа не состоялась: У спорткара нет багажника")
           case .get_from_trunc(let _):
            print ("\nПопытка изменения объема багажа не состоялась: У спорткара нет багажника")
           case .SwitchTurbo(let status):
               turbo_pump = status
            case .AddAxle(let _):
             print ("\nПопытка изменения доп. оси не состоялась: У спорткара нет доп. оси")
           }
    }
    
    
    //переопределяем функцию печати
    //выводим показатель турбонаддува и не выводим ничего про кузов и ось
        override func p_description () {
        let str_turbo = self.turbo_pump==true ? "включен" : "выключен"
 
                    print("Вид транспортного средства: \(lv_type), Марка: \(v_mark), Модель: \(model), Коробка передач : \(transmission), год: \(year),          статус двигателя: \(self.e_status), окна: \(self.w_status), турбонаддув: \(str_turbo)")
    }
    
    deinit {
         print("Спорткар \(v_mark) деинициализирован.")
    }
}// class SportCar

class TruncCar: Car {
 
    //дополнительная ось
    var add_axle: Bool
    
    //будем считать грузовики
    static var trunc_count=0

           let l_trunc_v:Double = 15000
           let lv_type: String = "Грузовик"

       init
       (
       iv_mark: String,
       imodel: String,
       itransmission: String,
       iyear: Int,
       iaxle: Bool
       )
       {
     
           
           self.add_axle = iaxle
           TruncCar.trunc_count+=1
          print("Грузовик \(iv_mark) инициализирован. Всего активных грузовиков: \(TruncCar.trunc_count)")
        
           super.init(iv_type: lv_type, iv_mark: iv_mark, imodel: imodel, itransmission: itransmission, iyear: iyear, itrunc_v: l_trunc_v,  ie_status: .off, iw_status: .close, itrunc_filled: 0.0)
      
           
       }

       override func perform(action:action){
            switch action{
                case .SwitchEngine(let status):
                e_status = status
            case .SwitchWindow(let status):
                w_status = status
            case .put_to_trunc(let volume):
                trunc_filled += volume
            case .get_from_trunc(let volume):
                trunc_filled -= volume
                if trunc_filled <= 0 {trunc_filled = 0}
            case .SwitchTurbo:
                print("\nПопытка изменения турбонаддува не состоялась: У грузовиков не бывает турбонаддува")
                return
            case .AddAxle(let status):
                add_axle = status
            }
        }
 
    
    //переопределяем функцию печати
    //выводим показатель дополнительной оси и кузов
        override func p_description () {
        let str_axle  = self.add_axle==true ? "активна" : "не активна"
        var str_back:String
            if ((trunc_filled/trunc_v) <= 0.5) //хулиганство в зав. от объема загрузки двигателя
            {
                if trunc_filled == 0{
                      str_back = "кузов - пустой"
                }
                else{
                     str_back = "кузов почти пустой - в багажник загружено всего : \(trunc_filled) литров"
                }
              
            }
            else{
                str_back = "кузов заполнен - загружено: \(trunc_filled) литров"
            }
                    print ("Вид транспортного средства: \(lv_type), Марка: \(v_mark), Модель: \(model), Коробка передач : \(transmission), год: \(year), объем багажника: \(trunc_v) литров,          статус двигателя: \(self.e_status), окна: \(self.w_status), \(str_back), дополнительная ось: \(str_axle)")
    }
    
    deinit {
        TruncCar.trunc_count-=1
        print("Грузовик \(v_mark) деинициализирован. Всего активных грузовиков: \(TruncCar.trunc_count)")
    }
}// class TruncCar



//
//Тело программы, создание экземпляров
//


var HondaSportCar = SportCar(iv_mark: "Honda", imodel: "Eclipse GT", itransmission: "Automat", iyear: 2018, iturbo_pump: false)

var GhostSportCar:SportCar? //  будет опциональным
GhostSportCar = SportCar(iv_mark: "Ghost", imodel: "flying dutch", itransmission: "none", iyear: 1904, iturbo_pump: false)

var ManTruncCar = TruncCar (iv_mark: "Man", imodel: "DT-2", itransmission: "Manual", iyear: 2000, iaxle: false )

var GhostTruncCar:TruncCar? //мы его потом деининциализируем
GhostTruncCar = TruncCar(iv_mark: "Ghost", imodel: "none", itransmission: "Manual", iyear: 2000, iaxle: false )

print("\nпечатаем изначальные параметры автомобиля")
HondaSportCar.p_description()

print("\nменяем параметры")
HondaSportCar.perform(action: .SwitchEngine(Car.engine_status.on))
HondaSportCar.perform(action: .SwitchWindow(.open))
HondaSportCar.perform(action: .put_to_trunc(1000)) //должно дать ошибку
HondaSportCar.perform(action: .SwitchTurbo(true))

//у призраков меняем, но на печать выводить не будем
GhostSportCar!.perform(action: .SwitchWindow(.open))
GhostTruncCar!.perform(action: .AddAxle(true))

print("\nпечатаем измененные параметры автомобиля")
HondaSportCar.p_description()

print("\nпечатаем изначальные параметры грузовика")
ManTruncCar.p_description()

print("\nменяем параметры")
ManTruncCar.perform(action: .SwitchEngine(Car.engine_status.on))
ManTruncCar.perform(action: .SwitchWindow(Car.window_status.open))
ManTruncCar.perform(action: .put_to_trunc(1000))
ManTruncCar.perform(action: .SwitchTurbo(true)) //должно дать ошибку
ManTruncCar.perform(action: .AddAxle(true))


print("\nпечатаем измененные параметры грузовика")
ManTruncCar.p_description()

print("\nУбиваем призраков")
GhostTruncCar = nil
GhostSportCar = nil

