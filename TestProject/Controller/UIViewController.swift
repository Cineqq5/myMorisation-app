//
//  UIViewController.swift
//  TestProject
//
//  Created by Morten on 07/05/2024.
//

import UIKit
extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
