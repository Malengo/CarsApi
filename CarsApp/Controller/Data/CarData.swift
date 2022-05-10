//
//  CarData.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import Foundation
class Cardata{
    let key = "car"
    
    func getAll() -> [CarEntity]{
        var cars  =  UserDefaults.standard.object(forKey: key)
        if cars == nil {
            return []
        }
        let placeData = UserDefaults.standard.object(forKey: key) as? Data
        cars = try! PropertyListDecoder().decode([CarEntity].self, from: placeData!)
        
        return ( cars as! [CarEntity] )
    }
    
    func salve(car: CarEntity){
        var cars = getAll()
        cars.append(car)
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(cars), forKey: key)
    }
}
