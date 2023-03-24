//
//  UserApi.swift
//  CarsApp
//
//  Created by Malengo on 15/05/22.
//

import Foundation

class UserApi{
    
    var requestAPI = RequestApi()
    var userData = UserData()
    var urlApi : String = "https://carros-springboot.herokuapp.com/api/v2/login"

    
    func getUserApi(_ userLogin: LoginEntity) async -> Bool {
        
        guard var request = requestAPI.setupRequest(url: urlApi, method: "POST", token: "") else { return false }
        
        do {
            try request.httpBody = JSONEncoder().encode(userLogin)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                let decoder = try JSONDecoder().decode(UserEntity.self, from: data)
                var user = UserEntity()
                user = decoder
                userData.salve(user: user)
                return true
            }
        } catch {
            return false
        }
        return false
    }
}
