//
//  LoginController.swift
//  TestProject
//
//  Created by Morten on 08/05/2024.
//

import UIKit

class RegisterController: UIViewController {
    
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var dailyReminderView: UIView!
    @IBOutlet weak var notificationDate: UIDatePicker!
    @IBOutlet weak var deleteButton: UIButton!
    var login: String?
    var password: String?
    var accountExists = false
    var userManager = UserManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.text = login
        userManager.delegate = self
        passwordField.text = password
        print(accountExists)
        if(accountExists){
            deleteButton.isHidden = false
            dailyReminderView.isHidden = false
//            notificationDate.isHidden = false
            
            if let login = UserDefaults.standard.string(forKey: DefaultsKeys.login) {
                loginField.text = login
                loginField.isEnabled = false
            }
        } else {
            deleteButton.isHidden = true
            dailyReminderView.isHidden = true
//            notificationDate.isHidden = true
            
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        print("delete")
        if let userId = UserDefaults.standard.string(forKey: DefaultsKeys.userId) {
            UserManager().deleteUser(userId: userId)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        guard let login = loginField.text else { return }
        guard let password = passwordField.text else { return }
        UserDefaults.standard.set(
            login,
            forKey: DefaultsKeys.login
        )
        if(accountExists){
            var userId = UserDefaults.standard.integer(forKey: DefaultsKeys.userId)
            userManager.updateUser(userId: userId,username: login, password: password)
            performSegueToReturnBack()
        } else {
            userManager.createUser(username: login, password: password)
        }
//        self.performSegue(withIdentifier: "goToMainMenu", sender: self)
    }
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        performSegueToReturnBack()
    }
    @IBAction func notificationChanged(_ sender: UISwitch) {
//        notificationDate.isHidden = !sender.isOn
        if(!sender.isOn){
            let identifier = "myFlashCardId"
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    @IBAction func createNotification(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        let hour = components.hour!
        let minute = components.minute!
        createNotify(hour: hour, minute: minute)
    }
    
    func createNotify(hour: Int, minute: Int){
        let identifier = "myFlashCardId"
        let content = UNMutableNotificationContent()
        content.title = "myFlashCard"
        content.body = "Don't forget to check your reviews!"
        content.sound = UNNotificationSound.default
        let isDaily = true
//        let hour = 16
//        let minute = 35
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let calendar = Calendar.current
        var dateComponent = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        

        dateComponent.hour = hour
        dateComponent.minute = minute
//                print(dateComponent)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponent, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
  
    }
}

extension RegisterController: UserManagerDelegate{
    func didUpdateUsers(_ userManager: UserManager, users: [User]) {
        return
    }
    
    func didVerifiedUser(_ userManager: UserManager, users: UserInfoDto) {
        
        DispatchQueue.main.async {
            if(users.userState == UserState.NOT_EXIST){
                let defaults = UserDefaults.standard
                defaults.set(
                    users.id,
                    forKey: DefaultsKeys.userId
                )
                defaults.set(
                    users.role,
                    forKey: DefaultsKeys.userRole
                )
                self.performSegue(withIdentifier: "goToMainMenu", sender: self)
            }
        }
    }
    
    
}
