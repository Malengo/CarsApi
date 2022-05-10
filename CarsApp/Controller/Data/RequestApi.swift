//
//  RequestApi.swift
//  CarsApp
//
//  Created by Malengo on 09/05/22.
//

import Foundation
class  RequestApi{
    
    func getRequest(url : String, method: String, token: String) -> URLRequest{
        var request = URLRequest(url: URL(string :url)!)
        request.httpMethod = method
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
}
