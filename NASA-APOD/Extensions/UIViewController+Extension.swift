//
//  UIViewController+Extension.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
