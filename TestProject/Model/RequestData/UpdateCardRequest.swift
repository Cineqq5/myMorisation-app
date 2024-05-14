//
//  UpdateCardRequest.swift
//  TestProject
//
//  Created by Morten on 12/05/2024.
//

import Foundation
struct UpdateCardRequest: Encodable {
    
    
    let originalWord: String
    let translatedWord: String
    let imageBase64: String
    
}
