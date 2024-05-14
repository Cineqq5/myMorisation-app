//
//  ViewController.swift
//  TestProject
//
//  Created by Morten on 02/05/2024.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var toTranslate: UILabel!
    @IBOutlet weak var translated: UILabel!
    
    @IBOutlet weak var translateView: UIView!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    
    var flashCardManager = FlashCardManager()
    var cards = [FlashCard]()
    
    var element = FlashCard(i: 0, q: "", a: "")
    override func viewDidLoad() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.showAnswer(_:)))
        translateView.addGestureRecognizer(gesture)
        super.viewDidLoad()
        resetView()
        // Do any additional setup after loading the view.
    }
    
    func resetView(){
        print(cards.count)
        if(cards.count > 0)
        {
            
            element = cards.randomElement()!
            print(element)
            toTranslate.text = element.toTranslate
            translated.text = element.translated
            translated.isHidden = true;
            correctButton.isHidden = true;
            incorrectButton.isHidden = true;
        } else {
//            self.dismiss(animated: true, completion: nil)
            performSegueToReturnBack()
        }
    }

    @objc func showAnswer(_ sender:UITapGestureRecognizer) {
        
        translated.isHidden = false;
        correctButton.isHidden = false;
        incorrectButton.isHidden = false;
    }
    @IBAction func answerCheckButton(_ sender: UIButton) {
//        flashCardManager.removeFromList(flashCard: element)
        cards.removeAll { flashCard in
            element.id == flashCard.id
        }
        if(sender.titleLabel?.text! == "Correct"){
            flashCardManager.cardReviewed(cardId: element.id, result: ResultType.SUCCESS)
        }
        else{
            flashCardManager.cardReviewed(cardId: element.id, result: ResultType.FAIL)
        }
        resetView()
//            self.dismiss(animated: true, completion: nil)
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        flashCardManager.updateProgress()
        super.viewWillDisappear(animated)
        
    }
    
    
}


