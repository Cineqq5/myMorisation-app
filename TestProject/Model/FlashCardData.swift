//
//  FlashCardData.swift
//  TestProject
//
//  Created by Morten on 05/05/2024.
//

import Foundation

struct FlashCardData: Decodable{
    let flashCards: [FlashCardRecord]
}

struct FlashCardRecord: Decodable{
    let id: Int
    let userId: Int
    let originalWord: String
    let translatedWord: String
    let progress: Int
    let imageBase64: String
//    let timeOfNextReview: Date
}
