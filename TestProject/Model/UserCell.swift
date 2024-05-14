//
//  UserCell.swift
//  TestProject
//
//  Created by Morten on 09/05/2024.
//

import UIKit

class UserCell: UITableViewCell{
    
    
    var delegate: myTableDelegate?
    @IBOutlet weak var roleButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    func setPopupButton(user: Int, role: String){
        let optionClosure = {(action: UIAction) in UserManager().updateUserRole(userId: user, role: action.title)}
        var isAdmin = role == "ADMIN"
        roleButton.menu = UIMenu(children: [
            UIAction(title: "Admin", 
                     state : isAdmin ? .on : .off ,
                     handler: optionClosure),
        UIAction(title: "User", 
                 state : isAdmin ? .off : .on ,
                 handler: optionClosure),
        ])
        
        roleButton.showsMenuAsPrimaryAction = true
        roleButton.changesSelectionAsPrimaryAction = true
        var userId = UserDefaults.standard.integer(forKey: DefaultsKeys.userId)
        roleButton.isEnabled = userId != user
//        roleButton.menu?.children.randomElement()
    }
//    func updateRole(
}
//
protocol myTableDelegate {
    func myTableDelegate()
}
