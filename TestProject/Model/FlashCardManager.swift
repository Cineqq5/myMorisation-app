//
//  FlashCardManager.swift
//  TestProject
//
//  Created by Morten on 04/05/2024.
//

import Foundation


protocol FlashCardManagerDelegate {
    func didUpdateFlashCards(_ flashCardManager: FlashCardManager, flashCards: [FlashCard])
//    func didFailWithError(error: Error)
}

struct FlashCardManager{
    
    let backendURL = "https://979d-2a02-a317-223e-8e80-f8dd-caec-3fdd-1614.ngrok-free.app"
    
    var delegate: FlashCardManagerDelegate?
    
    var table = [FlashCard]()
    
    var progressToUpdate = [CardProgressUpdate]()
    
    func getRandomItem() -> FlashCard{
        return table.randomElement()!
    }
    mutating func removeFromList(flashCard: FlashCard){
        if let index = table.firstIndex(where: {$0.toTranslate == flashCard.toTranslate &&
            $0.translated == flashCard.translated}){
            table.remove(at: index)
        }
    }
    func getFlashCardData(){
        print("getFlashCardData")
        if let userId = UserDefaults.standard.string(forKey: DefaultsKeys.userId) {
            perfromRequest(urlString: backendURL+"/cards"+"/user/\(userId)")
        }
    }
    
    func getAvailableFlashCard(){
        print("getAvailableFlashCardData")
        
        if let userId = UserDefaults.standard.string(forKey: DefaultsKeys.userId) {
            perfromRequest(urlString: backendURL+"/cards/available/user/\(userId)")
        }
    }
    
    func perfromRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let flashCards = parseJSON(safeData){
                        print(flashCards)
                        print("sendingToDelegate")
                        delegate?.didUpdateFlashCards(self, flashCards: flashCards)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ flashCardData: Data) -> [FlashCard]? {
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
        do {
            let decodedData = try decoder.decode([FlashCardRecord].self, from: flashCardData)
            var flashCards = [FlashCard]()
            for decodedRecord in decodedData{
                let id = decodedRecord.id
                let translated = decodedRecord.translatedWord
                let originalWord = decodedRecord.originalWord
                flashCards.append(FlashCard(i: id, q: originalWord, a: translated))
            }
            return flashCards
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
        }
    }
    
    //-------------------------
    
    func createCard(flashCard: FlashCard){
        let requestBody = NewCardRequest(userId: 1, originalWord: flashCard.toTranslate, translatedWord: flashCard.translated)
        let data = try! JSONEncoder().encode(requestBody)
        Networking().callAPI(uri: backendURL + "/cards", requestMethod: "POST", requestBody: data)
    }
    
    func updateCard(flashCard: FlashCard){
        let updateCardRequest = UpdateCardRequest(originalWord: flashCard.toTranslate, translatedWord: flashCard.translated)
        print(updateCardRequest)
        let data = try! JSONEncoder().encode(updateCardRequest)
        print(data)
        Networking().callAPI(uri: backendURL + "/cards/\(flashCard.id)", requestMethod: "PUT", requestBody: data)
    }
    
    mutating func cardReviewed(cardId: Int, result: ResultType){
        progressToUpdate.append(CardProgressUpdate(cardId: cardId, cardResult: result))
    }
    
    func updateProgress() {
        if (!progressToUpdate.isEmpty){
            let cardsProgressToUpdateRequest = CardsProgressUpdateRequest(cardProgressUpdateDtoList: progressToUpdate)
            print(cardsProgressToUpdateRequest)
            let data = try! JSONEncoder().encode(cardsProgressToUpdateRequest)
            Networking().callAPI(uri: backendURL + "/cards/progress-update", requestMethod: "POST", requestBody: data)
        }
    }
    
    func deleteCard(cardId: Int) {

        Networking().callAPI(uri: backendURL + "/cards/\(cardId)", requestMethod: "DELETE", requestBody: nil)
    }

}
