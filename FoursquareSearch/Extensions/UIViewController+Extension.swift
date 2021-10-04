//
//  UIViewController+Extension.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Something is wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
