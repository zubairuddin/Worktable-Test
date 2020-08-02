//
//  Extensions.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withTitle title: String?, andMessage message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

}

extension UIView {
    func round() {
        layer.cornerRadius = self.frame.size.height / 2
        layer.masksToBounds = true
    }
}
