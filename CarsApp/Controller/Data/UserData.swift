//
//  UserData.swift
//  CarsApp
//
//  Created by Malengo on 10/05/22.
//

import Foundation

class UserData {
    
    let key = "user"
    
    func getAll() -> [UserEntity]{
        var users  =  UserDefaults.standard.object(forKey: key)
        if users == nil {
            return []
        }
        let placeData = UserDefaults.standard.object(forKey: key) as? Data
        users = try! PropertyListDecoder().decode([UserEntity].self, from: placeData!)
        
        return ( users as! [UserEntity] )
    }
    
    func salve(user: UserEntity){
        var users = getAll()
        users.append(user)
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(users), forKey: key)
    }
    func getToken() -> String{
        let users = getAll()
        var token = ""
        for i in users{
            if !i.token!.isEmpty {
                token = i.token!
                break
            }
        }
        return token
    }
}
