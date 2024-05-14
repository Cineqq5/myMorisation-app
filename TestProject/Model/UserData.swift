//
//  UserData.swift
//  TestProject
//
//  Created by Morten on 13/05/2024.
//

import Foundation

struct UserData: Decodable{
    
    let users: [UserRecord]
}

struct UserRecord: Decodable{
    let id: Int
    var username: String
    var userType: String
//    let timeOfNextReview: Date
}
