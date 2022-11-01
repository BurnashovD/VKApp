// LogInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за экран входа
final class LogInViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congigUI()
        upAndDownViewAction()
    }

    // MARK: - IBActions
    
    @IBAction func checkDataAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        guard emailTextField.text == userDefaults.object(forKey: "login") as? String,
              passwordTextField.text == userDefaults.object(forKey: "password") as? String
        else { return }
        print("ALL GOOD")
    }

    // MARK: - Private methods
    
    private func congigUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }

    private func upAndDownViewAction() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil
        ) { _ in
            guard self.view.frame.origin.y >= -80 else { return }
            self.view.frame.origin.y -= 40
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil
        ) { _ in
            self.view.frame.origin.y = 0.0
        }
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
