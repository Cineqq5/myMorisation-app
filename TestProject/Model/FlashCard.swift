//
//  FlashCard.swift
//  TestProject
//
//  Created by Morten on 04/05/2024.
//

import Foundation

struct FlashCard:Identifiable{
    var id: Int
    var toTranslate: String
    var translated: String
    
    init(i: Int, q: String, a: String){
        id = i
        toTranslate = q
        translated = a
    }
}
