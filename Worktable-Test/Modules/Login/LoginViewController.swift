//
//  ViewController.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import UIKit
protocol LoginViewProtocol: class {
    func loginFailed(withError error: String)
    func loginSuccess(result: LoginResponse)
    func showErrorAlert(withError error: String)
}

class LoginViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: Presenter
    lazy var presenter: LoginPresenter = {
        let presenter = LoginPresenter(view: self)
        return presenter
    }()

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //MARK: Actions
    @IBAction func loginAction(_ sender: Any) {
        presenter.login(withUsername: txtUsername.text!, andPassword: txtPassword.text!)
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginSuccess(result: LoginResponse) {
        DispatchQueue.main.async {
            if let arr = result.body {
                let vc = AppStoryboard.main.viewController(viewControllerClass: TreeViewController.self)
                vc.arrCustomers = arr
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func loginFailed(withError error: String) {
        DispatchQueue.main.async {
            self.showAlert(withTitle: error, andMessage: nil)
        }
        
    }
    
    func showErrorAlert(withError error: String) {
        DispatchQueue.main.async {
            self.showAlert(withTitle: error, andMessage: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            txtPassword.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
