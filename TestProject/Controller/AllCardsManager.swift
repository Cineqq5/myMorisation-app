//
//  AllCardsManager.swift
//  TestProject
//
//  Created by Morten on 05/05/2024.
//
import UIKit

class AllCardsManager: UIViewController {
    
    var flashCardManager = FlashCardManager()
    @IBOutlet weak var tableView: UITableView!
    let propertyArray = [
        "toTranslate",
        "Translated"
    ]
    var cards: [FlashCard] = []
//
//    @IBOutlet weak var cardsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
//        flashCardManager.fetchFlashCardsFromAPI()
        flashCardManager.delegate = self
//        flashCardManager.getFlashCardData()
        cards = flashCardManager.table
//        cards = flashCardManager.table
        
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.deleteCard(_:)))
//        tableView.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
//        cardsTable.delegate = self
//        cardsTable.dataSource = self
        // Do any additional setup after loading the view.
//        cardsTable.dataSource = flashCardManager.table
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flashCardManager.getFlashCardData()
    }
    
}

extension AllCardsManager: UITableViewDataSource, UITableViewDelegate, FlashCardManagerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count")
        return cards.count
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        flashCardManager.table[]
        let card = cards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.toTranslateLabel.text = card.toTranslate
        cell.translatedLabel.text = card.translated
        
//        let gesture = UITapGestureRecognizer(target: self, action:  Selector(("didSwipe")))
//        cell.deleteButton.addGestureRecognizer(gesture)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender: [String: Any?] = ["id": cards[indexPath.row].id, "translatedField": cards[indexPath.row].translated, "toTranslateField": cards[indexPath.row].toTranslate, "imageBase64": cards[indexPath.row].imageBase64]
        self.performSegue(withIdentifier: "goToChangeCardPage", sender: sender)
    }
    
    func didUpdateFlashCards(_ flashCardManager: FlashCardManager, flashCards: [FlashCard]){
        print(flashCards)
        DispatchQueue.main.async {
            self.cards = flashCards
            self.tableView.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "goToChangeCardPage") {
          let secondView = segue.destination as! AddCardController
          let object = sender as! [String: Any?]
           secondView.id = object["id"] as! Int
        secondView.translated = object["translatedField"] as? String
        secondView.toTranslate = object["toTranslateField"] as? String
        secondView.imageBase64 = object["imageBase64"] as? String
           secondView.cardExists = true
       }
    }
//    @objc func deleteCard(_ sender:UITapGestureRecognizer) {
//        
//        print("yoo")
//    }
    
    
    
}
