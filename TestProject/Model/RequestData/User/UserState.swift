//
//  UserState.swift
//  TestProject
//
//  Created by Morten on 13/05/2024.
//

import Foundation

enum UserState: String, Codable{
    case ACCESS
    case EXIST_BUT_INVALID
    case NOT_EXIST
}
