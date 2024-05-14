//
//  TextLocalization.swift
//  TestProject
//
//  Created by Morten on 14/05/2024.
//

import UIKit

// MARK: Localizable
public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

// MARK: XIBLocalizable
public protocol XIBLocalizable {
    var localeKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable public var localeKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable public var localeKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}

// MARK: Special protocol to localizaze UI's placeholder
public protocol UIPlaceholderXIBLocalizable {
    var localePlaceholderKey: String? { get set }
}

extension UITextField: UIPlaceholderXIBLocalizable {

    @IBInspectable public var localePlaceholderKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }

}

extension UISearchBar: UIPlaceholderXIBLocalizable {

    @IBInspectable public var localePlaceholderKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }

}

