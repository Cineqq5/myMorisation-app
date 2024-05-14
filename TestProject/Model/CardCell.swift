//
//  CardCell.swift
//  TestProject
//
//  Created by Morten on 07/05/2024.
//

import UIKit

class CardCell: UITableViewCell{
    
    
    var delegate: myUserTableDelegate?
    @IBOutlet weak var translatedLabel: UILabel!
    
    @IBOutlet weak var toTranslateLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIImageView!
    
    @objc func deleteCard(_ sender:UITapGestureRecognizer) {
        print("yooo")
        translatedLabel.isHidden = true;
        toTranslateLabel.isHidden = true;
    }
}

protocol myUserTableDelegate {
    func myUserTableDelegate()
}
