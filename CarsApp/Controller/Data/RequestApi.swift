//
//  RequestApi.swift
//  CarsApp
//
//  Created by Malengo on 09/05/22.
//

import Foundation
class  RequestApi{
    
    func setupRequest(url : String, method: String, token: String) -> URLRequest? {
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
        return nil
    }
    
    
}
