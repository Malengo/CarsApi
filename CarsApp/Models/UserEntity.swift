//
//  UserEntity.swift
//  CarsApp
//
//  Created by Malengo on 09/05/22.
//

import Foundation

public class UserEntity : Codable {
    var id : Int!
    var login : String?
    var name : String?
    var email : String?
    var urlFoto : String?
    var token : String?
}
