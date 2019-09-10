//
//  Alert.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//
import UIKit

struct Alert {

    private static func showAlert(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: ""), style: .default, handler: nil))
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    private static func showAlertController(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: ""), style: .default, handler: nil))
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    /**
     Action Sheet that presents from the bottom of the view

     - Parameter viewController: Presenting ViewController, typically self.
     - Parameter title: Declares the title of the alert.
     - Parameter message: Declares the message of the alert .
     - Parameter style: Defines the style of the alert (i.e. .alert, .actionSheet)
     - Parameter actions: UIAlert actions that are attached to the alert.
     */
    static func alertWithActions(on viewController: UIViewController, withTitle title: String?, message: String?, withStyle style: UIAlertController.Style, andActions actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    static func present(on viewController: UIViewController, withTitle title: String, message: String) {
        showAlert(on: viewController, with: title, message: message)
    }
}
