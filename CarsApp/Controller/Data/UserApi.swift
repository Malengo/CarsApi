//
//  UserApi.swift
//  CarsApp
//
//  Created by Malengo on 15/05/22.
//

import Foundation
class UserApi{
    var request = RequestApi()
    var userData = UserData()
    var urlApi : String = "https://carros-springboot.herokuapp.com/api/v2/login"

    
    func getUserApi(_ login: String, _ password: String) -> Bool {
        var complete = true
        var response = request.getRequest(url: urlApi, method: "POST", token: "")
        let userLogin = LoginEntity();
        
        userLogin.username = login
        userLogin.password = password
        
        do {
            try response.httpBody = JSONEncoder().encode(userLogin)
        } catch {
            print ("Erro ao converter")
        }
        let tarefa =  URLSession.shared.dataTask(with: response){ [self]
            (dados, resposta, erro) in
            if((resposta as! HTTPURLResponse).statusCode == 200){
                
                if let dadosRetornados = dados{
                    do{
                        let decoder = try JSONDecoder().decode(UserEntity.self, from: dadosRetornados)
                        var user = UserEntity()
                        user = decoder
                        userData.salve(user: user)
                       
                    }catch{
                        print("Erro ao converter dados")
                    }
                    
                }
            }else{
                complete = false
                print("erro")
            }
            
        }
        
        tarefa.resume()
        return complete
    }
    
}
