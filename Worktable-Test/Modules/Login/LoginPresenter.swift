//
//  LoginPresenter.swift
//  Worktable-Test
//
//  Created by Zubair on 27/07/20.
//  Copyright © 2020 Zubair. All rights reserved.
//

import Foundation
enum ValidationState {
    case valid
    case invalid(String)
}

class LoginPresenter: NSObject {
    private weak var view: LoginViewProtocol!
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func login(withUsername username: String, andPassword password: String) {
        //view.showLoader(withStatus: "Logging-in...")
        let validationResult = validateInput(username: username, password: password)
        switch validationResult {
        case .valid:
            
            //Call Login API
            let loginRequest = LoginRequest(username: username, password: password)
            
            do {
                let data = try JSONEncoder().encode(loginRequest.self)
                APIManager.executeRequest(httpMethod: .post, url: loginUrl, body: data) { [weak self](response) in
                    //Avoid retain cycle by capturing self
                    //print(response)
                    switch response {
                    case .success(let result):
                        self?.view.loginSuccess(result: result)
                    case .failure(let error):
                        self?.view.loginFailed(withError: error)
                    }
                }
            }
            
            catch let error {
                self.view.showErrorAlert(withError: error.localizedDescription)
            }
            
        case .invalid(let error):
            view.showErrorAlert(withError: error)
        }
    }
    
    func validateInput(username: String, password: String) -> ValidationState
    {
        if username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .invalid("Username can't be empty")
        }
        else if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .invalid("Password can't be empty")
        }
        return .valid
    }
}
