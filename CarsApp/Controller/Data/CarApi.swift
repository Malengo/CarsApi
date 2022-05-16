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
    var cars : [CarEntity] = []
    var urlApi = "https://carros-springboot.herokuapp.com/api/v2/carros"
    
    func getAllCar (completion: @escaping ([CarEntity]) -> Void){
       
        if (dataUser.getToken() != ""){
            let response = request.getRequest(url: urlApi, method: "GET", token: dataUser.getToken())
            URLSession.shared.dataTask(with: response){
                (dados, resposta, erro) in
                if((resposta as! HTTPURLResponse).statusCode == 200){
                    if let dadosRetornados = dados{
                        do{
                            let decoder = try JSONDecoder().decode([CarEntity].self, from: dadosRetornados)
                                self.cars = decoder
                                completion(self.cars)
                            
                        }catch{
                            print("Erro ao converter dados")
                        }
                    }
                    completion(self.cars)
                }else{
                    print("erro ao conectar ao servidor")
                }
                
            }.resume()
        } else{ print("Token vazio") }
    }
}
