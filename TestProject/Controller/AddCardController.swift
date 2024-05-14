//
//  AddCardController.swift
//  TestProject
//
//  Created by Morten on 05/05/2024.
//

import UIKit

class AddCardController: UIViewController {

    
    @IBOutlet weak var translatedField: UITextField!
    @IBOutlet weak var toTranslateField: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    var id: Int = 0
    var translated: String?
    var toTranslate: String?
    var cardExists = false
    override func viewDidLoad() {
        super.viewDidLoad()
        translatedField.text = translated
        toTranslateField.text = toTranslate
        deleteButton.isHidden = !cardExists
        // Do any additional setup after loading the view.
    }
    
    @IBAction func photoButtonClicked(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "takePhoto", sender: sender)
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        if(sender.titleLabel?.text! == "Submit"){
            
            print("adding")
            if(!cardExists){
                var flashCard = FlashCard(i: 0, q: toTranslateField.text ?? "", a: translatedField.text ?? "")
                var flashCardManager = FlashCardManager()
                flashCardManager.createCard(flashCard: flashCard)
            } else {
                var flashCard = FlashCard(i: id, q: toTranslateField.text ?? "", a: translatedField.text ?? "")
                var flashCardManager = FlashCardManager()
                flashCardManager.updateCard(flashCard: flashCard)
            }
        }
        if(sender.titleLabel?.text! == "Delete"){
            var flashCardManager = FlashCardManager()
            flashCardManager.deleteCard(cardId: id)
        print("deletion")
        }
        performSegueToReturnBack()
    }

}
