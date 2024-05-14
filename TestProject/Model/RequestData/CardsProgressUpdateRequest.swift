//
//  CardsProgressUpdateRequest.swift
//  TestProject
//
//  Created by Morten on 13/05/2024.
//

import Foundation

struct CardsProgressUpdateRequest: Encodable {
    
    let cardProgressUpdateDtoList: [CardProgressUpdate]
    
    
}

struct CardProgressUpdate: Encodable {
    
    let cardId: Int
    let cardResult: ResultType
}
