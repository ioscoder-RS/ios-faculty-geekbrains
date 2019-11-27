//
//  main.swift
//  5L_RaskinSergey
//
//  Created by raskin-sa on 27/11/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

//Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//Создать два класса, имплементирующих протокол «Car»: tunkCar и sportCar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//Для каждого класса написать расширение, имплементирующее протокол «CustomStringConvertible».
//Создать несколько объектов каждого класса. Применить к ним различные действия.
//Вывести сами объекты в консоль.

protocol Car{
   var engine_status:Bool{get set}
    var door_status:Bool{get set}
    var petrol_in:Double{get set}

    func switch_door(iflag:Bool)//открывает/закрывает двери
    
}

//добавляем функцию вкл/выкл двигател
extension Car {
     mutating func switch_engine(iflag:Bool){
       
        if iflag == true {
 engine_status = false
    }
        else{
            engine_status = true
        }
}
}

//добавляем функцию заливки бензина
extension Car{
    mutating func fill_petrol(ipetrol:Double){
        petrol_in += ipetrol
    }
}

//добавляем extension, имплементирующее протокол «CustomStringConvertible»
protocol consolePrintable:CustomStringConvertible {
    func printDescription()
    }

extension consolePrintable{
    func printDescription(){
        print(description)
    }
}

class Sportcar : Car, consolePrintable{

    var engine_status: Bool=true
    var door_status:Bool=false
    var petrol_in:Double=0
    
    func switch_door(iflag: Bool) {
        door_status = (iflag == true ? false : true)
    }
    
    var description: String {
        return String(describing: "Вид транспортного средства: \(v_type), Модель: \(v_model), статус двигателя: \(engine_status == true ? "запущен":"заглушен"), статус дверей: \(door_status == true ? "открыты": "закрыты"), залито бензина: \(petrol_in) литров, количество людей: \(people_count)")
    }
    
    var people_count:Int = 0
    let v_type:String="автомобиль"
    var v_model:String
    
    init(iv_model:String, ie_status:Bool, id_status: Bool, i_petrol:Double, i_people:Int){
        self.v_model = iv_model
        self.engine_status = ie_status
        self.door_status = id_status
        self.petrol_in = i_petrol
        self.people_count = i_people
    }
    
//    convenience init(iv_model:String)
//    {
//        self.init(iv_model: iv_model)
//    }
    
    func change_people(ip_count:Int)  {
        people_count += ip_count
    }
    
    
}//class sportcar

//цистерны
class Tunkcar : Car, consolePrintable{

    var engine_status: Bool=true
    var door_status:Bool=false
    var petrol_in:Double=0
    
    func switch_door(iflag: Bool) {
     
        door_status = (iflag == true ? false : true)

    }
    
    var description: String {
          return String(describing: "Вид транспортного средства: \(v_type), Модель: \(v_model), статус двигателя: \(engine_status == true ? "запущен":"заглушен"), статус дверей: \(door_status == true ? "открыты": "закрыты"), залито бензина: \(petrol_in) литров, залито в цистерну: \(tunk_filled)")
      }
    
    var tunk_filled:Int = 0 //литров вещества в цистерне
    let v_type:String="цистерна"
    var v_model:String
    
    init(iv_model:String, ie_status:Bool, id_status: Bool, i_petrol:Double, i_tunkfilled:Int){
        self.v_model = iv_model
        self.engine_status = ie_status
        self.door_status = id_status
        self.petrol_in = i_petrol
        self.tunk_filled = i_tunkfilled
    }
    
    func fill_tunk(fill_volume:Int) {
        tunk_filled += fill_volume
    }
    
    func p_description()
     {
         print ("Вид транспортного средства: \(v_type), Модель: \(v_model), статус двигателя: \(engine_status), статус дверей: \(door_status), залито бензина: \(petrol_in) литров, залито в цистерну: \(tunk_filled)")
     }
}//class Tunkcar






//выводим информацию о легковом автомобиле

var honda = Sportcar(iv_model:"Honda",ie_status: false, id_status: false, i_petrol: 0, i_people: 0)
print("начальные параметры \(honda.v_model)")
honda.printDescription()
print("\nзаливаем бензин")
honda.fill_petrol(ipetrol:50)
//печатаем что получилось
honda.printDescription()

var ferrari = Sportcar(iv_model:"Ferrari",ie_status: true, id_status: true, i_petrol: 0, i_people: 1)
print("\nначальные параметры \(ferrari.v_model)")
ferrari.printDescription()
print("\nвыключаем двигатель, глушим мотор, подсаживаем 3-х человек")
ferrari.switch_door(iflag:true)
ferrari.switch_engine(iflag:true)
ferrari.change_people(ip_count: 3)
ferrari.printDescription()

var man = Tunkcar(iv_model: "Man", ie_status: false, id_status: false, i_petrol: 0, i_tunkfilled: 0)
print("\nначальные параметры \(man.v_model)")
man.printDescription()
print("\nоткрываем двери, включаем двигатель, заливаем бензин, наполняем цистерну")
man.fill_petrol(ipetrol:50)
man.switch_door(iflag:false)
man.switch_engine(iflag:false)
man.fill_tunk(fill_volume: 500)
//печатаем что получилось
man.printDescription()
