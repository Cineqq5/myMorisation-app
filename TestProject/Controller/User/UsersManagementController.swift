//
//  AllCardsManager.swift
//  TestProject
//
//  Created by Morten on 05/05/2024.
//
import UIKit

class UsersManagementController: UIViewController {
    
    var userManager = UserManager()
    @IBOutlet weak var tableView: UITableView!
    let propertyArray = [
        "user",
        "role"
    ]
    var users: [User] = []
//
//    @IBOutlet weak var cardsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
        users = userManager.table
        
        userManager.delegate = self
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.deleteCard(_:)))
//        tableView.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
//        cardsTable.delegate = self
//        cardsTable.dataSource = self
        // Do any additional setup after loading the view.
//        cardsTable.dataSource = userManager.table
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userManager.getUserData()
    }
    
}

extension UsersManagementController: UITableViewDataSource, UITableViewDelegate, UserManagerDelegate {
    func didUpdateUsers(_ userManager: UserManager, users: [User]) {
        print("delivered")
        DispatchQueue.main.async {
            
            self.users = users
            print(userManager.table)
            self.tableView.reloadData()
        }
    }
    
    func didVerifiedUser(_ userManager: UserManager, users: UserInfoDto) {
        return
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        userManager.table[]
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.userLabel.text = user.user
        cell.setPopupButton(role: user.role)
        
        
//        let gesture = UITapGestureRecognizer(target: self, action:  Selector(("didSwipe")))
//        cell.deleteButton.addGestureRecognizer(gesture)
        
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sender: [String: Any?] = ["translatedField": cards[indexPath.row].translated, "toTranslateField": cards[indexPath.row].toTranslate]
//        self.performSegue(withIdentifier: "goToChangeCardPage", sender: sender)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       if (segue.identifier == "goToChangeCardPage") {
//          let secondView = segue.destination as! AddCardController
//          let object = sender as! [String: Any?]
//        secondView.translated = object["translatedField"] as? String
//        secondView.toTranslate = object["toTranslateField"] as? String
//           secondView.deletable = true
//       }
//    }
//    @objc func deleteCard(_ sender:UITapGestureRecognizer) {
//
//        print("yoo")
//    }
    
    
    
    
}
