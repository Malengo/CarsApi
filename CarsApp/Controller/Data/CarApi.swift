//
//  CarApi.swift
//  CarsApp
//
//  Created by Malengo on 14/05/22.
//

import Foundation
class CarApi {
    var dataUser = UserData()
    var request = RequestApi()
    var urlApi = "https://carros-springboot.herokuapp.com/api/v2/carros"
    
    func getAllCar () async throws -> [CarEntity] {
        var cars: [CarEntity] = []
        if dataUser.getToken() != "" {
            guard let request = request.setupRequest(url: urlApi, method: "GET", token: dataUser.getToken()) else {
                throw NSError(domain: "", code: 3)
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let _ = response as? HTTPURLResponse else { throw NSError(domain: "Request error", code: 2) }
            cars = try JSONDecoder().decode([CarEntity].self, from: data)
            
            } else {
                print("Token vazio")
            }
        return cars
    }
}
