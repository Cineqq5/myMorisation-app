//
//  User.swift
//  TestProject
//
//  Created by Morten on 09/05/2024.
//

import Foundation

struct User:Identifiable{
    var id: Int
    var user: String
    var role: String
    
    init(i: Int, u: String, r: String){
        id = i
        user = u
        role = r
    }
}
