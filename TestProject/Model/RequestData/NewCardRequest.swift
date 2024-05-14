//
//  NewCardRequest.swift
//  TestProject
//
//  Created by Morten on 12/05/2024.
//

import Foundation

struct NewCardRequest: Encodable {
    
    let userId: Int
    let originalWord: String
    let translatedWord: String
    
}
