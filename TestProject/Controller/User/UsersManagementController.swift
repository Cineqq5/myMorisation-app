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
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        cell.setPopupButton(user: users[indexPath.row].id, role: user.role)
        return cell
    }
    
}
