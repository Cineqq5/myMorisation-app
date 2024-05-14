//
//  MainMenuController.swift
//  TestProject
//
//  Created by Morten on 04/05/2024.
//

import UIKit

class MainMenuController: UIViewController{
    
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var manageAccountsButton: UIButton!
    var cards = [FlashCard]()
    
    var flashCardManager = FlashCardManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        flashCardManager.delegate = self
//        flashCardManager.getAvailableFlashCard()
//        createNotify()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        flashCardManager.getAvailableFlashCard()
//        if let role = UserDefaults.standard.string(forKey: DefaultsKeys.role){
//            manageAccountsButton.isHidden = role == "USER"
//        }
    }
    
    @IBAction func reviewButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToReview", sender: self)
    }
    @IBAction func addCardButtoneClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAddCardPage", sender: self)
    }
    @IBAction func manageCardsButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToManageCardsPage", sender: self)
    }
    @IBAction func manageAccountButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToManageAccount", sender: self)
    }
    @IBAction func logoffButtonClicked(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func manageAccountsButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToUsersManagement", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "goToManageAccount") {
          let secondView = segue.destination as! RegisterController
           secondView.accountExists = true
       }
        if (segue.identifier == "goToReview") {
           let secondView = segue.destination as! ViewController
            secondView.cards = cards
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to check your tasks!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func createNotification() {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        for weekday in 1...7{
            for hour in 0...24{
                for minute in 0...59{
                    dateComponents.weekday = weekday  // Tuesday
                    dateComponents.hour = hour    // 14:00 hours
                    dateComponents.minute = minute
                    print(dateComponents)
                    // Create the trigger as a repeating event.
                    let trigger = UNCalendarNotificationTrigger(
                        dateMatching: dateComponents, repeats: true)
                }
            }
        }

    }
    func createNotify(){
        let identifier = "my-notification"
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to check your tasks!"
        content.sound = UNNotificationSound.default
        let isDaily = true
//        let hour = 16
//        let minute = 35
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let calendar = Calendar.current
        var dateComponent = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        

        for hourInDay in 0...24{
            for minuteInHour in 0...59{
                dateComponent.hour = hourInDay  // Tuesday
                dateComponent.minute = minuteInHour    // 14:00 hours
//                print(dateComponent)
                let trigger = UNCalendarNotificationTrigger(
                    dateMatching: dateComponent, repeats: isDaily)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
                notificationCenter.add(request)
            }
        }
    }
}

extension MainMenuController: FlashCardManagerDelegate{
    func didUpdateFlashCards(_ flashCardManager: FlashCardManager, flashCards: [FlashCard]) {
        print("didUpdateFlashCards")
        DispatchQueue.main.async {
            self.cards = flashCards
            print(self.cards)
            let title = "Review: \(self.cards.count) cards"
            self.reviewButton.setTitle(title, for: .normal)
        }
    }
    
    
}
