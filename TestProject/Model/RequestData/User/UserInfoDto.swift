//
//  UserInfoDto.swift
//  TestProject
//
//  Created by Morten on 13/05/2024.
//

import Foundation

struct UserInfoDto: Codable{
    var userState: UserState
    var id: Int
    var role: String
}
